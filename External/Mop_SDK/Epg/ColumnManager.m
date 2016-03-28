//
//  ColumnManager.m
//  SWMOP
//
//  Created by Lee, Bo on 14-10-11.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//
#import "ColumnManager.h"
#import "Tools.h"
#import "Parameter.h"
#import "SWMOPQuery.h"
#import "TMCache.h"

static NSString *gColumnKey = @"Column5s.key";
static NSString *gColumnFileName = @"Column51.data";

@interface ColumnManager()
{
    NSMutableDictionary *_mColumnDictionary;
}

@end

@implementation ColumnManager

+ (id) sharedInstance
{
    static dispatch_once_t once;
    static ColumnManager *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[ColumnManager alloc] init];
    });
    return sharedInstance;
}

- (id) init
{
    self = [super init];
    if(self)
    {
        _mColumnDictionary = [[TMCache sharedCache] objectForKey:gColumnKey];
        if(!_mColumnDictionary)
        {
            _mColumnDictionary = [[NSMutableDictionary alloc] init];
        }
        //每次启动刷新一下缓存
        [self getColumnList];
    }
    
    return self;
}

- (void)dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)clearCache
{
    [_mColumnDictionary removeAllObjects];
}

- (void)getSubColumns:(NSInteger)pid completion:(void (^)(NSArray *, NSError *))completion
{
    NSString *lang = [[Parameter sharedInstance] getValueOfKey:ParamLanguage];
    NSArray *columnList = [_mColumnDictionary objectForKey:lang];
    if (columnList) {
        NSMutableArray *resultList = [[NSMutableArray alloc] init];
        for (ColumnItem *item in columnList) {
            if (item.mPid == pid) {
                [resultList addObject:item];
            }
        }
        if ([resultList count] > 0) {
            if (completion) {
                completion(resultList, nil);
            }
            return;
        }
    }
    //get from net
    NSString *path = [EpgBase getColumnSubPath:pid lang:lang];
    SWMOPQuery *query = [[SWMOPQuery alloc] init];
    [query getFromPath:path params:nil parserBlock:^id(id data) {
        return [self parseColumnList:data];
    } completion:^(id result, NSError *error) {
        if (error) {
            MopLogE(@"getSubColumns erorr. \ncode:%ld info:%@", (long)error.code, error.userInfo);
        }
        if (completion) {
            completion(result , error);
        }
    }];
    [self getColumnList];
}

- (ColumnItem *)getColumnItem:(NSInteger)columnId
{
    NSString *lang = [[Parameter sharedInstance] getValueOfKey:ParamLanguage];
    NSArray *columnList = [_mColumnDictionary objectForKey:lang];
    if (columnList) {
        for (ColumnItem *item in columnList) {
            if (item.mId == columnId) {
                return item;
            }
        }
    }
    return nil;
}

- (NSInteger)getColumnItemPid:(NSInteger)columnId
{
    ColumnItem *item = [self getColumnItem:columnId];
    if(item)
    {
        return item.mPid;
    }
    return -1;
}

- (void)queryColumnItem:(NSInteger)columnId pid:(NSInteger)pid title:(NSString *)title completion:(void (^)(ColumnItem *, NSError *))completion
{
    //这个接口的返回有2种,NSarry 跟NSdictionary
    //三个参数不能同时为空
    //暂时没有用到的地方,所以暂未实现
    if (completion) {
        completion(nil, nil);
    }
}

- (void)getColumnList
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(getColumnList) object:nil];
    NSString *lang = [[Parameter sharedInstance] getValueOfKey:ParamLanguage];
    NSString *path = [EpgBase getColumnListPath:lang];
    SWMOPQuery *mapQuery = [[SWMOPQuery alloc] init];
    [mapQuery getFromPath:path params:nil parserBlock:^id(id data) {
        return [self parseColumnList:data];
    } completion:^(id result, NSError *error) {
        if (error) {
            MopLogE(@"getColumnList erorr. \ncode:%ld info:%@", (long)error.code, error.userInfo);
        }
        if (result && [result isKindOfClass:[NSArray class]]) {
            [_mColumnDictionary setObject:result forKey:lang];
            MopLogD(@"ColumnManager dicitionary %@", _mColumnDictionary);
            [[TMCache sharedCache] setObject:_mColumnDictionary forKey:gColumnKey block:nil];
        } else if (error && error.code == ERROR_NILPATH){
            [self performSelector:@selector(getColumnList) withObject:nil afterDelay:.2f];
        }
    }];
}

- (void)getColumnMap
{
    //map接口获取的字典遍历为N平方级,暂不使用
    NSString *lang = [[Parameter sharedInstance] getValueOfKey:ParamLanguage];
    NSString *path = [EpgBase getColumnMapPath:lang];
    SWMOPQuery *mapQuery = [[SWMOPQuery alloc] init];
    [mapQuery getFromPath:path params:nil parserBlock:^id(id data) {
        if (data && [data isKindOfClass:[NSDictionary class]]) {
            NSDictionary *response = (NSDictionary *)data;
            NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithCapacity:[response count]];
            NSEnumerator *enumerator = [(NSDictionary*)data keyEnumerator];
            for (NSString *key in enumerator) {
                NSArray *jsonList = [(NSDictionary*)data objectForKey:key];
                if(jsonList) {
                    NSArray *itemList = [self parseColumnList:[response objectForKey:key]];
                    if(itemList) {
                        [result setObject:itemList forKey:key];
                    }
                }
            }
            if ([result count] > 0) {
                return result;
            }
        }
        return nil;
    } completion:^(id result, NSError *error) {
        if (!error) {
            [_mColumnDictionary setObject:result forKey:lang];
            MopLogD(@"ColumnManager dicitionary %@", _mColumnDictionary);
            [[TMCache sharedCache] setObject:_mColumnDictionary forKey:gColumnKey block:nil];
        } else {
            MopLogE(@"getColumnMap error : %@", [error localizedDescription]);
        }
    }];
}

- (NSArray*)parseColumnList:(id)jsonList
{
    if (jsonList && [jsonList isKindOfClass:[NSArray class]]) {
        NSArray *list = (NSArray *)jsonList;
        NSMutableArray *itemList = [[NSMutableArray alloc] initWithCapacity:[list count]];
        for (NSDictionary *jsonItem in list) {
            ColumnItem *item = [[ColumnItem alloc] initWithJosnObject:jsonItem];
            if (item) {
                [itemList addObject:item];
            }
        }
        return itemList;
    }
    return nil;
}


@end
