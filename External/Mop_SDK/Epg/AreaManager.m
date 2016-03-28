//
//  AreaManager.m
//  SWMOP
//
//  Created by Lee, Bo on 14-10-11.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import "AreaManager.h"
#import "Parameter.h"
#import "SWMOPQuery.h"
#import "TMCache.h"

static NSString *gAreaKey = @"AreaManager5s.key";
static NSString *gAreaFileName = @"AreaManager51.data";

@interface AreaManager()
{
    NSMutableDictionary *_mAreaMap;
}
@end

@implementation AreaManager

+ (id) sharedInstance
{
    static dispatch_once_t once;
    static AreaManager *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[AreaManager alloc] init];
    });
    
    return sharedInstance;
}

- (id) init
{
    self = [super init];
    if(self)
    {
        _mAreaMap = [[TMCache sharedCache] objectForKey:gAreaKey];
        if (!_mAreaMap) {
            _mAreaMap = [[NSMutableDictionary alloc] init];
        }
        //每次启动刷新一下缓存
        [self getAreaListFromNet];
    }
    return self;
}

- (void)dealloc
{
    
}

- (void)getAreaList:(void (^)(NSArray *, NSError *))completion
{
    NSString *lang = [[Parameter sharedInstance] getValueOfKey:ParamLanguage];
    NSArray *areaList = [_mAreaMap objectForKey:lang];
    if (areaList) {
        if (completion) {
            completion(areaList, nil);
        }
        return;
    }
    NSString *path = [EpgBase getAreaPath:lang];
    SWMOPQuery *areaQuery = [[SWMOPQuery alloc] init];
    [areaQuery getFromPath:path params:nil parserBlock:^id(id data) {
        return [self parseAreaList:data];
    } completion:^(id result, NSError *error) {
        if (error) {
            MopLogE(@"getAreaList erorr. \ncode:%ld info:%@", (long)error.code, error.userInfo);
        }
        if (result && [result isKindOfClass:[NSArray class]]) {
            [_mAreaMap setObject:result forKey:lang];
            [[TMCache sharedCache] setObject:_mAreaMap forKey:gAreaKey block:nil];
        }
        
        if (completion) {
            completion(result, error);
        }

    }];
}

- (void)getAreaListFromNet
{
    NSString *lang = [[Parameter sharedInstance] getValueOfKey:ParamLanguage];
    NSString *path = [EpgBase getAreaPath:lang];
    SWMOPQuery *areaQuery = [[SWMOPQuery alloc] init];
    [areaQuery getFromPath:path params:nil parserBlock:^id(id data) {
        return [self parseAreaList:data];
    } completion:^(id result, NSError *error) {
        if (error) {
            MopLogE(@"getArea erorr. \ncode:%ld info:%@", (long)error.code, error.userInfo);
        }
        if (result && [result isKindOfClass:[NSArray class]]) {
            [_mAreaMap setObject:result forKey:lang];
            [[TMCache sharedCache] setObject:_mAreaMap forKey:gAreaKey block:nil];
        }else if (error && error.code == ERROR_NILPATH){
            [self getAreaListFromNet];
        }
    }];
}


- (NSArray *)parseAreaList:(id)data
{
    if (data && [data isKindOfClass:[NSArray class]]) {
        NSArray *list = (NSArray *)data;
        NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[list count]];
        for (NSDictionary *jsonItem in list) {
            AreaItem *item = [[AreaItem alloc] initWithJsonObject:jsonItem];
            if(item)
            {
                [result addObject:item];
            }
        }
        return result;
    }
    return nil;
}

@end
