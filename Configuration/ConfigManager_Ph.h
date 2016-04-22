//
//  ConfigManager_Ph.h
//  Master
//
//  Created by Phil Xhc on 4/21/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigItem_Ph.h"

@interface ConfigManager_Ph : NSObject

@property (nonatomic, strong) NSArray *tabMenuArray;

+ (ConfigManager_Ph *)sharedManager;

@end
