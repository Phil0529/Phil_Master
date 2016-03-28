//
//  SWMediaManager.m
//  SWMOP
//
//  Created by Lee, Bo on 14-6-11.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import "MediaManager.h"
//#import "Tools.h"
#import "Parameter.h"
#import "SWMOPQuery.h"

static NSString *gMediaKey = @"Media5s.key";
static NSString *gMediaFileName = @"Media51.data";

@interface MediaLoadItem : NSObject<NSCoding>

@property (strong, nonatomic) NSMutableArray *list;
@property (assign, nonatomic) NSInteger pageIndex;
@property (assign, nonatomic) BOOL isLoading;
@property (assign, nonatomic) BOOL isCompleted;

@end

@implementation MediaLoadItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pageIndex = 0;
        _isLoading = YES;
        _isCompleted = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        _isLoading = NO;
        _list = [aDecoder decodeObjectForKey:@"medatalist"];
        _pageIndex = [aDecoder decodeIntegerForKey:@"mepageindex"];
        _isCompleted = [aDecoder decodeBoolForKey:@"meiscomplete"];;
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_list forKey:@"medatalist"];
    [aCoder encodeInteger:_pageIndex forKey:@"mepadeindex"];
    [aCoder encodeBool:_isCompleted forKey:@"meiscomplete"];
}

@end

@implementation MediaManager
{
    NSInteger *mSycNumber;
    NSMutableDictionary *mDataDic;

//    NSCondition *lockCondition;
    NSInteger *_writeFlashCount;
}

+ (id)sharedInstance{
    static dispatch_once_t pred = 0;
    static MediaManager *sharedInstance;
    dispatch_once(&pred, ^{
        sharedInstance = [[super allocWithZone:NULL]init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
//        lockCondition = [[NSCondition alloc] init];
//        mDataDic = [Tools readObject:gMediaKey FileName:gMediaFileName];
        if(!mDataDic)
        {
            mDataDic = [[NSMutableDictionary alloc] init];
        }
        [[SyncManager sharedInstance] addSyncListener:self];
    }
    return self;
}

-(void)dealloc
{
    [[SyncManager sharedInstance] removeSyncListener:self];
}

- (void)onSyncChange:(NSInteger)columnId
{
    //同步码变更处理
    [mDataDic removeAllObjects];

//    if ([mDataDic count] > 0) {
//        NSMutableArray *deleteKeys = [[NSMutableArray alloc] initWithCapacity:[mDataDic count]];
//        
//        NSEnumerator * enumeratorKey = [mDataDic keyEnumerator];
//        //快速枚举遍历所有KEY的值
//        for (NSString *key in enumeratorKey) {
//            NSString *keyColumn = [[key componentsSeparatedByString:@"_"] firstObject];
//            if (keyColumn && [keyColumn integerValue] == columnId) {
//                [deleteKeys addObject:key];
//            }
//        }
//        //清空掉所有陈旧的缓存
//        for (NSString *key in deleteKeys) {
//            [mDataDic removeObjectForKey:key];
//        }
//        //重新加载,完成后通知UI更新
////        NSEnumerator * enumeratorValue = [loadKeys objectEnumerator];
////        for (LoadKey *key in enumeratorValue) {
////            [self loadMediaWithLoadKey:key];
////        }
//    }
}

- (void)clearCache
{
    [mDataDic removeAllObjects];
//    [Tools writeObject:mDataDic Key:gMediaKey FileName:gMediaFileName];
    [[NSNotificationCenter defaultCenter]postNotificationName:MSG_LOAD_MEDIA_LIST_FINISH object:nil];
}

- (void)writeToFlash
{
//    [Tools writeObject:mDataDic Key:gMediaKey FileName:gMediaFileName];
}

- (void)loadMediaWithColumnId:(NSInteger)columnId meta:(NSString *)meta category:(NSString *)category area:(NSString *)area tag:(NSString *)tag year:(NSString *)year title:(NSString *)title pinyin:(NSString *)pinyin actor:(NSString *)actor director:(NSString *)director sort:(NSString *)sort pageSize:(NSUInteger)pageSize completion:(void (^)(NSArray *, BOOL, BOOL))completion
{
    NSString *lang = @"zh";
    NSString *key = [NSString stringWithFormat:@"%ld_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@", (long)columnId, meta, category, area, tag, year, title, pinyin, actor, director, sort, lang];
    
    //从加载缓存中拿到loaditem
    MediaLoadItem *loadItem = [mDataDic objectForKey:key];
    if (loadItem) {
        if (loadItem.isLoading || loadItem.isCompleted) {
            if (completion) {
                completion(loadItem.list, NO, loadItem.isCompleted);
            }
            return;
        }
        loadItem.isLoading = YES;
        if (loadItem.pageIndex == 0 && [loadItem.list count] == 0) {
            loadItem.pageIndex = 0;
        }else{
            loadItem.pageIndex++;
        }
    }else{
        loadItem = [[MediaLoadItem alloc] init];
        [mDataDic setObject:loadItem forKey:key];
    }
    
    NSString *path = [EpgBase getMediaPath:columnId Meta:meta PageIndex:loadItem.pageIndex lang:lang pageSize:pageSize];
    NSDictionary *params = [EpgBase getMediaParamsWithCategory:category Area:area Tag:tag Year:year Title:title Pinyin:pinyin Actor:actor Director:director Sort:sort];
    
    SWMOPQuery *mediaQuery = [[SWMOPQuery alloc] init];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [mediaQuery getFromPath:path params:params parserBlock:^id(id data) {
        if (data && [data isKindOfClass:[NSDictionary class]]) {
            NSArray *jsonList = [(NSDictionary *)data objectForKey:@"list"];
            NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[jsonList count] + 1];
            if (jsonList) {
                for (NSDictionary *jsonItem in jsonList) {
                    MediaItem *item = [[MediaItem alloc] initWithJsonObject:jsonItem];
                    if(item)
                    {
                        [result addObject:item];
                    }
                }//for
            }//if
            return result;
        }
        return nil;
    } completion:^(id result, NSError *error) {
        BOOL loadSucced = NO;
        if (error) {
            MopLogE(@"loadMediaWithkey:%@ erorr. \ncode:%ld info:%@", [key description], (long)error.code, error.userInfo);
        }
        //若缓存已经清空,脏数据不用保存
        if (result && [result isKindOfClass:[NSMutableArray class]]) {
            loadSucced = YES;
            if (!loadItem.list) {
                loadItem.list = result;
            } else {
                [loadItem.list addObjectsFromArray:result];
            }
            if ([result count] < pageSize) {
                loadItem.isCompleted = YES;
            }
            if ([result count] == 0) {
                if (loadItem.pageIndex > 0) {
                    loadItem.pageIndex--;
                }
            }
        } else {
            if (loadItem.pageIndex > 0) {
                loadItem.pageIndex--;
            }
        }
        //加载完成写入数据存储
        loadItem.isLoading = NO;
        if (completion) {
            completion(loadItem.list, loadSucced, loadItem.isCompleted);
        }
        //不使用copy方法的话,缓存区等同虚设.
//        [[NSNotificationCenter defaultCenter]postNotificationName:MSG_LOAD_MEDIA_LIST_FINISH object:nil];
        [self writeToFlash];
    }];
}

- (NSArray *)getListWithColumnId:(NSInteger)columnId meta:(NSString *)meta category:(NSString *)category area:(NSString *)area tag:(NSString *)tag year:(NSString *)year title:(NSString *)title pinyin:(NSString *)pinyin actor:(NSString *)actor director:(NSString *)director sort:(NSString *)sort
{
    NSString *lang = @"zh";
    NSString *key = [NSString stringWithFormat:@"%ld_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@", (long)columnId, meta, category, area, tag, year, title, pinyin, actor, director, sort, lang];
    MediaLoadItem *item = [mDataDic objectForKey:key];
    if (item && item.list) {
        return item.list;
    }
    return nil;
}

//- (NSArray *)getLiveListAllSortBy:(NSString *)sort
//{
//    NSString *lang = [[Parameter sharedInstance] getValueOfKey:ParamLanguage];
//    NSString *key = [NSString stringWithFormat:@"%d_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@", 0, META_SEARCH_ALLLIVE, @"", @"", @"", @"", @"", @"", @"", @"", sort, lang];
//    MediaLoadItem *loadItem = [mDataDic objectForKey:key];
//    if (loadItem && loadItem.list) {
//        return loadItem.list;
//    } else if (!loadItem || (loadItem && !loadItem.isLoading)) {
//        if (!loadItem) {
//            loadItem = [[MediaLoadItem alloc] init];
//            [mDataDic setObject:loadItem forKey:key];
//        } else {
//            loadItem.isLoading = YES;
//            loadItem.pageIndex = 0;
//        }
//        NSString *path = [EpgBase getMediaPath:0 Meta:META_SEARCH_ALLLIVE PageIndex:loadItem.pageIndex lang:lang pageSize:0];
//        NSDictionary *params = [EpgBase getMediaParamsWithCategory:@"" Area:@"" Tag:@"" Year:@"" Title:@"" Pinyin:@"" Actor:@"" Director:@"" Sort:sort];
//        
//        SWMOPQuery *mediaQuery = [[SWMOPQuery alloc] init];
//        path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        [mediaQuery getFromPath:path params:params parserBlock:^id(id data) {
//            if (data && [data isKindOfClass:[NSDictionary class]]) {
//                NSArray *jsonList = [(NSDictionary *)data objectForKey:@"list"];
//                NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[jsonList count] + 1];
//                if (jsonList) {
//                    for (NSDictionary *jsonItem in jsonList) {
//                        MediaItem *item = [[MediaItem alloc] initWithJsonObject:jsonItem];
//                        if(item)
//                        {
//                            [result addObject:item];
//                        }
//                    }//for
//                }//if
//                return result;
//            }
//            return nil;
//        } completion:^(id result, NSError *error) {
//            if (error) {
//                MopLogE(@"loadMediaWithkey:%@ erorr. \ncode:%ld info:%@", [key description], (long)error.code, error.userInfo);
//            }
//            //若缓存已经清空,脏数据不用保存
//            if (result && [result isKindOfClass:[NSMutableArray class]]) {
//                //去除重复的频道
////                for (MediaItem *item in result) {
////                    for (MediaItem *next in result) {
////                        if ([next.mId isEqualToString:item.mId]) {
////                            [result removeObject:next];
////                        }
////                    }
////                }
//                
//                loadItem.list = result;
//                loadItem.isCompleted = YES;
//            } else {
//                if (loadItem.pageIndex > 0) {
//                    loadItem.pageIndex--;
//                }
//            }
//            //加载完成写入数据存储
//            loadItem.isLoading = NO;
//            //不使用copy方法的话,缓存区等同虚设.
//            [self writeToFlash];
//        }];
//    }
//    return nil;
//}

- (BOOL)isCompleteWithColumnId:(NSInteger)columnId meta:(NSString *)meta category:(NSString *)category area:(NSString *)area tag:(NSString *)tag year:(NSString *)year title:(NSString *)title pinyin:(NSString *)pinyin actor:(NSString *)actor director:(NSString *)director sort:(NSString *)sort
{
    NSString *lang = @"zh";
    NSString *key = [NSString stringWithFormat:@"%ld_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@", (long)columnId, meta, category, area, tag, year, title, pinyin, actor, director, sort, lang];
    MediaLoadItem *item = [mDataDic objectForKey:key];
    if (item) {
        return item.isCompleted;
    }
    return NO;
}

- (BOOL)refreshMediaWithColumnId:(NSInteger)columnId meta:(NSString *)meta category:(NSString *)category area:(NSString *)area tag:(NSString *)tag year:(NSString *)year title:(NSString *)title pinyin:(NSString *)pinyin actor:(NSString *)actor director:(NSString *)director sort:(NSString *)sort
{
    NSString *lang = @"zh";
    NSString *key = [NSString stringWithFormat:@"%ld_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@", (long)columnId, meta, category, area, tag, year, title, pinyin, actor, director, sort, lang];
    MediaLoadItem *item = [mDataDic objectForKey:key];
    if (item) {
        [mDataDic removeObjectForKey:key];
        return YES;
    }
    return NO;
}

@end
