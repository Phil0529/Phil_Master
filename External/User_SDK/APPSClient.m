//
//  APPSClient.m
//  EZTV
//
//  Created by Lee, Bo on 16/1/31.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import "APPSClient.h"
#import "AppConfig.h"

@implementation APPSClient

+ (APPSClient *)newClient
{
    return [[APPSClient alloc] init];
}

- (instancetype)init
{
    if (self = [super initWithBaseURL:[NSURL URLWithString:[AppConfig sharedConfig].appsPath]]) {
        NSSet *newContentTypes = [self.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        [self.responseSerializer setAcceptableContentTypes:newContentTypes];
        [self setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]];
    }
    return self;
}

@end
