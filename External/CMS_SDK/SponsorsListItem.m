//
//  SponsorsListItem.m
//  EZTV
//
//  Created by Phil Xhc on 16/1/21.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import "SponsorsListItem.h"

@implementation SponsorsListItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"sId":@"id",
             @"name":@"name",
             @"imgURL":@"img"};
}


@end


@implementation SponsorsListItemResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"code": @"code",
             @"list": @"list"};
}


+ (NSValueTransformer *)listJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[SponsorsListItem class]];
}



@end
