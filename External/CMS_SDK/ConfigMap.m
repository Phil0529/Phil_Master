//
//  ConfigMap.m
//  EZTV
//
//  Created by Lee, Bo on 15/11/17.
//  Copyright © 2015年 Joygo. All rights reserved.
//

#import "ConfigMap.h"

@implementation ConfigMap

//摇一摇
@synthesize discount = _discount;
@synthesize mycoin = _mycoin;

//个人中心
@synthesize shopright = _shopright;
@synthesize shopcart = _shopcart;
@synthesize myorder = _myorder;
@synthesize welfare = _welfare;
@synthesize myqna = _myqna;
@synthesize qrcode = _qrcode;

//设置
@synthesize about = _about;
@synthesize feedback = _feedback;
@synthesize myfeedback = _myfeedback;

//应用分享
@synthesize sharelink = _sharelink;
@synthesize sharetitle = _sharetitle;
@synthesize sharecontent = _sharecontent;
@synthesize shareicon = _shareicon;

//协议
@synthesize agreement = _agreement;
@synthesize uploadagreement = _uploadagreement;
@synthesize vodabout = _vodabout;

//微直播
@synthesize myvod = _myvod;
@synthesize vodshare = _vodshare;

//广播
@synthesize broadcastshare = _broadcastshare;


+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"discount" : @"discount",
             @"mycoin" : @"mycoin",
             @"shopright" : @"shopright",
             @"shopcart" : @"shopcart",
             @"myorder" : @"myorder",
             @"welfare" : @"welfare",
             @"myqna" : @"myqna",
             @"qrcode" : @"qrcode",
             @"about" : @"about",
             @"feedback" : @"feedback",
             @"myfeedback" : @"myfeedback",
             @"sharelink" : @"sharelink",
             @"sharetitle" : @"sharetitle",
             @"sharecontent" : @"sharecontent",
             @"shareicon" : @"shareicon",
             @"agreement" : @"agreement",
             @"uploadagreement" : @"uploadagreement",
             @"vodabout" : @"vodabout",
             @"myvod" : @"myvod",
             @"vodshare" : @"vodshare",
             @"broadcastshare" : @"broadcastshare",
             @"domain": @"domain",
             @"isTransfer": @"istransfer"};
}

@end
