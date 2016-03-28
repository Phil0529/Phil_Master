//
//  LiveItem.m
//  EZTV
//
//  Created by Lee, Bo on 15/8/11.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "LiveItem.h"
#import "EZUtils.h"

@implementation AdsItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"envelope": @"envelope",
             @"commodity": @"commodity",
             @"url": @"url"};
}

@end

@implementation AuthorItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"mpno": @"mpno",
             @"nickname": @"nickname",
             @"headimg": @"face",
             @"roles": @"roles"};
}

@end

@implementation StreamItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"cid": @"cid",
             @"uid": @"uid",
             @"tid": @"tid",
             @"url": @"url",
             @"delayTime": @"delaytime"};
}

@end

@implementation LiveItem

- (instancetype)init
{
    if (self = [super init]) {
        _desc = @"";
        _address = @"";
        _lat = @"";
        _lon = @"";
        _city = @"";
        _show = @"0";
    }
    return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"lid": @"_id",
             @"title": @"title",
             @"desc": @"desc",
             @"pics": @"pics",
             @"tag": @"columns",
             @"ads": @"ads",
             @"isads": @"isads",
             @"author": @"user",
             @"stream": @"cds",
             @"chatroom": @"chatroom",
             @"guest": @"guest",
             @"type": @"type",
             @"assistcount": @"assistcount",
             @"createtime": @"createtime",
             @"starttime": @"starttime",
             @"show":@"show"};
}

+ (NSValueTransformer *)adsJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AdsItem class]];
}

+ (NSValueTransformer *)tagJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[TagItem class]];
}

+ (NSValueTransformer *)streamJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:StreamItem.class];
}

+ (NSValueTransformer *)authorJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:AuthorItem.class];
}

+ (NSValueTransformer *)chatroomJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ChatRoomModel class]];
}

+ (NSValueTransformer *)guestJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[GuestModel class]];
}

- (NSString *)getPlayUrl
{
    NSString *playUrl;
//    if (_type == LiveType_UpVideo) {
//        playUrl = _stream.url;
//    } else{
//        playUrl = [NSString stringWithFormat:OIS_PLAYFORMAT, _stream.cid, _stream.uid, _stream.tid, _stream.cid,OIS_TOKEN];
//    }
//    if (_stream.delayTime > 0) {
//        playUrl = [playUrl stringByAppendingFormat:@"&playseek=%ld", (long)_stream.delayTime];
//    }
    playUrl = _stream.url;
    if (_stream.delayTime > 0) {
        playUrl = [EZUtils combineUrl:_stream.url params:@{@"playseek":[NSString stringWithFormat:@"%ld", (long)_stream.delayTime]}];
    }
    return playUrl;
}

@end
