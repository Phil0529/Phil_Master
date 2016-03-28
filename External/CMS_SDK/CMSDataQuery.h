//
//  CMSDataQuery.h
//  EZTV
//
//  Created by Sunni on 15/7/15.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdItem.h"
#import "MenuItem.h"
#import "HomeItem.h"
#import <AFNetworking/AFHTTPRequestOperation.h>
#import "ResponseModel.h"
#import "LaunchAdModel.h"
#import "TopicItem.h"
#import "ConfigMap.h"
#import "SponsorsInfo.h"
#import "SponsorsListItem.h"

@interface CMSDataQuery : NSObject

+ (AFHTTPRequestOperation *)getLaunchAdArray:(void(^)(NSArray *result))completion;

+ (AFHTTPRequestOperation *)getMenuPageDataArray:(void(^)(NSArray *result))completion;

+ (AFHTTPRequestOperation *)queryTabMenuDataArray:(void(^)(NSArray *result))completion;

+ (AFHTTPRequestOperation *)queryConfigDataMap:(void(^)(ConfigMap *result))completion;

+ (AFHTTPRequestOperation *)queryHomePageDataArrayFromNet:(void (^)(NSArray *result))completion;

+ (AFHTTPRequestOperation *)queryServiceDataArrayFromNet:(void (^)(NSArray *result))completion;

+ (AFHTTPRequestOperation *)queryDiscoveryDataArrayFromNet:(void (^)(NSArray *result))completion;

+ (AFHTTPRequestOperation *)queryTopicNewsArrayWithMid:(NSString *)mid completion:(void (^)(NSArray *result))completion;

+ (AFHTTPRequestOperation *)queryAdDataWithCid:(NSInteger)cid completion:(void (^)(NSArray *result))completion;

+ (AFHTTPRequestOperation *)removeMyUploadsWithIds:(NSString *)ids completion:(void (^)(ResponseModel *response))completion;

+ (AFHTTPRequestOperation *)getMyFavoriteArraybyMpno:(NSString *)mpno completion:(void(^)(NSArray *result))completion;

+ (AFHTTPRequestOperation *)unFavoriteWithItemId:(NSString *)fId mpno:(NSString *)mpno completion:(void (^)(ResponseModel *response))completion;

+ (AFHTTPRequestOperation *)postApplyInfomation:(SponsorsInfo *)info completion:(void (^)(ResponseModel *result))completion;

+ (AFHTTPRequestOperation *)getSponsorsListCompletion:(void (^)(NSArray *result))completion;

+ (AFHTTPRequestOperation *)getSponsorsStatus:(NSString *)mpno Completion:(void (^)(NSArray *result))completion;

@end
