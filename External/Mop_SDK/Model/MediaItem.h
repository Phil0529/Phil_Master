//
//  MediaItem.h
//  SWMOP
//
//  Created by Lee, Bo on 11/4/14.
//  Copyright (c) 2014 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UrlItem.h"

typedef NS_ENUM(NSInteger, MediaMetaType)
{
    MEDIA_META_UNKNOW           = -1,
    MEDIA_META_LIVE_CHANNEL     = 0, // 频道直播
    MEDIA_META_VOD_SINGLE       = 1, // 单集片源
    MEDIA_META_VOD_PROGRAMS     = 2, // 电视剧
    MEDIA_META_VOD_FILMS        = 3, // 系列电影
    MEDIA_META_VOD_GROUP        = 4, // 点播组
    MEDIA_META_LIVE_ABR         = 5, // 直播ABR
    MEDIA_META_VOD_ABR          = 6, // 点播ABR
    MEDIA_META_SERVICE_PACKAGE  = 10,// 产品包
    MEDIA_META_HTML             = 20,// html 页面
    MEDIA_META_APK              = 30,// apk
    MEDIA_META_IMAGE            = 40,// 图片，自定义
    MEDIA_META_TEXT             = 50, // 文本
    MEDIA_META_LOCAL            = 100// 本地资源
};

typedef NS_ENUM(NSInteger, ApkState) {
    STATE_UNKNOWN = 0,//未知
    STATE_EMPTY,//未下载未安装
    STATE_DOWNLOADED,//已下载未安装
    STATE_INSTALLED,//已下载已安装
};

@interface MediaItem : NSObject<NSCoding, NSCopying>

@property (nonatomic, strong) NSString *mId; // 频道ID
@property (nonatomic, assign) MediaMetaType mMeta; // 媒资类型: 频道直播, 单集片源 等
@property (nonatomic, strong) NSString *mTitle; // 片名
@property (nonatomic, strong) NSString *mImage; // 海报图
@property (nonatomic, strong) NSString *mThumbnail; // 缩略图
@property (nonatomic, assign) NSInteger mScore; // 评分
@property (nonatomic, assign) NSInteger mColumnId; // 媒资所在的栏目id
@property (nonatomic, assign) NSInteger mPrice; // 价格（单位美分）
@property (nonatomic, assign) NSInteger mDuration; // 有效期（单位小时）
@property (nonatomic, strong) NSString *mArea; // 地区
@property (nonatomic, strong) NSString *mCategory; // 类别
@property (nonatomic, strong) NSString *mProvider; // 来源
@property (nonatomic, assign) NSInteger mTimeLen; // 时间长度(单位秒), -1表示无限长(直播)
@property (nonatomic, assign) NSInteger mRecommendLevel; // 推荐级别
@property (nonatomic, assign) NSInteger mLimitLevel; // 限制级别
@property (nonatomic, assign) NSInteger mTotalSerial; // 总集数
@property (nonatomic, assign) NSInteger mCurSerial; // 当前更新集数
@property (nonatomic, assign) NSInteger mPlayCount; // 播放次数
@property (nonatomic, assign) NSInteger mBitrate; // 码率
@property (nonatomic, assign) NSInteger mChannelNumber; // 频道号（channel media专用）
@property (nonatomic, assign) NSInteger mSupportPlayback; // 是否支持回看， 1-支持， 0-不支持（channel media专用）
@property (nonatomic, strong) NSString *mVersionName; // 版本名（apk media专用）
@property (nonatomic, strong) NSString *mVersionCode; // 版本号（apk media专用）
@property (nonatomic, strong) NSString *mPackageName; // 包名（apk media专用）
@property (nonatomic, strong) NSString *mDirector; // 导演
@property (nonatomic, strong) NSString *mScreenWriter; // 编剧
@property (nonatomic, strong) NSString *mDialogue; // 对白语言
@property (nonatomic, assign) NSInteger mTotalcount; // 总数， 针对的是urls， url个数
@property (nonatomic, assign) NSTimeInterval mReleaseTime; // 上映时间
@property (nonatomic, assign) NSInteger mPagecount; // 页数, 针对的是urls
@property (nonatomic, strong) NSString *mActor; // 演员
@property (nonatomic, strong) NSString *mTag; // 标签
@property (nonatomic, assign) NSInteger mYear; // 年份
@property (nonatomic, strong) NSString *mDescription;// 简介
@property (nonatomic, assign) long mByteLen; // 文件字节大小 -1表示无限长（直播）
@property (nonatomic, assign) ApkState mState; // 状态（apk media专用）:未知,未下载,已下载未安装,已安装
@property (nonatomic, strong) NSArray *mUrls; // url列表，用于点播直播媒资
@property (nonatomic, strong) NSArray *mAds; // 广告列表
@property (nonatomic, strong, readonly) NSArray *mUrlArray; //所有集数各取其一的url列表.

- (id)initWithJsonObject:(NSDictionary *)jsonItem;

- (UrlItem *)getUrlItemByProvider:(NSString*)provider quality:(UrlQuality)quality;

- (UrlItem *)getUrlItemByProvider:(NSString*)provider quality:(UrlQuality)quality serail:(NSInteger)serail;

@end


