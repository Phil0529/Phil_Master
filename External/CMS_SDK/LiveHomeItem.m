//
//  LiveHomeItem.m
//  EZTV
//
//  Created by Lee, Bo on 15/8/11.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "LiveHomeItem.h"

@implementation ConditionItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"tagtype": @"columntype",
             @"tagname": @"columnname",
             @"livetype": @"livetype"};
}

@end

@implementation LiveHomeItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"title": @"title",
             @"icon": @"icon",
             @"type": @"hometype",
             @"rowcount": @"rowcount",
             @"columncount": @"columncount",
             @"condition": @"condition",
             @"list": @"list"};
}

+ (NSValueTransformer *)conditionJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:ConditionItem.class];
}

+ (NSValueTransformer *)listJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[LiveItem class]];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self) {
        while (([_list count] < _columncount * _rowcount) && _rowcount > 1) {
            _rowcount --;
        }
        if (_columncount <= 0) {
            _columncount = 2;
        }
        if (_rowcount <= 0) {
            _rowcount = 1;
        }
    }
    return self;
}

@end
