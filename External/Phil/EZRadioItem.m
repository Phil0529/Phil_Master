

//
//  EZRadioItem.m
//  EZTV
//
//  Created by Phil Xhc on 15/9/29.
//  Copyright © 2015年 Joygo. All rights reserved.
//

#import "EZRadioItem.h"

@implementation EZRadioItem

@synthesize _id = __id;
@synthesize title = _title;
@synthesize mpno = _mpno;
@synthesize path = _path;
@synthesize createtime = _createtime;
@synthesize content = _content;
@synthesize pics = _pics;
@synthesize video = _video;

// PhilChange
@synthesize lon = _lon;
@synthesize lat = _lat;
@synthesize address = _address;
@synthesize url = _url;

//broadcast
@synthesize broadcastName = _broadcastName;
@synthesize broadcastChannel = _broadcastChannel;
@synthesize broadcastStatus = _broadcastStatus;
@synthesize broadcastPics = _broadcastPics;
@synthesize broadcastID = _broadcastID;
@synthesize broadcastStartTime = _broadcastStartTime;
@synthesize guestArray = _guestArray;
@synthesize chatRoomDict = _chatRoomDict;

- (instancetype)initWithJsonData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        if (data && [data isKindOfClass:[NSDictionary class]])
        {
            OBJ2STR([data objectForKey:@"_id"], __id);
            OBJ2STR([data objectForKey:@"mpno"], _mpno);
            OBJ2STR([data objectForKey:@"title"], _title);
            OBJ2STR([data objectForKey:@"path"], _path);
            OBJ2STR([data objectForKey:@"pics"], _pics);
            OBJ2STR([data objectForKey:@"video"], _video);
            OBJ2FLOAT([data objectForKey:@"createtime"], _createtime);
            OBJ2STR([data objectForKey:@"content"], _content);
            // PhilChange
            OBJ2STR([data objectForKey:@"url"], _url);
            OBJ2STR([data objectForKey:@"lon"], _lon);
            OBJ2STR([data objectForKey:@"lat"], _lat);
            OBJ2STR([data objectForKey:@"address"], _address);
            OBJ2STR([data objectForKey:@"subtitle"], _broadcastChannel);
            OBJ2STR([data objectForKey:@"desc"], _broadcastStatus);
            OBJ2STR([data objectForKey:@"title"], _broadcastName);
            OBJ2STR([data objectForKey:@"pics"], _broadcastPics);
            OBJ2FLOAT([data objectForKey:@"createtime"], _broadcastStartTime);
            OBJ2FLOAT([data objectForKey:@"etime"], _showETime);
            OBJ2FLOAT([data objectForKey:@"stime"], _showSTime);
            OBJ2STR([data objectForKey:@"anchor"], _audioAnchor);
            OBJ2FLOAT([data objectForKey:@"isplay"], _playStatus);
            OBJ2INT([data objectForKey:@"assistcount"], _praiseCount);
            OBJArray([data objectForKey:@"guest"], _guestArray);
            OBJDictionary([data objectForKey:@"chatroom"], _chatRoomDict);

            _content = [_content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }
    }
    return self;
}

@end

@implementation EZChannelItem

@synthesize chatRoomDict = _chatRoomDict;
@synthesize guestArray = _guestArray;

@synthesize mainTitle = _mainTitle;
@synthesize subTitle = _subTitle;
@synthesize desc = _desc;

@synthesize picsURL = _picsURL;
@synthesize liveURL = _liveURL;

@synthesize praiseCount = _praiseCount;
@synthesize channelID = _channelID;
- (instancetype)initWithJsonData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        if (data && [data isKindOfClass:[NSDictionary class]])
        {
            OBJ2INT([data objectForKey:@"assistcount"], _praiseCount);
            OBJArray([data objectForKey:@"guest"], _guestArray);
            if (_guestArray) {
                _guestArray = [MTLJSONAdapter modelsOfClass:[GuestModel class] fromJSONArray:_guestArray error:NULL];
            }
            OBJDictionary([data objectForKey:@"chatroom"], _chatRoomDict);
            OBJ2STR([data objectForKey:@"title"], _mainTitle);
            OBJ2STR([data objectForKey:@"subtitle"], _subTitle);
            OBJ2STR([data objectForKey:@"desc"], _desc);
            OBJ2STR([data objectForKey:@"url"], _liveURL);
            OBJ2STR([data objectForKey:@"pics"], _picsURL);
            OBJ2STR([data objectForKey:@"_id"], _channelID);
        }
    }
    return self;
}
@end


@implementation EZShowItem

@synthesize showName = _showName;
@synthesize audioAnchor = _audioAnchor;
@synthesize startTime = _startTime;
@synthesize endTime = _endTime;
@synthesize playStatus = _playStatus;
@synthesize adPicsURL = _adPicsURL;
@synthesize showURL = _showURL;
@synthesize isPlay = _isPlay;

- (instancetype)initWithJsonData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        if (data && [data isKindOfClass:[NSDictionary class]])
        {
            OBJ2STR([data objectForKey:@"title"], _showName);
            OBJ2STR([data objectForKey:@"anchor"], _audioAnchor);
            OBJ2STR([data objectForKey:@"pics"], _adPicsURL);
            OBJ2FLOAT([data objectForKey:@"etime"], _endTime);
            OBJ2FLOAT([data objectForKey:@"stime"], _startTime);
            OBJ2STR([data objectForKey:@"url"], _showURL);
            OBJ2INT([data objectForKey:@"isplay"], _isPlay);
        }
    }
    return self;
}



@end
