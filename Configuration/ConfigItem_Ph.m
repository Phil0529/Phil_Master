//
//  ConfigItem_Ph.m
//  Master
//
//  Created by Phil Xhc on 4/21/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "ConfigItem_Ph.h"

@implementation ConfigItem_Ph

+ (ConfigItem_Ph *)newItem:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage type:(ConfigType )type{
    ConfigItem_Ph *item = [[ConfigItem_Ph alloc] init];
    item.title = title;
    item.normalImage = normalImage;
    item.selectedImage = selectedImage;
    item.type = type;
    return item;
}

@end
