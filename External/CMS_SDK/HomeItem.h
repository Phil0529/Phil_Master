//
//  HomeItem.h
//  EZTV
//
//  Created by Lee, Bo on 15/5/2.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuItem.h"
#import "EZMediaItem.h"
#import "LiveItem.h"
#import "AdItem.h"

typedef NS_ENUM(NSUInteger, HomeType)
{
    HomeTypeNews = 0,       //横划新闻
    HomeTypeColumn = 1,     //横划栏目  deprecated
    HomeTypeLive = 2,       //固定竖排横条 deprecated
    HomeTypeMenu = 3,       //本地服务模块
    HomeTypeAd = 4,         //商城
    HomeTypeTv = 5,         //微电视
    HomeTypeExcel = 6,      //表格样式
    HomeTypeMLive = 7,      //微直播列表
    HomeTypeScroll = 8,     //轮播
};

@interface HomeItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) HomeType hometype;
@property (nonatomic, assign) NSInteger rowcount;
@property (nonatomic, assign) NSInteger columncount;
@property (nonatomic, strong) MenuItem *menuitem;
@property (nonatomic, strong) NSDictionary* list;
@property (nonatomic, strong) NSArray *subList;

@end
