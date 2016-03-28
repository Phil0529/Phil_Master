//
//  CoinQuery.m
//  EZTV
//
//  Created by Lee, Bo on 15/5/22.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "CoinQuery.h"
#import "AFCMSClient.h"
#import "UserCenter.h"

@implementation CoinQuery

+ (void)addCoinCountbyChannel:(CoinChannel)channel completion:(void (^)(NSInteger, NSInteger))completion
{
    if (ISEMPTYSTR([[UserCenter defaultCenter] userCookie])) {
        if (completion) {
            completion(-1, -1);
        }
        return;
    }
    
    NSDictionary *params = @{@"cointype":@(channel),
                             @"mpno":[UserCenter defaultCenter].currentUser.mpno};
    AFCMSClient *cmsClient = [[AFCMSClient alloc] init];
    [cmsClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    [cmsClient POST:ACTION_SET_COIN parameters:params
                              success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSInteger code = [[(NSDictionary *)responseObject objectForKey:@"code"] integerValue];
            if (code == 1) {
                NSInteger num = [[(NSDictionary *)responseObject objectForKey:@"num"] integerValue];
                if (completion) {
                    completion(code, num);
                }
                return;
            } else {
                if (completion) {
                    completion(code, -1);
                }
                return;
            }
        }
        if (completion) {
            completion(-1, -1);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion(-1, -1);
        }
    }];
}

+ (void)checkSignUpWithMpno:(NSString *)mpno completion:(void (^)(BOOL))completion
{
    if (ISEMPTYSTR(mpno)) {
        if (completion) {
            completion(YES);
        }
        return;
    }
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            mpno, @"mpno",
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
   [[AFCMSClient newClient] GET:ACTION_GET_SIGNST parameters:params
                            success:^(NSURLSessionDataTask *task, id responseObject)
   {
       if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
           NSInteger code = [[(NSDictionary *)responseObject objectForKey:@"code"] integerValue];
           if (code != 2) {
               if (completion) {
                   completion(NO);
               }
           } else {
               if (completion) {
                   completion(YES);
               }
           }
           return;
       }
   } failure:^(NSURLSessionDataTask *task, NSError *error) {
       if (completion) {
           completion(YES);
       }
   }];
}

@end
