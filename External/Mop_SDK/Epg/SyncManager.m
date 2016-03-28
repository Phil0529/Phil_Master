//
//  SyncManager.m
//  SWMOP
//
//  Created by Lee, Bo on 14-10-11.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//
#import "TMCache.h"
#import "EpgBase.h"
#import "SyncManager.h"
#import "SWMOPQuery.h"

static NSString *gSyncKey = @"SyncList5s.key";
static NSString *gSyncFileName = @"SyncList51.data";


@interface SyncManager()

@end

@implementation SyncManager
{
    NSTimer *_mTimer;
    NSMutableDictionary *_mSyncDictionary;
    NSMutableArray *_mListenerList;
}

// 单例模式
+ (id) sharedInstance
{
    static dispatch_once_t once;
    static SyncManager *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[SyncManager alloc] init];
    });
    return sharedInstance;
}

- (id) init
{
    self = [super init];
    if(self)
    {
        _mSyncDictionary = [[TMCache sharedCache] objectForKey:gSyncKey];
        if(!_mSyncDictionary)
        {
            _mSyncDictionary = [[NSMutableDictionary alloc] init];
            [self updateSyncList];
        }
        _mListenerList = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void)dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (_mTimer) {
        [_mTimer invalidate];
        _mTimer = nil;
    }
}

- (void)addSyncListener:(id<SyncListener>)syncListener
{
    [_mListenerList addObject:syncListener];
}

- (void)removeSyncListener:(id<SyncListener>)syncListener
{
    [_mListenerList removeObject:syncListener];
}

- (void)startUpdate:(NSTimeInterval)interval
{
    if (_mTimer) {
        [_mTimer invalidate];
        _mTimer = nil;
    }
    _mTimer = [NSTimer scheduledTimerWithTimeInterval:interval
                                               target:self
                                             selector:@selector(updateSyncList)
                                             userInfo:nil
                                              repeats:YES];
}

- (void)updateSyncList
{
    NSString *path = [EpgBase getSyncPath];
    SWMOPQuery *syncQuery = [[SWMOPQuery alloc] init];
    [syncQuery getFromPath:path params:nil parserBlock:^id(id data) {
        if (data && [data isKindOfClass:[NSArray class]]) {
            NSArray *response = (NSArray*)data;
            NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[response count]];
            for (NSDictionary *jsonItem in response) {
                SyncItem *item = [[SyncItem alloc] initWithJsonObject:jsonItem];
                if (item && item.mColumnId != -1) {
                    [result addObject:item];
                }
            }
            return result;
        }
        return nil;
    } completion:^(id result, NSError *error) {
        if (error) {
            MopLogE(@"updateSyncList erorr. \ncode:%ld info:%@", (long)error.code, error.userInfo);
        }
        if (result && [result isKindOfClass:[NSArray class]]) {
            for (SyncItem *newItem in (NSArray *)result) {
                SyncItem *item = [self getSyncItem:newItem.mColumnId];
                if ((item && item.mSyncNum != newItem.mSyncNum) || (!item && newItem.mSyncNum == 1))
                {
                    [self onSyncChange:item.mColumnId];
                }
                [_mSyncDictionary setObject:newItem forKey:@(newItem.mColumnId)];
            }
            [[TMCache sharedCache] setObject:_mSyncDictionary forKey:gSyncKey block:nil];
            MopLogD(@"SyncManager \n%@", [_mSyncDictionary description]);
        }
    }];
}

- (SyncItem*)getSyncItem:(NSInteger)columnId
{
    if(_mSyncDictionary)
    {
        return [_mSyncDictionary objectForKey:@(columnId)];
    }
    return nil;
}


- (void)onSyncChange:(NSInteger)columnId
{
    for (id<SyncListener> listener in _mListenerList) {
        if (listener && [listener respondsToSelector:@selector(onSyncChange:)]) {
            [listener onSyncChange:columnId];
        }
    }
}

@end
