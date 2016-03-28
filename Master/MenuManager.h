//
//  MenuManager.h
//  Master
//
//  Created by Phil Xhc on 3/24/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuItem.h"

@interface MenuManager : NSObject

+ (UIImage *)normalImage:(MenuItem *)item;
+ (UIImage *)selectedImage:(MenuItem *)item;

@end
