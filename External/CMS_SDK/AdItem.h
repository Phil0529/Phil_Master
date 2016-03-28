//
//  AdItem.h
//  EZTV
//
//  Created by Lee, Bo on 15/5/20.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuItem.h"
#import "EZMediaItem.h"

typedef NS_ENUM(NSUInteger, AdType)
{
    AdTypeMall = 1,     //跳转商城页面
    AdTypeMenu = 2,     //跳转2级界面
    AdTypeWeb = 3,      //跳转网页
    AdTypeMedia = 4,    //跳转新闻详情
};

@interface AdItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *adimg;
@property (nonatomic, assign) AdType adtype;
@property (nonatomic, strong) NSString *adurl;
@property (nonatomic, strong) MenuItem *menuitem;
@property (nonatomic, strong) EZMediaItem *mediaItem;

@end
