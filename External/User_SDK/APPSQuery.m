//
//  APPSQuery.m
//  EZTV
//
//  Created by Lee, Bo on 16/1/31.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import "APPSQuery.h"
#import "UserCenter.h"
#import "APPSClient.h"

@implementation APPSQuery

+ (AFHTTPRequestOperation *)getUserTokenWithId:(NSString *)userId name:(NSString *)name picurl:(NSString *)picurl completion:(void (^)(TokenModel *, NSError *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            userId, @"userid",
                            name, @"name",
                            picurl, @"picurl", nil];
    return [[APPSClient newClient] GET:@"chatroomapi/gettoken" parameters:params
               resultClass:[TokenModel class] resultKeyPath:nil
                completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

+ (AFHTTPRequestOperation *)getUserListWithRoomId:(NSString *)roomId completion:(void (^)(NSArray *, NSError *))completion
{
    APPSClient *newClient = [APPSClient newClient];
    [newClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie]
                        forHTTPHeaderField:cookieKey];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            roomId, @"chatroomId",
                            @"IOS", @"os",
                            APP_BUILDVER, @"ver", nil];
    return [newClient GET:@"chatroomapi/getuserlist" parameters:params
               resultClass:[AudienceModel class] resultKeyPath:@"users"
                completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

+ (AFHTTPRequestOperation *)saveVipConversationWithRoomId:(NSString *)roomId userId:(NSString *)userId nickName:(NSString *)nickName headImg:(NSString *)headImg content:(NSString *)content completion:(void (^)(ResponseModel *, NSError *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            roomId, @"roomid",
                            userId, @"userid",
                            nickName, @"nickname",
                            headImg, @"headurl",
                            content, @"content",
                            @([[NSDate date] timeIntervalSince1970]), @"sendtime",nil];
    return [[APPSClient newClient] POST:@"customservice/chatroomcontentsave" parameters:params
                resultClass:[ResponseModel class] resultKeyPath:nil
                 completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
                     if (completion) {
                         completion(responseObject, error);
                     }
                 }];
}

+ (AFHTTPRequestOperation *)getMessageListWithRoomId:(NSString *)roomId pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize completion:(void (^)(MessageListModel *, NSError *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            roomId, @"roomid",
                            @(pageIndex), @"pageindex",
                            @(pageSize), @"pagesize", nil];
    return [[APPSClient newClient] POST:@"customservice/chatroomcontentlist" parameters:params
                resultClass:[MessageListModel class] resultKeyPath:nil
                 completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
                     if (completion) {
                         completion(responseObject, error);
                     }
                 }];
}

@end
