//
//  NewsManager.m
//  HuaXia
//
//  Created by Lee, Bo on 15/3/31.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "EZMediaManager.h"
//#import "TMCache.h"
#import "LoadItem.h"
#import "OVCCMSClient.h"

static NSString* dataKey = @"medias1.data";

@implementation EZMediaManager
{
    NSMutableDictionary *_dataMap;
}

+ (EZMediaManager *)sharedManager
{
    static EZMediaManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[EZMediaManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
//        _dataMap = [[TMCache sharedCache] objectForKey:dataKey];
        if (!_dataMap) {
            _dataMap = [[NSMutableDictionary alloc] init];
        }
    }
    return self;
}

- (void)loadMediaListWithCid:(NSInteger)cid area:(NSInteger)area hangye:(NSInteger)hangye title:(NSString *)title tag:(NSString *)tag type:(NSInteger)type pageSize:(NSInteger)pageSize completion:(void (^)(NSArray *, BOOL, BOOL))completion
{
    NSString *key = [NSString stringWithFormat:@"%ld_%ld_%ld_%@_%@_%ld_%ld", (long)cid, (long)area, (long)hangye, title, tag, (long)type, (long)pageSize];
    LoadItem *loadItem = [_dataMap objectForKey:key];
    if (loadItem) {
        if (loadItem.isLoading || loadItem.isComplete) {
            if (completion) {
                completion(loadItem.dataArray, NO, loadItem.isComplete);
            }
            return;
        }
        loadItem.isLoading = YES;
        if (loadItem.pageIndex == 0 && [loadItem.dataArray count] == 0) {
            loadItem.pageIndex = 0;
        }else{
            loadItem.pageIndex++;
        }
    } else {
        loadItem = [[LoadItem alloc] init];
        loadItem.pageSize = pageSize;
        [_dataMap setObject:loadItem forKey:key];
    }
    
    NSMutableString *path = [[NSMutableString alloc] initWithFormat:@"%@?page=%ld&pagesize=%ld", ACTION_GET_MEDIAS, (long)loadItem.pageIndex, (long)loadItem.pageSize];
    if (cid != -1) {
        [path appendFormat:@"&cid=%ld", (long)cid];
    }
    if (area != -1) {
        [path appendFormat:@"&area=%ld", (long)area];
    }
    if (hangye != -1) {
        [path appendFormat:@"&hangye=%ld", (long)hangye];
    }
    if (!ISEMPTYSTR(tag)) {
        [path appendFormat:@"&tag=%@", tag];
    }
    if (!ISEMPTYSTR(title)) {
        [path appendFormat:@"&title=%@", title];
    }
    if (type != -1) {
        [path appendFormat:@"&type=%ld", (long)type];
    }
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    [[OVCCMSClient newClient] GET:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                          parameters:params
                         resultClass:[EZMediaItem class]
                       resultKeyPath:@"list"
                          completion:
     ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        BOOL loadSucced = NO;
        if ([responseObject isKindOfClass:[NSArray class]]) {
            loadSucced = YES;
            NSArray *result = responseObject;
            if ([result count] > 0) {
                if (loadItem.dataArray) {
                    [loadItem.dataArray addObjectsFromArray:result];
                } else {
                    loadItem.dataArray = [[NSMutableArray alloc] initWithArray:result];
                }
                if ([result count] < loadItem.pageSize) {
                    loadItem.isComplete = YES;
                }
            } else {
                loadItem.isComplete = YES;
                if (!loadItem.dataArray) {
                    loadItem.dataArray = [[NSMutableArray alloc] init];
                }
            }
        }
        if (!loadSucced) {
            if (loadItem.pageIndex > 0) {
                loadItem.pageIndex --;
            }
        }
        loadItem.isLoading = NO;
//        [[TMCache sharedCache] setObject:_dataMap forKey:key block:nil];
        if (completion) {
            completion(loadItem.dataArray, loadSucced, loadItem.isComplete);
        }
        if (error) {
            SWLogE(@"loadMediaListWithKey:%@ erorr. \ncode:%ld info:%@", key, (long)error.code, error.userInfo);
        }
    }];
}

- (NSArray *)getMediaListWithCid:(NSInteger)cid area:(NSInteger)area hangye:(NSInteger)hangye title:(NSString *)title tag:(NSString *)tag type:(NSInteger)type pageSize:(NSInteger)pageSize
{
    NSString *key = [NSString stringWithFormat:@"%ld_%ld_%ld_%@_%@_%ld_%ld", (long)cid, (long)area, (long)hangye, title, tag, (long)type, (long)pageSize];
    if (_dataMap) {
        LoadItem *item = [_dataMap objectForKey:key];
        return item.dataArray;
    }
    return nil;
}

- (BOOL)refreshMediaWithCid:(NSInteger)cid area:(NSInteger)area hangye:(NSInteger)hangye title:(NSString *)title tag:(NSString *)tag type:(NSInteger)type pageSize:(NSInteger)pageSize
{
    NSString *key = [NSString stringWithFormat:@"%ld_%ld_%ld_%@_%@_%ld_%ld", (long)cid, (long)area, (long)hangye, title, tag, (long)type, (long)pageSize];
    LoadItem *item = [_dataMap objectForKey:key];
    if (item) {
        [_dataMap removeObjectForKey:key];
        return YES;
    }
    return NO;
}

@end
