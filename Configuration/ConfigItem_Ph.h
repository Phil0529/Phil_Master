//
//  ConfigItem.Ph.h
//  Master
//
//  Created by Phil Xhc on 4/21/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,ConfigType){
    ConfigType_Home             = 1,
    ConfigType_UserCenter       = 2,
    ConfigType_Master           = 3,
    ConfigType_CardPage         = 4,
};


@interface ConfigItem_Ph : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *normalImage;
@property (nonatomic, copy) NSString *selectedImage;
@property (nonatomic, assign) ConfigType type;

+ (ConfigItem_Ph *)newItem:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage type:(ConfigType )type;

@end
