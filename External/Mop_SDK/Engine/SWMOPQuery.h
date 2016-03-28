//
//  SWMOPQuery.h
//  mopSDK
//
//  Created by liangliang on 13-6-18.
//  Copyright (c) 2013年 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MopLog.h"
#import "EpgBase.h"

typedef NS_ENUM(NSInteger, MopErrorCode)
{
    ERROR_NILPATH = 888,
    ERROR_NILRESPONSE = 999
};

//
// 将AFnetwork调用 以及返回数据处理的 封装,
// 为了不阻塞UI线程,queryScuccess在background调用,数据处理完成后再performInMainThread
//

typedef id (^parserBlock)(id data);
typedef void (^queryCompletion)(id result, NSError *error);

@interface SWMOPQuery : NSObject

- (NSURLSessionDataTask *)getFromPath:(NSString *)path
                               params:(NSDictionary *)params
                          parserBlock:(parserBlock)parserBlovk
                           completion:(queryCompletion)completion;

- (NSURLSessionDataTask *)postToPath:(NSString *)path
                              params:(NSDictionary *)params
                         parserBlock:(parserBlock)parserBlovk
                          completion:(queryCompletion)completion;

@end
