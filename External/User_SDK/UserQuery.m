//
//  UserQuery.m
//  EZTV
//
//  Created by Lee, Bo on 16/1/31.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import "UserQuery.h"
#import "UserCenter.h"
#import "UserClient.h"
#import "AppConfig.h"

@implementation UserQuery

+ (AFHTTPRequestOperation *)registerUserWithUId:(NSString *)uId password:(NSString *)password nickname:(NSString *)nickname checkCode:(NSString *)checkCode completion:(void (^)(ResponseModel *, NSError *))completion
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceToken];
    if (ISEMPTYSTR(token)) {
        token = @"";
    }
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            uId, @"mpno",
                            password, @"password",
                            nickname, @"nickname",
                            @"AppStore", @"channel",
                            token, @"token",
                            @"IOS", @"os",
                            APP_BUILDVER, @"ver",nil];
    if (!ISEMPTYSTR(checkCode)) {
        params = [params mtl_dictionaryByAddingEntriesFromDictionary:@{@"checkcode": checkCode}];
    }
    return [[UserClient newClient] POST:@"user/register" parameters:params resultClass:[ResponseModel class]
              resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if ([responseObject isKindOfClass:[ResponseModel class]]) {
                    if ([(ResponseModel *)responseObject success]) {
                        UserInfo *logined = [[UserInfo alloc] initWithMpno:uId];
                        logined.userCookie = [[operation.response allHeaderFields] objectForKey:@"Set-Cookie"];
                        [UserCenter defaultCenter].currentUser = logined;
                        [[UserCenter defaultCenter] saveUserInfo];
                    }
                }
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

+ (AFHTTPRequestOperation *)loginWithUId:(NSString *)uId password:(NSString *)password completion:(void (^)(ResponseModel *, NSError *))completion
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceToken];
    if (ISEMPTYSTR(token)) {
        token = @"";
    }
    NSDictionary *params = @{@"mpno": uId,
                             @"password": password,
                             @"token": token,
                             @"longitude": @"",
                             @"latitude": @"",
                             @"os": @"IOS",
                             @"ver": APP_BUILDVER};
    return [[UserClient newClient] POST:@"user/login" parameters:params resultClass:[ResponseModel class]
              resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if ([responseObject isKindOfClass:[ResponseModel class]]) {
                    if ([(ResponseModel *)responseObject success]) {
                        UserInfo *logined = [[UserInfo alloc] initWithMpno:uId];
                        logined.userCookie = [[operation.response allHeaderFields] objectForKey:@"Set-Cookie"];
                        [UserCenter defaultCenter].currentUser = logined;
                        [[UserCenter defaultCenter] saveUserInfo];
                    }
                }
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

+ (AFHTTPRequestOperation *)authCheckWithOpenId:(NSString *)openid nickName:(NSString *)nickName headImgUrl:(NSString *)headImgUrl province:(NSString *)province gender:(NSString *)gender fromAuth:(AuthFromType)fromAuth completion:(void (^)(ResponseModel *, NSError *))completion
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceToken];
    if (ISEMPTYSTR(token)) {
        token = @"";
    }
    NSDictionary *params = @{@"openid": openid,
                             @"nickname": nickName,
                             @"headurl": headImgUrl,
                             @"province": province,
                             @"gender": gender,
                             @"fromauth": @(fromAuth),
                             @"channel": @"AppStore",
                             @"token": token,
                             @"os": @"IOS",
                             @"ver": APP_BUILDVER};
    return [[UserClient newClient] POST:@"user/authcheck" parameters:params resultClass:[ResponseModel class]
              resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if ([responseObject isKindOfClass:[ResponseModel class]]) {
                    if ([(ResponseModel *)responseObject success]) {
                        UserInfo *logined = [[UserInfo alloc] initWithMpno:openid];
                        logined.userCookie = [[operation.response allHeaderFields] objectForKey:@"Set-Cookie"];
                        [UserCenter defaultCenter].currentUser = logined;
                        [[UserCenter defaultCenter] saveUserInfo];
                    }
                }
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

+ (AFHTTPRequestOperation *)pullUserInfo:(void (^)(UserModel *, NSError *))completion
{
    NSDictionary *params = @{@"os": @"IOS",
                             @"ver": APP_BUILDVER};
    if (!ISEMPTYSTR([AppConfig sharedConfig].travelFrom)) {
        params = [params mtl_dictionaryByAddingEntriesFromDictionary:
                  @{@"targetfrom": [AppConfig sharedConfig].travelFrom}];
        [AppConfig sharedConfig].travelFrom = nil;
        //只发送一次
    }
    UserClient *newClient = [[UserClient alloc] init];
    [newClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [newClient POST:@"user/info" parameters:params resultClass:[UserModel class]
              resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
                if (responseObject && [responseObject isKindOfClass:[UserModel class]])
                {
                    UserModel *result = responseObject;
                    if (result.success) {
                        UserInfo *current = [UserCenter defaultCenter].currentUser;
                        if (!current) {
                            current = [[UserInfo alloc] initWithMpno:result.mpno];
                        }
                        current.userCookie = [[operation.response allHeaderFields] objectForKey:@"Set-Cookie"];
                        [current fillWithUser:result];
                        current.headImgUri = [UserCenter getImgUrlByID:current.imgId];
                        [[UserCenter defaultCenter] saveUserInfo];
                    } else {
                        [[UserCenter defaultCenter] logoutCurrentUser];
                    }
                }
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

+ (AFHTTPRequestOperation *)logoutWithCompletion:(void (^)(ResponseModel *, NSError *))completion
{
    [[UserCenter defaultCenter] logoutCurrentUser];
    NSDictionary *params = @{@"os": @"IOS",
                             @"ver": APP_BUILDVER};
    UserClient *newClient = [[UserClient alloc] init];
    [newClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [newClient POST:@"user/logout" parameters:params
                resultClass:[ResponseModel class] resultKeyPath:nil
                 completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

+ (AFHTTPRequestOperation *)setUserInfoWithKey:(NSString *)key value:(NSString *)value completion:(void (^)(ResponseModel *, NSError *))completion
{
    NSDictionary *params = @{@"key": key,
                             @"value": value,
                             @"os": @"IOS",
                             @"ver": APP_BUILDVER};
    
    UserClient *newClient = [[UserClient alloc] init];
    [newClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [newClient POST:@"user/setval" parameters:params resultClass:[ResponseModel class]
              resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

+ (AFHTTPRequestOperation *)setUserInfoWithDic:(NSDictionary *)params completion:(void (^)(ResponseModel *, NSError *))completion
{
    NSDictionary *reqParams = @{@"os": @"IOS",
                             @"ver": APP_BUILDVER};
    reqParams = [reqParams mtl_dictionaryByAddingEntriesFromDictionary:params];
    
    UserClient *newClient = [[UserClient alloc] init];
    [newClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [newClient POST:@"user/setvals" parameters:reqParams resultClass:[ResponseModel class]
              resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

+ (AFHTTPRequestOperation *)changePassword:(NSString *)oldPassword newPassword:(NSString *)newPassword completion:(void (^)(ResponseModel *, NSError *))completion
{
    NSDictionary *params = @{@"oldpassword": oldPassword,
                             @"newpassword": newPassword,
                             @"os": @"IOS",
                             @"ver": APP_BUILDVER};
    UserClient *newClient = [[UserClient alloc] init];
    [newClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [newClient POST:@"user/changepassword" parameters:params
                resultClass:[ResponseModel class] resultKeyPath:nil
                 completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

+ (AFHTTPRequestOperation *)findPasswordWithMpno:(NSString *)mpno password:(NSString *)password checkCode:(NSString *)checkCode completion:(void (^)(ResponseModel *, NSError *))completion
{
    NSDictionary *params = @{@"mpno": mpno,
                             @"newpassword": password,
                             @"checkcode": checkCode,
                             @"os": @"IOS",
                             @"ver": APP_BUILDVER};
    UserClient *newClient = [[UserClient alloc] init];
    [newClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [newClient POST:@"user/findpassword" parameters:params
                resultClass:[ResponseModel class] resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

+ (AFHTTPRequestOperation *)getAdPicListWithCompletion:(void (^)(PicAdListModel *, NSError *))completion
{
    NSDictionary *params = @{@"os": @"IOS",
                             @"ver": APP_BUILDVER};
    return [[UserClient newClient] POST:@"adv/adpiclist" parameters:params
                resultClass:[PicAdListModel class] resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

+ (AFHTTPRequestOperation *)getActivityListWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize completion:(void (^)(ActivityListModel *, NSError *))completion
{
    NSDictionary *params = @{@"pageindex": @(pageIndex),
                             @"pageSize": @(pageSize),
                             @"os": @"IOS",
                             @"ver": APP_BUILDVER};
    UserClient *newClient = [[UserClient alloc] init];
    [newClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [newClient POST:@"activity/list" parameters:params
                resultClass:[ActivityListModel class] resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

+ (AFHTTPRequestOperation *)getActivityDetailWithId:(NSInteger)activityId completion:(void (^)(ActivityDetailModel *, NSError *))completion
{
    NSDictionary *params = @{@"activityid": @(activityId),
                             @"os": @"IOS",
                             @"ver": APP_BUILDVER};
    UserClient *newClient = [[UserClient alloc] init];
    [newClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [newClient POST:@"activity/detail" parameters:params
                resultClass:[ActivityDetailModel class] resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

+ (AFHTTPRequestOperation *)getNextActivityDetailWithId:(NSInteger)activityId kind:(NSInteger)kind completion:(void (^)(ActivityDetailModel *, NSError *))completion
{
    NSDictionary *params = @{@"activityid": @(activityId),
                             @"kind": @(kind),
                             @"os": @"IOS",
                             @"ver": APP_BUILDVER};
    UserClient *newClient = [[UserClient alloc] init];
    [newClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [newClient POST:@"activity/skip" parameters:params
                resultClass:[ActivityDetailModel class] resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

+ (AFHTTPRequestOperation *)getSuperTotalWithTvId:(NSInteger)tvId completion:(void (^)(SuperTotalModel *, NSError *))completion
{
    NSDictionary *params;
    if (tvId < 0) {
        params = @{@"os": @"IOS",
                   @"ver": APP_BUILDVER};
    } else {
        params = @{@"tvid": @(tvId),
                   @"os": @"IOS",
                   @"ver": APP_BUILDVER};
    }
    UserClient *newClient = [[UserClient alloc] init];
    [newClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [newClient POST:@"user/supertotal" parameters:params
                resultClass:[SuperTotalModel class] resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

+ (AFHTTPRequestOperation *)getParticipantWithTvId:(NSInteger)tvId completion:(void (^)(ParticipantModel *, NSError *))completion
{
    NSDictionary *params = @{@"tvid": @(tvId),
                             @"os": @"IOS",
                             @"ver": APP_BUILDVER};
    UserClient *newClient = [[UserClient alloc] init];
    [newClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [newClient POST:@"shake/currenttotal" parameters:params
                resultClass:[ParticipantModel class] resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

+ (AFHTTPRequestOperation *)shakeRequestWithTvId:(NSInteger)tvId activityId:(NSInteger)activityId completion:(void (^)(ShakeModel *, NSError *))completion
{
    NSDictionary *params = @{@"tvid": @(tvId),
                             @"activityid": @(activityId),
                             @"os": @"IOS",
                             @"ver": APP_BUILDVER};
    UserClient *newClient = [[UserClient alloc] init];
    [newClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [newClient POST:@"shake/request" parameters:params
                resultClass:[ShakeModel class] resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

+ (AFHTTPRequestOperation *)getSMSCodeWithPhoneNo:(NSString *)phoneNo smsType:(SMSType)type completion:(void (^)(ResponseModel *, NSError *))completion
{
    NSDictionary *params = @{@"mpno": phoneNo,
                             @"os": @"IOS",
                             @"ver": APP_BUILDVER};
    NSString *path;
    switch (type) {
        case SMSTypeRegisterUser:
        {
            path = @"user/sendregistercheckcode";
        }
            break;
        case SMSTypeForgetPassword:
        {
            path = @"user/sendfindpasswordcheckcode";
        }
            break;
        case SMSTypeModifyPassword:
        {
            path = @"user/sendmodifyphonecheckcode";
        }
            break;
    }
    return [[UserClient newClient] POST:path parameters:params
                            resultClass:[ResponseModel class] resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

@end
