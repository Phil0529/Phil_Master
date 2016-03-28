//
//  OVCCMSClient.m
//  EZTV
//
//  Created by Sunni on 15/7/15.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "OVCCMSClient.h"
#import "AppConfig.h"

@implementation OVCCMSClient

+ (OVCCMSClient *)defaultClient
{
    OVCCMSClient *defaultClient = [[OVCCMSClient alloc] initWithBaseURL:[NSURL URLWithString:CMSBasePath]];
    NSSet *newContentTypes = [defaultClient.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [defaultClient.responseSerializer setAcceptableContentTypes:newContentTypes];
    [defaultClient setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]];
    return defaultClient;
}

+ (OVCCMSClient *)newClient
{
    return [[OVCCMSClient alloc] init];
}

- (instancetype)init
{
    if (self = [super initWithBaseURL:[NSURL URLWithString:[AppConfig sharedConfig].cmsPath]])
    {
        NSSet *newContentTypes = [self.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        [self.responseSerializer setAcceptableContentTypes:newContentTypes];
        [self setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]];
    }
    return self;
}

@end
