//
//  AFJsonAPIClient.m
//  HuaXia
//
//  Created by Lee, Bo on 15/3/30.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "AFCMSClient.h"
#import "AppConfig.h"

@implementation AFCMSClient

+ (AFHTTPSessionManager *)newClient
{
    return [[AFCMSClient alloc] init];
}

- (instancetype)init
{
    if (self = [super initWithBaseURL:[NSURL URLWithString:[AppConfig sharedConfig].cmsPath]])
    {
        self.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        NSSet *newContentTypes = [self.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        self.responseSerializer.acceptableContentTypes = newContentTypes;
    }
    return self;
}

@end
