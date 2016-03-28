//
//  MediaItem.m
//  SWMOP
//
//  Created by Lee, Bo on 11/4/14.
//  Copyright (c) 2014 Sunniwell. All rights reserved.
//

#import "MediaItem.h"

//    MEDIA_META_LIVE_CHANNEL = 0, // 频道直播
//    MEDIA_META_VOD_SINGLE, // 单集片源
//    MEDIA_META_VOD_PROGRAMS, // 电视剧
//    MEDIA_META_VOD_FILMS, // 系列电影
//    MEDIA_META_VOD_GROUP, // 点播组
//    MEDIA_META_LIVE_ABR, // 直播ABR
//    MEDIA_META_VOD_ABR, // 点播ABR
//    MEDIA_META_SERVICE_PACKAGE = 10, // 产品包
//    MEDIA_META_HTML = 20, // html 页面
//    MEDIA_META_APK = 30, // apk
//    MEDIA_META_IMAGE = 40, // 图片，自定义
//    MEDIA_META_TEXT = 50 // 文本

@implementation MediaItem

@synthesize mId = _mId;
@synthesize mMeta = _mMeta;
@synthesize mTitle = _mTitle;
@synthesize mImage = _mImage;
@synthesize mThumbnail = _mThumbnail;
@synthesize mScore = _mScore;
@synthesize mColumnId = _mColumnId;
@synthesize mArea = _mArea;
@synthesize mCategory = _mCategory;
@synthesize mProvider = _mProvider;
@synthesize mPrice = _mPrice;
@synthesize mDuration = _mDuration;
//live
@synthesize mChannelNumber = _mChannelNumber;
@synthesize mSupportPlayback = _mSupportPlayback;
@synthesize mBitrate = _mBitrate;
@synthesize mDialogue = _mDialogue;
@synthesize mUrls = _mUrls;
@synthesize mAds = _mAds;
//vod
@synthesize mTag = _mTag;
@synthesize mPlayCount = _mPlayCount;
@synthesize mTotalSerial = _mTotalSerial;
@synthesize mCurSerial = _mCurSerial;
@synthesize mActor = _mActor;
//apk
@synthesize mVersionName = _mVersionName;
@synthesize mVersionCode = _mVersionCode;
@synthesize mPackageName = _mPackageName;
@synthesize mState = _mState;
@synthesize mByteLen = _mByteLen;
//@synthesize mUrls = _mUrls;
//Detail
@synthesize mTimeLen = _mTimeLen;
@synthesize mRecommendLevel = _mRecommendLevel;
@synthesize mLimitLevel = _mLimitLevel;
@synthesize mDirector = _mDirector;
@synthesize mScreenWriter = _mScreenWriter;
@synthesize mTotalcount = _mTotalcount;
@synthesize mReleaseTime = _mReleaseTime;
@synthesize mPagecount = _mPagecount;
@synthesize mYear = _mYear;
@synthesize mDescription = _mDescription;
@synthesize mUrlArray = _mUrlArray;

- (id) initWithJsonObject:(NSDictionary *)jsonItem
{
    if(jsonItem&& jsonItem != (id)[NSNull null])
    {
        self = [super init];
        if(self)
        {
            id tmp = [jsonItem objectForKey:@"id"];
            _mId = tmp && tmp != [NSNull null] ? tmp : @"";
            
            tmp = [jsonItem objectForKey:@"columnId"];
            _mColumnId = tmp && tmp != [NSNull null] ? [tmp integerValue] : 0;
            
            tmp = [jsonItem objectForKey:@"title"];
            _mTitle = tmp && tmp != [NSNull null] ? tmp : @"";
            
            tmp = [jsonItem objectForKey:@"meta"];
            _mMeta = tmp && tmp != [NSNull null] ? [tmp integerValue] : MEDIA_META_UNKNOW;
            
            tmp = [jsonItem objectForKey:@"score"];
            _mScore = tmp && tmp != [NSNull null] ? [tmp integerValue] : 80;
            
            tmp = [jsonItem objectForKey:@"image"];
            _mImage = tmp && tmp != [NSNull null] ? tmp : @"";
            
            tmp = [jsonItem objectForKey:@"thumbnail"];
            _mThumbnail = tmp && tmp != [NSNull null] ? tmp : @"";
            
            tmp = [jsonItem objectForKey:@"area"];
            _mArea = tmp && tmp != [NSNull null] ? tmp : @"";
            
            tmp = [jsonItem objectForKey:@"category"];
            _mCategory = tmp && tmp != [NSNull null] ? tmp : @"";
            
            tmp = [jsonItem objectForKey:@"provider"];
            _mProvider = tmp && tmp != [NSNull null] ? tmp : @"";
            
            tmp = [jsonItem objectForKey:@"price"];
            _mPrice = tmp && tmp != [NSNull null] ? [tmp integerValue] : 0;
            
            tmp = [jsonItem objectForKey:@"duration"];
            _mDuration = tmp && tmp != [NSNull null] ? [tmp integerValue] : 0;
            
            tmp = [jsonItem objectForKey:@"packageName"];
            _mPackageName = tmp && tmp != [NSNull null] ? tmp : @"";
            
            tmp = [jsonItem objectForKey:@"versionName"];
            _mVersionName = tmp && tmp != [NSNull null] ? tmp : @"";
            
            tmp = [jsonItem objectForKey:@"versionCode"];
            _mVersionCode = tmp && tmp != [NSNull null] ? tmp : @"";
            
            tmp = [jsonItem objectForKey:@"byteLen"];
            _mByteLen = tmp && tmp != [NSNull null] ? [tmp integerValue] : 0;
            
            tmp = [jsonItem objectForKey:@"actor"];
            _mActor = tmp && tmp != [NSNull null] ? tmp : @"";
            
            tmp = [jsonItem objectForKey:@"totalSerial"];
            _mTotalSerial = tmp && tmp != [NSNull null] ? [tmp integerValue] : 0;
            
            tmp = [jsonItem objectForKey:@"curSerial"];
            _mCurSerial = tmp && tmp != [NSNull null] ? [tmp integerValue] : 0;
            
            tmp = [jsonItem objectForKey:@"tag"];
            _mTag = tmp && tmp != [NSNull null] ? tmp : @"";
            
            tmp = [jsonItem objectForKey:@"playCount"];
            _mPlayCount = tmp && tmp != [NSNull null] ? [tmp integerValue] : 0;
            
            tmp = [jsonItem objectForKey:@"bitrate"];
            _mBitrate = tmp && tmp != [NSNull null] ? [tmp integerValue] : 0;
            
            tmp = [jsonItem objectForKey:@"dialogue"];
            _mDialogue = tmp && tmp != [NSNull null] ? tmp : @"";
            
            tmp = [jsonItem objectForKey:@"channelNumber"];
            _mChannelNumber = tmp && tmp != [NSNull null] ? [tmp integerValue] : 0;
            
            tmp = [jsonItem objectForKey:@"supportPlayback"];
            _mSupportPlayback = tmp && tmp != [NSNull null] ? [tmp integerValue] : 0;
            
            tmp = [jsonItem objectForKey:@"timeLen"];
            _mTimeLen = tmp && tmp != [NSNull null] ? [tmp integerValue] : 0;
            
            tmp = [jsonItem objectForKey:@"totalcount"];
            _mTotalcount = tmp && tmp != [NSNull null] ? [tmp integerValue] : 0;
            
            tmp = [jsonItem objectForKey:@"pagecount"];
            _mPagecount = tmp && tmp != [NSNull null] ? [tmp integerValue] : 0;
            
            tmp = [jsonItem objectForKey:@"year"];
            _mYear = tmp && tmp != [NSNull null] ? [tmp integerValue] : 0;
            
            tmp = [jsonItem objectForKey:@"director"];
            _mDirector = tmp && tmp != [NSNull null] ? tmp : @"";
            
            tmp = [jsonItem objectForKey:@"screentwriter"];
            _mScreenWriter = tmp && tmp != [NSNull null] ? tmp : @"";
            
            tmp = [jsonItem objectForKey:@"description"];
            _mDescription = tmp && tmp != [NSNull null] ? tmp : @"";
            
            tmp = [jsonItem objectForKey:@"recommendLevel"];
            _mRecommendLevel = tmp && tmp != [NSNull null] ? [tmp integerValue] : 0 ;
            
            tmp = [jsonItem objectForKey:@"limitLevel"];
            _mLimitLevel = tmp && tmp != [NSNull null] ? [tmp integerValue] : 0 ;
            
            tmp = [jsonItem objectForKey:@"releasetime"];
            _mReleaseTime = tmp && tmp != [NSNull null] ? [tmp doubleValue]/1000 : -1.0;
            
            NSArray *jsonList = [jsonItem objectForKey:@"urls"];
            if(jsonList&& jsonList != (id)[NSNull null])
            {
                NSMutableArray *urls = [[NSMutableArray alloc] initWithCapacity:[jsonList count] + 1];
                for (NSDictionary *jsonItem in jsonList) {
                    [urls addObject:[[UrlItem alloc] initWithJsonObject:jsonItem]];
                }
                _mUrls = urls;
            } else {
                _mUrls = nil;
            }
            
//            jsonList = [jsonItem objectForKey:@"ads"];
//            if(jsonList&& jsonList != (id)[NSNull null])
//            {
//                NSMutableArray *ads = [[NSMutableArray alloc] initWithCapacity:[jsonList count] + 1];
//                for (NSDictionary *jsonItem in jsonList) {
//                    [ads addObject:[[AdItem alloc] initWithJsonObject:jsonItem]];
//                }
//                _mAds = ads;
//            } else {
//                _mAds = nil;
//            }
        }
        return self;
    }
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_mId forKey:@"MediaItemId"];
    [aCoder encodeObject:_mTitle forKey:@"MediaItemTitle"];
    [aCoder encodeInteger:_mMeta forKey:@"MediaItemMeta"];
    [aCoder encodeInteger:_mScore forKey:@"MediaItemScore"];
    [aCoder encodeObject:_mThumbnail forKey:@"MediaItemThumbnail"];
    [aCoder encodeObject:_mImage forKey:@"MediaItemImage"];
    [aCoder encodeInteger:_mColumnId forKey:@"MediaItemColumnId"];
    [aCoder encodeObject:_mArea forKey:@"marea"];
    [aCoder encodeObject:_mCategory forKey:@"mCategory"];
    [aCoder encodeObject:_mProvider forKey:@"mProvider"];
    [aCoder encodeInteger:_mPrice forKey:@"mprice"];
    [aCoder encodeInteger:_mDuration forKey:@"mduration"];
    [aCoder encodeInteger:_mTimeLen forKey:@"mtimelen"];
    [aCoder encodeInteger:_mTotalcount forKey:@"mtolalcount"];
    [aCoder encodeInteger:_mPagecount forKey:@"mpagecout"];
    [aCoder encodeInteger:_mYear forKey:@"myear"];
    [aCoder encodeInteger:_mSupportPlayback forKey:@"mSupportPlayback"];
    [aCoder encodeObject:_mUrls forKey:@"MediaItemUrls"];
    [aCoder encodeObject:_mAds forKey:@"MediaItemAds"];
    [aCoder encodeInteger:_mBitrate forKey:@"MediaItemBitrate"];
    [aCoder encodeInteger:_mChannelNumber forKey:@"MediaItemChannelNumber"];
    [aCoder encodeObject:_mActor forKey:@"mactor"];
    [aCoder encodeObject:_mDirector forKey:@"mdirector"];
    [aCoder encodeObject:_mTag forKey:@"MediaItemTag"];
    [aCoder encodeInteger:_mPlayCount forKey:@"MediaItemPlayCount"];
    [aCoder encodeInteger:_mTotalSerial forKey:@"mtotalserials"];
    [aCoder encodeInteger:_mCurSerial forKey:@"mcurserial"];
    [aCoder encodeObject:_mPackageName forKey:@"MediaItemPackageName"];
    [aCoder encodeInteger:_mByteLen forKey:@"MediaItemByteLength"];
    [aCoder encodeObject:_mVersionName forKey:@"MediaItemVersionName"];
    [aCoder encodeObject:_mVersionCode forKey:@"MediaItemVersionCode"];
    [aCoder encodeObject:_mScreenWriter forKey:@"MediaItemScreenWriter"];
    [aCoder encodeObject:_mDescription forKey:@"MediaItemDescription"];
    [aCoder encodeObject:_mDialogue forKey:@"MediaItemDialogue"];
    [aCoder encodeInteger:_mRecommendLevel forKey:@"MediaitemRecommendLevel"];
    [aCoder encodeInteger:_mLimitLevel forKey:@"MediaItemLimitLevel"];
    [aCoder encodeDouble:_mReleaseTime forKey:@"MediaItemReleaseTime"];
    [aCoder encodeInteger:_mState forKey:@"apkstate"];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        _mId = [aDecoder decodeObjectForKey:@"MediaItemId"];
        _mTitle = [aDecoder decodeObjectForKey:@"MediaItemTitle"];
        _mMeta = [aDecoder decodeIntegerForKey:@"MediaItemMeta"];
        _mScore = [aDecoder decodeIntegerForKey:@"MediaItemScore"];
        _mThumbnail = [aDecoder decodeObjectForKey:@"MediaItemThumbnail"];
        _mImage = [aDecoder decodeObjectForKey:@"MediaItemImage"];
        _mColumnId = [aDecoder decodeIntegerForKey:@"MediaItemColumnId"];
        _mArea = [aDecoder decodeObjectForKey:@"marea"];
        _mCategory = [aDecoder decodeObjectForKey:@"mCategory"];
        _mProvider = [aDecoder decodeObjectForKey:@"mProvider"];
        _mPrice = [aDecoder decodeIntegerForKey:@"mprice"];
        _mDuration = [aDecoder decodeIntegerForKey:@"mduration"];
        _mTimeLen = [aDecoder decodeIntegerForKey:@"mtimelen"];
        _mTotalcount = [aDecoder decodeIntegerForKey:@"mtolalcount"];
        _mPagecount = [aDecoder decodeIntegerForKey:@"mpagecout"];
        _mYear = [aDecoder decodeIntegerForKey:@"myear"];
        _mSupportPlayback = [aDecoder decodeIntegerForKey:@"mSupportPlayback"];
        _mBitrate = [aDecoder decodeIntegerForKey:@"MediaItemBitrate"];
        _mChannelNumber = [aDecoder decodeIntegerForKey:@"MediaItemChannelNumber"];
        _mPlayCount = [aDecoder decodeIntegerForKey:@"MediaItemPlayCount"];
        _mCurSerial = [aDecoder decodeIntegerForKey:@"mcurserial"];
        _mByteLen = [aDecoder decodeIntegerForKey:@"MediaItemByteLength"];
        _mPackageName = [aDecoder decodeObjectForKey:@"MediaItemPackageName"];
        _mVersionName = [aDecoder decodeObjectForKey:@"MediaItemVersionName"];
        _mVersionCode = [aDecoder decodeObjectForKey:@"MediaItemVersionCode"];
        _mDirector = [aDecoder decodeObjectForKey:@"mdirector"];
        _mTag = [aDecoder decodeObjectForKey:@"MediaItemTag"];
        _mActor = [aDecoder decodeObjectForKey:@"mactor"];
        _mScreenWriter = [aDecoder decodeObjectForKey:@"MediaItemScreenWriter"];
        _mDescription = [aDecoder decodeObjectForKey:@"MediaItemDescription"];
        _mDialogue = [aDecoder decodeObjectForKey:@"MediaItemDialogue"];
        _mRecommendLevel = [aDecoder decodeIntegerForKey:@"MediaItemRecommendLevel"];
        _mLimitLevel = [aDecoder decodeIntegerForKey:@"MediaItemLimitLevel"];
        _mTotalSerial = [aDecoder decodeIntegerForKey:@"MediaItemTotalSerial"];
        _mReleaseTime = [aDecoder decodeDoubleForKey:@"MediaItemReleaseTime"];
        _mUrls = [aDecoder decodeObjectForKey:@"MediaItemUrls"];
        _mAds = [aDecoder decodeObjectForKey:@"MediaItemAds"];
        _mState =[aDecoder decodeIntegerForKey:@"apkstate"];
    }
    
    return self;
}

- (id) copyWithZone:(NSZone *)zone
{
    MediaItem *item = [[[self class] allocWithZone:zone] init];
    item.mId = _mId;
    item.mTitle = _mTitle;
    item.mMeta = _mMeta;
    item.mScore = _mScore;
    item.mThumbnail = _mThumbnail;
    item.mImage = _mImage;
    item.mColumnId = _mColumnId;
    item.mArea = _mArea;
    item.mProvider = _mProvider;
    item.mCategory = _mCategory;
    item.mPrice = _mPrice;
    item.mDuration = _mDuration;
    item.mVersionName = _mVersionName;
    item.mVersionCode = _mVersionCode;
    item.mPackageName = _mPackageName;
    item.mByteLen = _mByteLen;
    item.mTag = _mTag;
    item.mPlayCount = _mPlayCount;
    item.mTotalSerial = _mTotalSerial;
    item.mCurSerial = _mCurSerial;
    item.mActor = _mActor;
    item.mChannelNumber = _mChannelNumber;
    item.mSupportPlayback = _mSupportPlayback;
    item.mBitrate = _mBitrate;
    item.mDialogue = _mDialogue;
    item.mTimeLen = _mTimeLen;
    item.mRecommendLevel = _mRecommendLevel;
    item.mLimitLevel = _mLimitLevel;
    item.mDirector = _mDirector;
    item.mScreenWriter = _mScreenWriter;
    item.mTotalcount = _mTotalcount;
    item.mReleaseTime = _mReleaseTime;
    item.mPagecount = _mPagecount;
    item.mYear = _mYear;
    item.mDescription = _mDescription;
    item.mUrls = [NSArray arrayWithArray:_mUrls];
    item.mAds = [NSArray arrayWithArray:_mAds];
    item.mState = _mState;
    return item;
}

- (UrlItem *)getUrlItemByProvider:(NSString *)provider quality:(UrlQuality)quality
{
    UrlItem *result = nil;
    for(UrlItem *url in _mUrls)
    {
        //检查来源
        if (provider && ![url.mProvider isEqualToString:provider]) {
            continue;
        }
        
        //检查清晰度
        if (url.mQuality == quality || quality == QUALITY_UNKNOWN) {
            //找到了想要的
            return url;
        }
        
        if (!result) {
            result = url;
        }
        //未找到对应清晰度的，继续寻找最接近的（高质量优先）
        if (url.mQuality == QUALITY_UNKNOWN || url.mQuality == result.mQuality)
        {
            continue;
        }
        else
        {
            NSInteger abs1 = abs(result.mQuality - quality);
            NSInteger abs2 = abs(url.mQuality - quality);
            if ((abs2 < abs1) || ((abs1 == abs2) && (url.mQuality > result.mQuality))) {
                result = url;
            }
        }
    }
    if (!result) {
        //没找到则返回第一个
        result = [_mUrls firstObject];
    }
    return result;
}


- (UrlItem *)getUrlItemByProvider:(NSString *)provider quality:(UrlQuality)quality serail:(NSInteger)serail
{
    UrlItem *result = nil;
    for(UrlItem *url in _mUrls)
    {
        //检查集数
        if(url.mSerial != serail)
        {
            continue;
        }
        //检查来源
        if (provider && ![url.mProvider isEqualToString:provider]) {
            continue;
        }
        
        //检查清晰度
        if (url.mQuality == quality || quality == 0) {
            //找到了想要的
            return url;
        }
        
        //未找到对应清晰度的，继续寻找最接近的（高质量优先）
        if (!result)
        {
            result = url;
        }
        
        if (!url.mIsFinal && ([url.mUrl rangeOfString:@"sohu."].length > 0 || [url.mUrl rangeOfString:@"iqiyi."].length > 0 || [url.mUrl rangeOfString:@"letv."].length > 0 || [url.mUrl rangeOfString:@"tudou."].length > 0))
        {
            //视频聚合片源优先用这四个网站的
            result = url;
            break;
        }
        if (url.mQuality == 0 || url.mQuality == result.mQuality) {
            //若清晰度都未知则不比较
            continue;
        } else{
            //未找到对应清晰度的，继续寻找最接近的（高质量优先）
            NSInteger abs1 = abs(result.mQuality - quality);
            NSInteger abs2 = abs(url.mQuality - quality);
            if ((abs2 < abs1) || ((abs1 == abs2) && (url.mQuality > result.mQuality))) {
                result = url;
            }
        }
    }
    if (!result) {
        //总要有东西拿来播，没找到则返回第一个。
        result = [_mUrls firstObject];
    }
    return result;
}

- (NSArray *)mUrlArray
{
    if (!_mUrlArray) {
        NSMutableDictionary *urlDictionary = [[NSMutableDictionary alloc] init];
        for (UrlItem *url in _mUrls) {
            //若provider有值则按provider筛选
            [urlDictionary setValue:url forKey:[NSString stringWithFormat:@"%ld", (long)url.mSerial]];
        }
        
        NSArray *unSortedArr = [urlDictionary allValues];
        if ([unSortedArr count] <= 1) {
            //不需要排序
            _mUrlArray = unSortedArr;
        }else{
            //多集片源
            //按集数升秩排序
            NSArray *sortedArr = [unSortedArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                if ([obj1 isKindOfClass:[UrlItem class]] && [obj2 isKindOfClass:[UrlItem class]]) {
                    NSInteger e1 = ((UrlItem *)obj1).mSerial;
                    NSInteger e2 = ((UrlItem *)obj2).mSerial;
                    if (e1 > e2) {
                        return NSOrderedDescending;
                    }else if(e1 < e2) {
                        return NSOrderedAscending;
                    }
                }
                return NSOrderedSame;
            }];
            _mUrlArray = sortedArr;
        }
    }
    return _mUrlArray;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"MediaItem id=%@ title=%@ meta=%ld score=%ld thumbnail=%@ image=%@ columnid=%ld", _mId, _mTitle, (long)_mMeta, (long)_mScore, _mThumbnail, _mImage, (long)_mColumnId];
}

@end

