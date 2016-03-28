//
//  EZColumnManager.m
//  HuaXia
//
//  Created by Lee, Bo on 15/3/31.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "EZColumnManager.h"
#import "OVCCMSClient.h"
#import "TMCache.h"

static NSString* dataKey = @"columna2.data";
static NSString* customKey = @"custom2.data";

@interface EZColumnManager ()

@property (nonatomic, strong) NSMutableDictionary *dataMap;
@property (nonatomic, strong) NSMutableDictionary *customMap;

@end

@implementation EZColumnManager
{
    NSInteger _retry;
}

+ (EZColumnManager *)sharedManager
{
    static EZColumnManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[EZColumnManager alloc] init];
    });
    return instance;
}

- (NSMutableDictionary *)dataMap
{
    if (!_dataMap) {
        _dataMap = [[NSMutableDictionary alloc] init];
    }
    return _dataMap;
}

- (NSMutableDictionary *)customMap
{
    if (!_customMap) {
        _customMap = [[NSMutableDictionary alloc] init];
    }
    return _customMap;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataMap = [[TMCache sharedCache] objectForKey:dataKey];
        _customMap = [[TMCache sharedCache] objectForKey:customKey];
        _retry = 0;
        [self refreshColumnMap];
    }
    return self;
}

- (void)dealloc
{
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshColumnMap) object:nil];
}

- (void)getColumnArrayByPid:(NSInteger)pid completion:(void (^)(NSArray *))completion
{
    NSArray *result = [self getColumnArrayByPid:pid];
    if (result) {
        if (completion) {
            completion(result);
        }
    } else {
        [self getColumnMapFromNetByPid:pid completion:completion];
    }
}

- (NSArray *)getColumnArrayByPid:(NSInteger)pid
{
    NSNumber *key = [[NSNumber alloc] initWithInteger:pid];
    return [_dataMap objectForKey:key];
}

- (void)refreshColumnMap
{
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshColumnMap) object:nil];
    [self getColumnMapFromNetByPid:COLUMN_ROOT completion:nil];
}

- (void)saveDataToCache
{
    [[TMCache sharedCache] setObject:self.dataMap forKey:dataKey block:nil];
    [[TMCache sharedCache] setObject:self.customMap forKey:customKey block:nil];
}

- (void)changeItemValue:(EZColumnItem *)item
{
    [_customMap setObject:item forKey:@(item.cid)];
}

- (void)getColumnMapFromNetByPid:(NSInteger)pid completion:(void (^)(NSArray *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    __weak __typeof(self) weakSelf = self;
    [[OVCCMSClient newClient] GET:ACTION_GET_COLUMNS parameters:params resultClass:EZColumnItem.class resultKeyPath:@"list" completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        BOOL succeed = NO;
        if (weakSelf && responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            NSArray *columnList = responseObject;
            if ([columnList count] > 0) {
                _retry = 0;
                succeed = YES;
                [weakSelf.dataMap removeAllObjects];
                for (EZColumnItem *item in columnList) {
                    NSNumber *key = @(item.pid);
                    NSNumber *itemKey = @(item.cid);
                    NSMutableArray *array = [weakSelf.dataMap objectForKey:key];
                    if (!array) {
                        array = [[NSMutableArray alloc] init];
                        [weakSelf.dataMap setObject:array forKey:key];
                    }
                    EZColumnItem *customItem = [weakSelf.customMap objectForKey:itemKey];
                    if (customItem) {
                        item.isselect = customItem.isselect;
                        item.sortNum = customItem.sortNum;
                    } else {
                        item.sortNum = (double)([weakSelf.customMap count] + 1);
                        [weakSelf.customMap setObject:item forKey:itemKey];
                    }
                    [array addObject:item];
                }
                if (completion && pid >= 0) {
                    NSNumber *key = [[NSNumber alloc] initWithInteger:pid];
                    NSArray *resultArr = [weakSelf.dataMap objectForKey:key];
                    completion(resultArr);
                }
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(managerDidFinishRefresh)])
                {
                    [weakSelf.delegate managerDidFinishRefresh];
                }
                [weakSelf saveDataToCache];
            }
        }
        if (!succeed) {
            if (completion) {
                completion(nil);
            } else {
                //应用启动刷新数据
                _retry++;
                if (_retry < 4) {
                    [self performSelector:@selector(refreshColumnMap) withObject:nil afterDelay:3.0];
                } else {
                    _retry = 0;
                }
            }
        }
        if (error) {
            SWLogE(@"getColumnMapFromNet erorr. \ncode:%ld info:%@", (long)error.code, error.userInfo);
        }
    }];
}

@end
