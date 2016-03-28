//
//  NSHttp.h
//  SWMOP
//
//  Created by Lee, Bo on 14/12/12.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpResponse : NSObject

@property (nonatomic, assign) NSInteger mStatusCode;
@property (nonatomic, strong) NSString *mLocation;
@property (nonatomic, strong) NSString *mOisIp;
@property (nonatomic, strong) NSString *mOisToken;
@property (nonatomic, strong) NSString *mEpgsIp;
@property (nonatomic, strong) NSString *mEpgsToken;
@property (nonatomic, strong) NSString *mSoapBody;
@property (nonatomic, strong) id mExtend;

@end

typedef void (^HttpResponseCompletion)(HttpResponse *response);

@interface HttpDelegate : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSMutableData *mData;
@property (nonatomic, strong) HttpResponse *mResponse;

- (instancetype)initWithCompletion:(HttpResponseCompletion)completion;

@end

@interface NSHttpRequest : NSObject

/**
 *  Get 请求
 *
 *  @param path       地址
 *  @param timeout    超时
 *  @param completion 完成代码块
 */
+ (void)GET:(NSString *)path timeout:(NSInteger)timeout completion:(HttpResponseCompletion)completion;


/**
 *  Post 请求
 *
 *  @param path       接口地址
 *  @param content    头数据
 *  @param timeout    超时
 *  @param completion 完成代码块
 */
+ (void)POST:(NSString *)path content:(NSString *)content timeout:(NSInteger)timeout completion:(HttpResponseCompletion)completion;

@end
