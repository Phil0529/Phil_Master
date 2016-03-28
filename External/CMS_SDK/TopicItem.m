//
//  TopicItem.m
//  EZTV
//
//  Created by Lee, Bo on 15/11/4.
//  Copyright © 2015年 Joygo. All rights reserved.
//

#import "TopicItem.h"

@implementation TopicItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"tagName": @"name",
             @"itemList": @"item"};
}

+ (NSValueTransformer *)itemListJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[EZMediaItem class]];
}

@end
