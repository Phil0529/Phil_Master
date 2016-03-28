//
//  AFXmlAPIClient.h
//  SWMOP
//
//  Created by Lee, Bo on 14/11/26.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface AFXmlAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
