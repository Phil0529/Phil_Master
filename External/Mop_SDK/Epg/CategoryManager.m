//
//  CategoryManager.m
//  SWMOP
//
//  Created by Lee, Bo on 14-10-11.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//
#import "CategoryManager.h"
#import "Tools.h"
#import "Parameter.h"
#import "SWMOPQuery.h"

//static NSString *gCategoryKey = @"CategoryManager5s.key";
//static NSString *gCategoryFileName = @"CategoryManager51.data";

@implementation CategoryManager
{
    NSMutableDictionary *_mCategoryMap;
}

+ (id)sharedInstance
{
    static dispatch_once_t once;
    static CategoryManager *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[CategoryManager alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        //刷新flash代价太大,不值得 就不存储下来了.
//        _mCategoryMap = [Tools readObject:gCategoryKey FileName:gCategoryFileName];
        if(!_mCategoryMap)
        {
            _mCategoryMap = [[NSMutableDictionary alloc] init];
        }
//        [[SyncManager sharedInstance] addSyncListener:self];
    }
    return self;
}

- (void)onSyncChange:(NSInteger)columnId
{
    [_mCategoryMap removeObjectForKey:@(columnId)];
    [self getCategoryListFromNet:columnId lang:[[Parameter sharedInstance] getValueOfKey:ParamLanguage] completion:nil];
}

-(void)dealloc
{
    [[SyncManager sharedInstance] removeSyncListener:self];
}

- (void)getCategoryList:(NSInteger)columnId completion:(void (^)(NSArray *, NSError *))completion
{
    id key = @(columnId);
    NSString *lang = [[Parameter sharedInstance] getValueOfKey:ParamLanguage];
    NSDictionary *cateDic = [_mCategoryMap objectForKey:key];
    if (cateDic) {
        NSArray *cateArray = [cateDic objectForKey:lang];
        if (cateArray) {
            if (completion) {
                completion(cateArray, nil);
            }
            return;
        }
    }
    //没找到 从网上拿
    [self getCategoryListFromNet:columnId lang:lang completion:completion];
}

- (void)getCategoryListFromNet:(NSInteger)columnId lang:(NSString *)lang completion:(void (^)(NSArray *, NSError *))completion
{
    id key = @(columnId);
    NSString *path = [EpgBase getCategoryPath:columnId lang:lang];
    SWMOPQuery *cateQuery = [[SWMOPQuery alloc] init];
    [cateQuery getFromPath:path params:nil parserBlock:^id(id data) {
        if (data && [data isKindOfClass:[NSArray class]]) {
            NSArray *response = (NSArray *)data;
            NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[response count]];
            for (NSDictionary *jsonItem in response) {
                CategoryItem *item = [[CategoryItem alloc] initWithJsonObject:jsonItem];
                if (item && item.mId != 0) {
                    [result addObject:item];
                }
            }
            return result;
        }
        return nil;
    } completion:^(id result, NSError *error) {
        if (error) {
            MopLogE(@"getCategoryListFromNet:%ld lang:%@ erorr. \ncode:%ld info:%@", (long)columnId, lang, (long)error.code, error.userInfo);
        }
        if (result && [result isKindOfClass:[NSArray class]]) {
            NSMutableDictionary *cateDic = [_mCategoryMap objectForKey:key];
            if (!cateDic) {
                cateDic = [[NSMutableDictionary alloc] init];
            }
            [cateDic setObject:result forKey:lang];
            [_mCategoryMap setObject:cateDic forKey:key];
        } else if (error.code != ERROR_NILPATH){
            if (!completion) {
                //非UI调用,处理重试path为空.
                [self getCategoryListFromNet:columnId lang:lang completion:nil];
            }
        }
        if (completion) {
            completion(result, error);
        }
    }];
    
}

@end
