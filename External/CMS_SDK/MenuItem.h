//
//  MenuItem.h
//  EZTV
//
//  Created by Lee, Bo on 15/5/19.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "EZColumnItem.h"

typedef NS_ENUM(NSUInteger, MenuType) {
//    MenuTypeHidden = -1,
    MenuTypeHome = 10,          //首页
    MenuTypeShake = 11,         //摇得宝
    MenuTypeLive = 12,          //微直播
    MenuTypeScan = 13,          //扫一扫
    MenuTypeTv = 100,           //直播
    MenuTypeBroadCast = 110,    //微广播
    MenuTypeMovie = 200,        //云端影视
    MenuTypeSimpleNews = 300,   //简单新闻
    MenuTypeMultiNews = 400,    //多列新闻
    MenuTypeMultiNewsTop = 810, //多列新闻只要有顶栏
    MenuTypeUser = 600,         //个人中心
    MenuTypeMarket = 700,       //商城
    MenuTypeTop = 800,          //只有顶栏的网页(美食街)
    MenuTypeBottom = 900,       //只有底部的网页(主持人)
    MenuTypeFull = 1000,        //全屏网页
    MenuTypeNewsHome = 1100,    //新闻首页
    MenuTypeService = 1200,     //服务
    MenuTypeDiscovery = 1300,   //发现
    MenuTypeSponsor = 210,      //合作商户
    MenuTypeLocation = 10001,   //定位
    MenuTypePay = 10002         //支付
};

typedef NS_ENUM(NSUInteger, MenuPosition)
{
    PositionCenter = 0, //中间
    PositionLeft = 1,   //左边
    PositionRigth = 2,  //右边
};

typedef NS_ENUM(NSUInteger, TabIcon)
{
    TabIconCommon = 0,
    TabIconHome = 1,
    TabIconNews = 2,
    TabIconLotery = 3,
    TabIconVideo = 4,
    TabIconService = 5,
    TabIconDiscovery = 6,
    TabIconActivity = 7,
    TabIconShake = 8,
    TabIconMall = 9,
    TabIconLive = 10,
    TabIconCloud = 11,
};

@interface MenuItem : EZColumnItem<MTLJSONSerializing>

@property (nonatomic, assign) MenuType menutype;
@property (nonatomic, assign) MenuPosition position;
@property (nonatomic, assign) TabIcon tabIcon;

+ (MenuItem *)defaultItem;

@end

@interface MenuMap : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSArray *list;

@end
