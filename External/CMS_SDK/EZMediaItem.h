//
//  EZMediaItem.h
//  HuaXia
//
//  Created by Lee, Bo on 15/3/26.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"

typedef NS_ENUM(NSUInteger, MediaType) {
    MediaTypeNews = 1,      //1=新闻
    MediaTypeVideo = 2,     //2=视频
    MediaTypeImageSet = 3,    //3=图片集
    MediaTypeTopic = 4,     //4=专题
    MediaTypeActivity = 5,  //5=活动
    MediaTypeFood = 6,
    MediaTypeVote = 7,
    MediaTypeAd = 8,        //广告
    MediaTypeAnnounce = 9, //公告
};

typedef NS_ENUM(NSUInteger, MediaTagType)
{
    TagTypeNone = 0,
    TagTypeSole = 21,   //独家
    TagTypeVideo = 22,  //视频
    TagTypeAd = 23,  //推广
    TagTypeTopic = 24, //专题
    TagTypeAnalysis = 25,   //分析
    TagTypeHot = 26,        //热门
    TagTypeVote = 27,       //投票
    TagTypeLive = 28,       //直播
    TagTypeBoradCast = 29,  //广播
    TagTypeMusic = 30,      //音乐
};

@interface Image : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *imgurl;

@end

@interface Thumb : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *src;

@end

@interface EZMediaItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *fid;
@property (nonatomic, copy) NSString *mid;
@property (nonatomic, copy) NSString *mpno;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *video;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *members;
@property (nonatomic, copy) NSString *activityaddress;
@property (nonatomic, copy) NSString *shareurl;
@property (nonatomic, copy) NSString *pics;
@property (nonatomic, assign) MediaType type;
@property (nonatomic, assign) NSInteger pheight;
@property (nonatomic, assign) NSInteger pwidth;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, assign) NSInteger commentcount;
@property (nonatomic, assign) NSInteger assistcount;
@property (nonatomic, assign) NSInteger assisted;
@property (nonatomic, assign) NSInteger clickcount;
@property (nonatomic, assign) NSInteger commentstatus;
@property (nonatomic, assign) NSTimeInterval createtime;
@property (nonatomic, assign) NSTimeInterval activitystime;
@property (nonatomic, assign) NSTimeInterval activityetime;
@property (nonatomic ,copy) NSString *activityduration;
@property (nonatomic, copy) NSArray *images;//图片集
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, assign) MediaTagType tagType;
@property (nonatomic, copy) NSArray *thumbs;

@end

