//
//  SWMODQuery.m
//  mopSDK
//
//  Created by liangliang on 13-6-18.
//  Copyright (c) 2013年 Sunniwell. All rights reserved.
//

#import "SWMOPQuery.h"
#import "AFJsonAPIClient.h"
#import "Tools.h"

@implementation SWMOPQuery
{
    parserBlock _parserBlock;
    queryCompletion _completion;
    NSString *_path;
}

- (void)dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (NSURLSessionDataTask *)getFromPath:(NSString *)path
                               params:(NSDictionary *)params
                          parserBlock:(parserBlock)parserBlovk
                           completion:(queryCompletion)completion
{
    _parserBlock = parserBlovk;
    _completion = completion;
    _path = path;
//    _path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([Tools isEmptyString:path]) {
        [self performSelector:@selector(pathNilError) withObject:nil afterDelay:0.5f];
        return nil;
    }
    return [[AFJsonAPIClient sharedClient] GET:path
                                         parameters:params
                                            success:
            ^(NSURLSessionDataTask *task, id responseObject) {
                [self performSelectorInBackground:@selector(querySuccess:) withObject:responseObject];
            }
                                            failure:
            ^(NSURLSessionDataTask *task, NSError *error) {
                [self queryFailure:error];
            }];
}

- (NSURLSessionDataTask *)postToPath:(NSString *)path
                              params:(NSDictionary *)params
                         parserBlock:(parserBlock)parserBlovk
                          completion:(queryCompletion)completion
{
    _parserBlock = parserBlovk;
    _completion = completion;
    _path = path;
    //[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([Tools isEmptyString:path]) {
        [self performSelector:@selector(pathNilError) withObject:nil afterDelay:0.5f];
        return nil;
    }
    return [[AFJsonAPIClient sharedClient] POST:path
                                          parameters:params
                                             success:
            ^(NSURLSessionDataTask *task, id responseObject) {
                [self performSelectorInBackground:@selector(querySuccess:) withObject:responseObject];
            }
                                             failure:
            ^(NSURLSessionDataTask *task, NSError *error) {
                [self queryFailure:error];
            }];
}

- (void)querySuccess:(id)responseObject
{
    id result = nil;
    if (_parserBlock) {
        result = _parserBlock(responseObject);
    }
    if (result) {
        [self performSelectorOnMainThread:@selector(success:) withObject:result waitUntilDone:NO];
    } else {
        NSError *error = [NSError errorWithDomain:@"net.sunniwell.swmop.api.query.nilresult"
                                             code:ERROR_NILRESPONSE
                                         userInfo:@{@"desc:":@"not able to convert the data",@"path":_path}];
        [self performSelectorOnMainThread:@selector(failure:) withObject:error waitUntilDone:NO];
    }
}

- (void)queryFailure:(NSError *)error
{
    [self failure:error];
}

- (void)success:(id)result
{
    if (_completion) {
        _completion(result, nil);
    }
}

- (void)failure:(NSError *)error
{
    if (_completion) {
        _completion(nil, error);
    }
}

- (void)pathNilError
{
    NSError *error = [NSError errorWithDomain:@"net.sunniwell.swmop.api.pathnil"
                                            code:ERROR_NILPATH
                                        userInfo:@{@"desc":@"path is nil"}];
    [self queryFailure:error];
}


@end
