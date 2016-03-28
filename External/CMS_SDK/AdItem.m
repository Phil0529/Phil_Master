//
//  AdItem.m
//  EZTV
//
//  Created by Lee, Bo on 15/5/20.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "AdItem.h"

@implementation AdItem

@synthesize title = _title;
@synthesize adimg = _adimg;
@synthesize adtype = _adtype;
@synthesize adurl = _adurl;
@synthesize menuitem = _menuitem;
@synthesize mediaItem = _mediaItem;

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"title": @"title",
             @"adimg": @"adimg",
             @"adtype": @"adtype",
             @"adurl": @"adurl",
             @"menuitem": @"menuitem",
             @"mediaItem": @"mediaitem"};
}

+ (NSValueTransformer *)menuitemJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:MenuItem.class];
}

+ (NSValueTransformer *)mediaItemJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:EZMediaItem.class];
}

@end
