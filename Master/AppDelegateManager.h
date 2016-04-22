//
//  AppDelegateManager.h
//  Master
//
//  Created by Phil Xhc on 3/22/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MMDrawerController/MMDrawerController.h>


@interface AppDelegateManager : NSObject

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, assign) BOOL openLocation;
@property (nonatomic, strong) MMDrawerController *drawerController;

+ (void)handleException;
+ (void)initCache;
- (void)initWindow;
+ (void)setNavigationBarDefaults;

@end
