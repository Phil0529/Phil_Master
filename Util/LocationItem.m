//
//  LocationItem.m
//  EZTV
//
//  Created by Lee, Bo on 15/11/6.
//  Copyright © 2015年 Joygo. All rights reserved.
//

#import "LocationItem.h"

@implementation LocationItem

+ (LocationItem *)newLocation
{
    LocationItem *item = [[LocationItem alloc] init];
    item.city = @"";
    item.address = @"";
    item.latitude = @"";
    item.longitude = @"";
    return item;
}

@end
