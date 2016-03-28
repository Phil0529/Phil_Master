//
//  EZMediaItem.m
//  HuaXia
//
//  Created by Lee, Bo on 15/3/26.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "EZMediaItem.h"
#import "NSDate+Helper.h"

@implementation Image

@synthesize title = _title;
@synthesize desc = _desc;
@synthesize imgurl = _imgurl;

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"title": @"title",
             @"desc": @"desc",
             @"imgurl": @"imgurl"};
}

@end

@implementation Thumb

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"src": @"src"};
}

@end

@implementation EZMediaItem

@synthesize cid = _cid;
@synthesize mid = _mid;
@synthesize mpno = _mpno;
@synthesize title = _title;
@synthesize author = _author;
@synthesize desc = _desc;
@synthesize content = _content;
@synthesize source = _source;
@synthesize video = _video;
@synthesize url = _url;
@synthesize shareurl = _shareurl;
@synthesize type = _type;
@synthesize commentcount = _commentcount;
@synthesize assistcount = _assistcount;
@synthesize assisted = _assisted;
@synthesize clickcount = _clickcount;
@synthesize commentstatus = _commentstatus;
@synthesize createtime = _createtime;
@synthesize pics = _pics;
@synthesize images =_images;
@synthesize activityduration = _activityduration;

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"fid": @"_id",
             @"cid": @"cid",
             @"mid": @"mid",
             @"mpno": @"mpno",
             @"title": @"title",
             @"author": @"author",
             @"desc": @"desc",
             @"content": @"content",
             @"source": @"source",
             @"video": @"video",
             @"url": @"url",
             @"shareurl": @"shareurl",
             @"type": @"type",
             @"pheight": @"pheight",
             @"pwidth": @"pwidth",
             @"commentcount": @"commentcount",
             @"assistcount": @"assistcount",
             @"assisted": @"assisted",
             @"clickcount": @"clickcount",
             @"commentstatus": @"commentstatus",
             @"pics": @"pics",
             @"createtime": @"createtime",
             @"activitystime": @"activitystime",
             @"activityetime": @"activityetime",
             @"images": @"images",
             @"score": @"score",
             @"tel": @"tel",
             @"address": @"address",
             @"activityaddress": @"activityaddress",
             @"price": @"price",
             @"members": @"members",
             @"tag": @"tag",
             @"tagType": @"tagtype",
             @"thumbs": @"imgextra"};
}

+ (NSValueTransformer *)imagesJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[Image class]];
}

+ (NSValueTransformer *)thumbsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[Thumb class]];
}

- (NSString *)activityduration
{
    if (ISEMPTYSTR(_activityduration)) {
        NSString *start = [[NSDate dateWithTimeIntervalSince1970:_activitystime] stringWithFormat:@"MM/dd HH:mm - "];
        NSString *end = [[NSDate dateWithTimeIntervalSince1970:_activityetime] stringWithFormat:@"MM/dd HH:mm"];
        _activityduration = [start stringByAppendingString:end];
    }
    return _activityduration;
}

@end


