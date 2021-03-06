//
//  ConfigManager_Ph.m
//  Master
//
//  Created by Phil Xhc on 4/21/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "ConfigManager_Ph.h"

@implementation ConfigManager_Ph

+ (ConfigManager_Ph *)sharedManager
{
    static ConfigManager_Ph *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ConfigManager_Ph alloc] init];
    });
    return instance;
}

- (NSArray *)tabMenuArray{
    return @[[ConfigItem_Ph newItem:@"First"
                        normalImage:@"tab_activity"
                      selectedImage:@"tab_activity_pressed"
                               type:ConfigType_Home],
             [ConfigItem_Ph newItem:@"Master"
                        normalImage:@"tab_activity"
                      selectedImage:@"tab_activity_pressed"
                               type:ConfigType_Master],
             [ConfigItem_Ph newItem:@"My"
                        normalImage:@"tab_activity"
                      selectedImage:@"tab_activity_pressed"
                               type:ConfigType_UserCenter],
             [ConfigItem_Ph newItem:@"UI"
                        normalImage:@"tab_activity"
                      selectedImage:@"tab_activity_pressed"
                               type:ConfigType_UI],
             [ConfigItem_Ph newItem:@"Animation"
                        normalImage:@"tab_activity"
                      selectedImage:@"tab_activity_pressed"
                               type:ConfigType_Tools]
             ];
}

@end
