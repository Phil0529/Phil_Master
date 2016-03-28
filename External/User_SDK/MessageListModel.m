//
//  MessageListModel.m
//  EZTV
//
//  Created by Sunni on 15/7/12.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "MessageListModel.h"

@implementation MessageModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"userId": @"userid",
             @"nickName": @"nickname",
             @"headUrl": @"headurl",
             @"content": @"content",
             @"sendTime": @"sendtime"};
}

@end

@implementation MessageListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"success": @"result",
             @"message": @"message",
             @"list": @"list"};
}

+ (NSValueTransformer *)listJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:MessageModel.class];
}

@end
