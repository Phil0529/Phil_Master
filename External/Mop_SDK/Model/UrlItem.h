//
//  UrlItem.h
//  SWMOP
//
//  Created by Lee, Bo on 11/4/14.
//  Copyright (c) 2014 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, UrlQuality) {
    QUALITY_UNKNOWN = 0,     //未知
    QUALITY_LOW = 1,        //低清
    QUALITY_STANDARD  = 2,        //标清
    QUALITY_HIGH  = 3,        //高清
    QUALITY_SUPER = 4,        //超清
    QUALITY_720P = 5         //4K
};


@interface UrlItem : NSObject<NSCoding, NSCopying>

@property (nonatomic, strong) NSString *mUrl;// 该集的url
@property (nonatomic, assign) NSInteger mSerial; // 第几集
@property (nonatomic, assign) BOOL mIsFinal; // 是否最终的播放地址
@property (nonatomic, strong) NSString *mProvider; // 视频来源 (优酷, 土豆之类)
@property (nonatomic, assign) UrlQuality mQuality; // 清晰度： 0-未知, 1-低清， 2-标清， 3-高清， 4-超清
@property (nonatomic, strong) NSString *mTitle; // 标题
@property (nonatomic, strong) NSString *mDescription; // 描述
@property (nonatomic, strong) NSString *mImage; //海报图
@property (nonatomic, strong) NSString *mThumbnail; // 缩略图

- (id) initWithJsonObject:(NSDictionary *)jsonItem;

@end
