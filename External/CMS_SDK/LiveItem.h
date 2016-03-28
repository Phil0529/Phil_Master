//
//  LiveItem.h
//  EZTV
//
//  Created by Lee, Bo on 15/8/11.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "MTLModel.h"
#import "TagItem.h"
#import "ActivityDetailModel.h"
#import "LiveResponseModel.h"

@interface AdsItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *envelope;
@property (nonatomic, copy) NSString *commodity;
@property (nonatomic, copy) NSString *url;

@end

@interface AuthorItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *mpno;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *headimg;
@property (nonatomic, copy) NSString *roles;

@end

@interface StreamItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *cdsId;
@property (nonatomic, copy) NSString *cdsIP;
@property (nonatomic, copy) NSString *cdsPort;
@property (nonatomic, assign) NSInteger delayTime;

@end

typedef NS_ENUM(NSInteger, LiveType)
{
    LiveType_Living = 0,      //直播中
    LiveType_Video = 1,       //录播
    LiveType_Trailer = 2,      //预告
    LiveType_UpVideo = 3,      //上传录播
};

typedef NS_ENUM(NSInteger, TSMediaMode) {
    TSMediaMode_SelfAdapt   = 0,        //自适应模式
    TSMediaMode_Smooth      = 1,        //流畅模式
    TSMediaMode_Standard    = 2,        //标清模式
    TSMediaMode_HD          = 3         //高清模式
};

@interface LiveItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *lid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *pics;
@property (nonatomic, copy) NSString *tagicon;
@property (nonatomic, strong) TagItem *tag;
@property (nonatomic, strong) AdsItem *ads;
@property (nonatomic, strong) AuthorItem *author;
@property (nonatomic, strong) StreamItem *stream;
@property (nonatomic, strong) ChatRoomModel *chatroom;
@property (nonatomic, strong) NSArray *guest;
@property (nonatomic, assign) LiveType type;
@property (nonatomic, assign) NSInteger assistcount;
@property (nonatomic, assign) NSTimeInterval createtime;
@property (nonatomic, assign) NSTimeInterval starttime;
@property (nonatomic, copy) UIImage *coverImg;
@property (nonatomic, copy) NSNumber *isads;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lon;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, strong) NSString *show;
@property (nonatomic, retain) NSDictionary *locationDict;

@property (nonatomic, assign) TSMediaMode mode;

- (NSString *)getPlayUrl;

@end
