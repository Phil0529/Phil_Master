//
//  UploadManager.h
//  EZTV
//
//  Created by Lee, Bo on 15/5/8.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UploadItem.h"
#import "AFHTTPRequestOperationManager.h"

@interface UploadManager : NSObject

+ (void)getMyUploadArraybyMpnoPhil:(NSString *)mpno completion:(void (^)(NSArray *))completion;

+ (AFHTTPRequestOperation *)uploadLiveCoverWithLiveID:(NSString *)lid data:(NSData *)data uploadProgressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))block completion:(void(^)(BOOL success))completion;

+ (AFHTTPRequestOperation *)uploadLiveWithLiveID:(NSString *)lid title:(NSString *)title description:(NSString *)description tagName:(NSString *)tagName tagType:(NSInteger)tagType cover:(NSString *)cover vodData:(NSData *)vodData uploadProgressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))block completion:(void(^)(BOOL success))completion;

+ (AFHTTPRequestOperation *)uploadFileWithColumnIdPhil:(NSInteger)columnId item:(UploadItem *)item data:(NSData *)data type:(UploadType)type uploadProgressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))block completion:(void(^)(NSString *filePath))completion;

+ (AFHTTPRequestOperation *)uploadFileWithColumnIdPhil:(NSInteger)columnId item:(UploadItem *)item imagesDataArr:(NSArray *)imagesDataArr type:(UploadType)type uploadProgressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))block completion:(void(^)(NSString *filePath))completion;

@end
