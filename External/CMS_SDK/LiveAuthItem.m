//
//  LiveAuthItem.m
//  EZTV
//
//  Created by Lee, Bo on 15/9/18.
//  Copyright © 2015年 Joygo. All rights reserved.
//

#import "LiveAuthItem.h"

@implementation AuthData

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"status": @"status",
             @"message": @"message",};
}

@end

@implementation LiveAuthItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"code": @"code",
             @"data": @"data",};
}

+ (NSValueTransformer *)dataJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AuthData class]];
}

@end
