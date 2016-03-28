//
//  EZRadioItem.h
//  EZTV
//
//  Created by Phil Xhc on 15/9/29.
//  Copyright © 2015年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LiveResponseModel.h"
#import "ActivityDetailModel.h"

typedef NS_ENUM(NSUInteger, ProgramInfo){
    ProgramInfo_OnlyLive = 1,
    ProgramInfo_Live_List= 2,
    ProgramInfo_No       = 4,
};


@interface EZRadioItem : NSObject

@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *mpno;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, assign) NSTimeInterval createtime;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *pics;
@property (nonatomic, strong) NSString *video;
@property (nonatomic, strong) NSString *url;

//PhilChange
@property (nonatomic, strong) NSString *lon;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *broadcastName;
@property (nonatomic, strong) NSString *broadcastChannel;
@property (nonatomic, strong) NSString *broadcastStatus;
@property (nonatomic, strong) NSString *broadcastPics;
@property (nonatomic, strong) NSString *broadcastID;
@property (nonatomic, assign) NSTimeInterval broadcastStartTime;
@property (nonatomic, assign) NSTimeInterval showSTime;
@property (nonatomic, assign) NSTimeInterval showETime;
@property (nonatomic, strong) NSString *audioAnchor;
@property (nonatomic, assign) NSInteger praiseCount;

@property (nonatomic, assign) NSInteger playStatus;
@property (nonatomic, strong) NSArray *guestArray;
@property (nonatomic, strong) NSDictionary *chatRoomDict;



- (instancetype)initWithJsonData:(NSDictionary *)data;

@end


@interface EZChannelItem : NSObject

//@property (nonatomic, strong) ChatRoomModel *chatRoom;
@property (nonatomic, strong) NSArray *guestArray;
@property (nonatomic, strong) NSDictionary *chatRoomDict;

@property (nonatomic, assign) NSInteger praiseCount;
@property (nonatomic, strong) NSString *channelID;

@property (nonatomic, strong) NSString *picsURL;
@property (nonatomic, strong) NSString *liveURL;

@property (nonatomic, strong) NSString *mainTitle;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *subTitle;

- (instancetype)initWithJsonData:(NSDictionary *)data;

@end

@interface EZShowItem : NSObject

@property (nonatomic, assign) NSInteger playStatus;
@property (nonatomic, assign) NSTimeInterval startTime;
@property (nonatomic, assign) NSTimeInterval endTime;
@property (nonatomic, strong) NSString *audioAnchor;
@property (nonatomic, strong) NSString *showName;
@property (nonatomic, strong) NSString *adPicsURL;
@property (nonatomic, strong) NSString *showURL;
@property (nonatomic, assign) NSInteger isPlay;

- (instancetype)initWithJsonData:(NSDictionary *)data;

@end

