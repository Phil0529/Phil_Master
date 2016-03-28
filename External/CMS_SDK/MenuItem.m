//
//  MenuItem.m
//  EZTV
//
//  Created by Lee, Bo on 15/5/19.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

+ (MenuItem *)defaultItem
{
    MenuItem *item = [[MenuItem alloc] init];
    item.cid = 0;
    item.menutype = MenuTypeHome;
    return item;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"menutype": @"menutype",
             @"position": @"position",
             @"tabIcon": @"picstype"};
}

@end

@implementation MenuMap

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"code": @"code",
             @"list": @"list"};
}

@end
