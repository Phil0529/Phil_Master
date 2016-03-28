//
//  AFHttpAPIClient.m
//  SWMOP
//
//  Created by Lee, Bo on 14/11/27.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import "AFHttpAPIClient.h"

@implementation AFHttpAPIClient

+ (instancetype)sharedClient {
    static AFHttpAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFHttpAPIClient alloc] initWithBaseURL:nil];
        [_sharedClient setRequestSerializer:[AFHTTPRequestSerializer serializer]];
        [_sharedClient setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [_sharedClient setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]];
    });
    return _sharedClient;
}

@end
