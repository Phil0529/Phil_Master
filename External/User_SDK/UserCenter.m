//
//  UserCenter.m
//  EZTV
//
//  Created by Sunni on 15/7/9.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "UserCenter.h"
#import "TMCache.h"
#import "UMessage.h"
#import "AppConfig.h"
#import "UserQuery.h"
#import "APPSQuery.h"
#import <RongIMLib/RongIMLib.h>

NSString* const cookieKey = @"Cookie";

NSString* const keyHeadImg = @"img";
NSString* const keyNick = @"nickname";
NSString* const keyGender = @"gender";
NSString* const keyPhone = @"phone";
NSString* const keyBirthday = @"birthday";

static NSString* dataKey = @"usercookies1.data";

@implementation UserCenter

@synthesize currentUser = _currentUser;

+ (UserCenter *)defaultCenter
{
    static UserCenter *_sharedCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedCenter = [[UserCenter alloc] init];
    });
    return _sharedCenter;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _currentUser = [[TMCache sharedCache] objectForKey:dataKey];
    }
    return self;
}

+ (NSString *)getImgUrlByID:(NSString *)imgId
{
    return [NSString stringWithFormat:@"%@user/headimg?img=%@", [AppConfig sharedConfig].userPath, imgId];
}

+ (NSString *)getActivityImgUrlById:(NSInteger)activityId
{    
    return [NSString stringWithFormat:@"%@activity/activityimg?activityid=%ld&utc=%f", [AppConfig sharedConfig].userPath, (long)activityId, [[NSDate date] timeIntervalSince1970]];
}

- (void)pullInfoWhenAPPLaunch
{
    [UserQuery pullUserInfo:^(UserModel *user, NSError *error) {
        if (user.success) {
            if ([self isLogined]) {
                [APPSQuery getUserTokenWithId:_currentUser.mpno name:_currentUser.nickName picurl:_currentUser.headImgUri completion:^(TokenModel *token, NSError *error) {
                    [[RCIMClient sharedRCIMClient] connectWithToken:token.token success:^(NSString *userId)
                     {
                         SWLogD(@"Rong cloud connect ok");
                     } error:^(RCConnectErrorCode status)
                     {
                         SWLogD(@"Rong cloud connect error");
                     } tokenIncorrect:^
                     {
                         SWLogD(@"Rong cloud connect error token");
                     }];
                }];
            }
        }
    }];
}

- (BOOL)isLogined
{
    return !ISEMPTYSTR([self userCookie]);
}

- (void)logoutCurrentUser
{
    if (!ISEMPTYSTR(_currentUser.mpno)) {
        [UMessage removeAlias:_currentUser.mpno type:kUMessageAliasTypeQQ response:nil];
    }
    _currentUser = nil;
    [[TMCache sharedCache] removeObjectForKey:dataKey];
}

- (NSString *)userCookie
{
    return _currentUser.userCookie;
}

- (void)saveUserInfo
{
    [[TMCache sharedCache] setObject:_currentUser forKey:dataKey block:nil];
}

@end
