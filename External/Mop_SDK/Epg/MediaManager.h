//
//  SWMediaManager.h
//  SWMOP
//
//  Created by Lee, Bo on 14-6-11.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MediaItem.h"
#import "SyncManager.h"

static NSString* const MSG_LOAD_MEDIA_LIST_FINISH = @"MSG_LOAD_MEDIA_LIST_FINISH";

static NSString* const META_SEARCH_ALL = @"-1";
static NSString* const META_SEARCH_ALLVOD = @"1|2|3|4|6";
static NSString* const META_SEARCH_ALLLIVE = @"0|5";
static NSString* const META_SEARCH_SERVICE_PAK = @"10";

static NSString* const SORT_DEFAULT = @"sort"; // 默认排序字段，按媒资发布上架的先后顺序，后上架的排在前面
static NSString* const SORT_BY_TIME = @"time"; // 按上映时间降序
static NSString* const SORT_BY_POPULAR = @"popular"; // 按人气（播放次数）降序
static NSString* const SORT_BY_SCORE = @"score"; // 按评分降序
static NSString* const SORT_BY_CHNLNUM = @"chnlnum"; // 按频道号升序
static NSString* const SORT_BY_TAG = @"tag"; // 按tag排序，首先是tag的记录排在前面，剩下的按time上映时间降序
static NSString* const SORT_BY_TAGS = @"tags"; // 按tag排序，首先是tag的记录排在前面，剩下的按上架时间降序

//typedef NS_ENUM(NSInteger, MediaMetaType)
//{
//    MEDIA_META_UNKNOW           = -1,
//    MEDIA_META_LIVE_CHANNEL     = 0, // 频道直播
//    MEDIA_META_LIVE_ABR         = 5, // 直播ABR

//    MEDIA_META_VOD_SINGLE       = 1, // 单集片源
//    MEDIA_META_VOD_PROGRAMS     = 2, // 电视剧
//    MEDIA_META_VOD_FILMS        = 3, // 系列电影
//    MEDIA_META_VOD_GROUP        = 4, // 点播组
//    MEDIA_META_VOD_ABR          = 6, // 点播ABR

//    MEDIA_META_SERVICE_PACKAGE  = 10,// 产品包

//    MEDIA_META_HTML             = 20,// html 页面
//    MEDIA_META_APK              = 30,// apk
//    MEDIA_META_IMAGE            = 40,// 图片，自定义
//    MEDIA_META_TEXT             = 50, // 文本
//    MEDIA_META_LOCAL            = 100// 本地资源
//};



@interface MediaManager : NSObject<SyncListener>

+ (id)sharedInstance;

//- (NSArray *)getLiveListAllSortBy:(NSString *)sort;

- (NSArray *)getListWithColumnId:(NSInteger)columnId
                            meta:(NSString *)meta
                        category:(NSString *)category
                            area:(NSString *)area
                             tag:(NSString *)tag
                            year:(NSString *)year
                           title:(NSString *)title
                          pinyin:(NSString *)pinyin
                           actor:(NSString *)actor
                        director:(NSString *)director
                            sort:(NSString *)sort;

- (void)loadMediaWithColumnId:(NSInteger)columnId
                         meta:(NSString *)meta
                     category:(NSString *)category
                         area:(NSString *)area
                          tag:(NSString *)tag
                         year:(NSString *)year
                        title:(NSString *)title
                       pinyin:(NSString *)pinyin
                        actor:(NSString *)actor
                     director:(NSString *)director
                         sort:(NSString *)sort
                     pageSize:(NSUInteger)pageSize
                   completion:(void(^)(NSArray *result ,BOOL changed, BOOL complete))completion;;

- (BOOL)isCompleteWithColumnId:(NSInteger)columnId
                          meta:(NSString *)meta
                      category:(NSString *)category
                          area:(NSString *)area
                           tag:(NSString *)tag
                          year:(NSString *)year
                         title:(NSString *)title
                        pinyin:(NSString *)pinyin
                         actor:(NSString *)actor
                      director:(NSString *)director
                          sort:(NSString *)sort;

- (BOOL)refreshMediaWithColumnId:(NSInteger) columnId
                            meta:(NSString *)meta
                        category:(NSString *)category
                            area:(NSString *)area
                             tag:(NSString *)tag
                            year:(NSString *)year
                           title:(NSString *)title
                          pinyin:(NSString *)pinyin
                           actor:(NSString *)actor
                        director:(NSString *)director
                            sort:(NSString *)sort;

- (void)clearCache;

@end
