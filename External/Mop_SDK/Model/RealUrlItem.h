//
//  RealUrlItem.h
//  SWMOP
//
//  Created by Lee, Bo on 11/4/14.
//  Copyright (c) 2014 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UrlItem.h"

@interface RealUrlItem : NSObject<NSCoding, NSCopying>

@property (nonatomic, strong) NSString *mUrl;// 真实播放地址
@property (nonatomic, strong) NSString *mTitle;// 标题
@property (nonatomic, strong) NSString *mQualitys;// 清晰度列表, 0-未知、 1-低清、2-标清、 3-高清、4-超清， 格式形如：2|3|4,
@property (nonatomic, assign) NSInteger mQuality;// 当前url清晰度

- (id) initWithJsonObject:(NSDictionary *)jsonItem;
@end
