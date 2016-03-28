//
//  AFXmlAPIClient.m
//  SWMOP
//
//  Created by Lee, Bo on 14/11/26.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import "AFXmlAPIClient.h"

@implementation AFXmlAPIClient

+ (instancetype)sharedClient {
    static AFXmlAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFXmlAPIClient alloc] initWithBaseURL:nil];
        [_sharedClient setRequestSerializer:[AFHTTPRequestSerializer serializer]];
        [_sharedClient setResponseSerializer:[AFXMLParserResponseSerializer serializer]];
        [_sharedClient setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]];
    });
    return _sharedClient;
}

@end
