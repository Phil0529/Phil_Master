//
//  ConfigMap.h
//  EZTV
//
//  Created by Lee, Bo on 15/11/17.
//  Copyright © 2015年 Joygo. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ConfigMap : MTLModel<MTLJSONSerializing>

//摇一摇
@property (nonatomic, copy) NSString* discount;
@property (nonatomic, copy) NSString* mycoin;

//个人中心
@property (nonatomic, copy) NSString* shopright;
@property (nonatomic, copy) NSString* shopcart;
@property (nonatomic, copy) NSString* myorder;
@property (nonatomic, copy) NSString* welfare;
@property (nonatomic, copy) NSString* myqna;
@property (nonatomic, copy) NSString* qrcode;

//设置
@property (nonatomic, copy) NSString* about;
@property (nonatomic, copy) NSString* feedback;
@property (nonatomic, copy) NSString* myfeedback;

//应用分享
@property (nonatomic, copy) NSString* sharelink;
@property (nonatomic, copy) NSString* sharetitle;
@property (nonatomic, copy) NSString* sharecontent;
@property (nonatomic, copy) NSString* shareicon;

//协议
@property (nonatomic, copy) NSString* agreement;
@property (nonatomic, copy) NSString* uploadagreement;
@property (nonatomic, copy) NSString* vodabout;

//微直播
@property (nonatomic, copy) NSString* myvod;
@property (nonatomic, copy) NSString* vodshare;

//广播
@property (nonatomic, copy) NSString* broadcastshare;

@property (nonatomic, copy) NSString* domain;

//穿越
@property (nonatomic, copy) NSString* isTransfer;

@end
