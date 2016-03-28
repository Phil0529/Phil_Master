//
//  EpgManager.m
//  SWMOP
//
//  Created by Lee, Bo on 14-10-11.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import "EpgManager.h"
#import "EpgBase.h"
#import "SWMOPQuery.h"
#import "Parameter.h"

@interface EpgLoadItem : NSObject

@property (strong, nonatomic)NSArray *epgList;
@property (assign, nonatomic)BOOL isLoading;

@end

@implementation EpgLoadItem

@synthesize epgList = _epgList;
@synthesize isLoading = _isLoading;

@end

@interface EpgManager ()
{
    NSMutableDictionary *_mDataDictionary;
}
@end

@implementation EpgManager

+(EpgManager *)sharedInstance
{
    static dispatch_once_t once;
    static EpgManager *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[EpgManager alloc] init];
    });
    
    return sharedInstance;
}

-(id)init
{
    self = [super init];
    if (self) {
        _mDataDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc
{
}

- (void)loadEpgByChannel:(NSString *)channelId andUTC:(NSTimeInterval)utc completion:(epgLoadCompletion)completion
{
    NSString *lang = [[Parameter sharedInstance] getValueOfKey:ParamLanguage];
    NSString *dKey = [NSString stringWithFormat:@"%@_%@_%0.f",channelId,lang, utc];

    MopLogD(@"startload epg for key: %@",dKey);
    EpgLoadItem *item = [_mDataDictionary objectForKey:dKey];
    if (!item) {
        item = [[EpgLoadItem alloc]init];
        [_mDataDictionary setObject:item forKey:dKey];
    }
    if (item.isLoading) {
        if (completion) {
            completion(nil, channelId, YES);
        }
        return;
    }
    item.isLoading = YES;
    NSTimeInterval endutc = utc + 86400 - 1;
    NSString *path = [EpgBase getEpgPath:channelId startUtc:utc endUtc:endutc lang:lang];
    SWMOPQuery *epgQuery = [[SWMOPQuery alloc] init];
    [epgQuery getFromPath:path params:nil parserBlock:^id(id data) {
        if (data && [data isKindOfClass:[NSArray class]]) {
            NSArray* response = (NSArray*)data;
            NSMutableArray *result = [NSMutableArray arrayWithCapacity:[response count]];
            for (NSDictionary *dict in response) {
                EpgItem *item = [[EpgItem alloc] initWithJsonObject:dict];
                if (item) {
                    [result addObject:item];
                }
            }
            return result;
        }
        return nil;
    } completion:^(id result, NSError *error) {
        if (error) {
            MopLogE(@"loadEpgByChannel:%@ erorr. \ncode:%ld info:%@", channelId, (long)error.code, error.userInfo);
        }
        if (result && [result isKindOfClass:[NSArray class]]) {
            item.epgList = (NSArray *)result;
            if (completion) {
                completion(item.epgList, channelId, NO);
            }
        }else{
            if (completion) {
                completion(nil, channelId, NO);
            }
        }
        item.isLoading = NO;
    }];
}

- (NSArray *)epgListOfChannel:(NSString *)channelId andUTC:(NSTimeInterval)utc
{
    NSString *dKey = [NSString stringWithFormat:@"%@_%@_%0.f",channelId,[[Parameter sharedInstance] getValueOfKey:ParamLanguage], utc];
    if (_mDataDictionary) {
        EpgLoadItem *pItem = [_mDataDictionary objectForKey:dKey];
        if (pItem) {
            return pItem.epgList;
        }
    }
    return nil;
}

- (void)onSyncChange:(NSInteger)columnId OldSyncNumber:(NSInteger)oldSyncNumber NewSyncNumber:(NSInteger)newSyncNumber
{
    if (oldSyncNumber != newSyncNumber) {
        [self clean];
    }
}

- (void)clean
{
    if (_mDataDictionary) {
        [_mDataDictionary removeAllObjects];
    }
}

@end
