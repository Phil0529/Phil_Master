//
//  AFHttpAPIClient.h
//  SWMOP
//
//  Created by Lee, Bo on 14/11/27.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface AFHttpAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
