//
//  SponsorsItem.m
//  EZTV
//
//  Created by Phil Xhc on 16/1/21.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import "SponsorsItem.h"

@implementation SponsorsItem

+ (instancetype)initWithTitle:(NSString *)title space:(CGFloat)space height:(CGFloat)height type:(SponsorsType)type{
    SponsorsItem *item = [[SponsorsItem alloc] init];
    item.title  = title;
    item.space  = space;
    item.height = height;
    item.type   = type;
    return item;
}

@end
