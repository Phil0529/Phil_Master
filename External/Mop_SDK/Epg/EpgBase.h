//
//  EpgBase.h
//  SWMOP
//
//  Created by guoziyi on 14-2-26.
//  Copyright (c) 2014年 husl. All rights reserved.
//

#import <Foundation/Foundation.h>

//static NSString *EPGS_SYNC_FINISH = @"epgs_sync_finish";
//static NSString *EPGS_AD_MAP_FINISH = @"epgs_ad_map_finish";
//static NSString *EPGS_AD_FINISH = @"epgs_ad_finish";
//static NSString *EPGS_COLUMN_MAP_FINISH = @"epgs_column_map_finish";
//static NSString *EPGS_COLUMN_SUB_FINISH = @"epgs_column_sub_finish";
//static NSString *EPGS_COLUMN_QUERY_FINISH = @"epgs_column_query_finish";
//static NSString *EPGS_AREA_FINISH = @"epgs_area_finish";
//static NSString *EPGS_CATEGORY_FINISH = @"epgs_category_finish";
//static NSString *EPGS_EPG_FINISH = @"epgs_epg_finish";
//static NSString *EPGS_MEDIA_FINISH = @"epgs_media_finish";
//static NSString *EPGS_MEDIA_DETAIL_FINISH = @"egps_media_detail_finish";
//static NSString *EPGS_REALURL_FINISH = @"epgs_realurl_finish";

@interface EpgBase : NSObject

+ (NSString *)getBasePath;

+ (NSString *)getSyncPath;

+ (NSString *)getAdMapPath;

+ (NSString *)getAdByColumnIdPath:(NSInteger)columnId;

+ (NSString *)getColumnMapPath:(NSString *)lang;

+ (NSString *)getColumnListPath:(NSString *)lang;

+ (NSString *)getColumnSubPath:(NSInteger)pid lang:(NSString *)lang;

+ (NSString *)getColumnQueryPath:(NSInteger)columnId pid:(NSInteger)pid title:(NSString *)title lang:(NSString *)lang;

+ (NSString *)getAreaPath:(NSString *)lang;

+ (NSString *)getCategoryPath:(NSInteger)columnId lang:(NSString *)lang;

+ (NSString *)getEpgPath:(NSString *)columnId startUtc:(NSTimeInterval)startUtc endUtc:(NSTimeInterval)endUtc lang:(NSString *)lang;

+ (NSString *)getEpgPath:(NSString *)columnId date:(NSString *)date timezone:(NSInteger)timezone days:(NSInteger)days lang:(NSString *)lang;

+ (NSString *)getMediaPath:(NSInteger)columnId Meta:(NSString *)meta PageIndex:(NSInteger)pageIndex lang:(NSString *)lang pageSize:(NSUInteger)pageSize;

+ (NSMutableDictionary*)getMediaParamsWithCategory:(NSString *)category Area:(NSString *)area Tag:(NSString *)tag Year:(NSString *)year Title:(NSString *)title Pinyin:(NSString *)pinyin Actor:(NSString *)actor Director:(NSString *)director Sort:(NSString *)sort;

+ (NSString *)getMediaDetailPath:(NSInteger)columnId MediaId:(NSString *)mediaId Provider:(NSString *)provider lang:(NSString *)lang;

+ (NSString *)getRealUrlPath:(NSString *)url Quality:(NSInteger)quality;

@end
