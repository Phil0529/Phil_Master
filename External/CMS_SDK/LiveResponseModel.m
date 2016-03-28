//
//  LiveResponseModel.m
//  EZTV
//
//  Created by Lee, Bo on 15/8/13.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "LiveResponseModel.h"

@implementation ChatRoomModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"lId": @"_id",
             @"mId": @"chatroomid",
             @"name": @"chatroomname",
             @"chatEnable": @"isjoin"};
}

@end

@implementation LiveResponseModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"code": @"code",
             @"message": @"message",
             @"chatRoom": @"data"};
}

+ (NSValueTransformer *)chatRoomJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ChatRoomModel class]];
}

@end
