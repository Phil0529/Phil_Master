//
//  AppDelegateManager.h
//  Master
//
//  Created by Phil Xhc on 3/22/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LaunchAdView.h"
#import "ViewController.h"
#import "ICSDrawerController.h"
#import "MenuViewController.h"


@interface AppDelegateManager : NSObject

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) ICSDrawerController *drawerController;
@property (nonatomic, assign) BOOL openLocation;

+ (void)handleException;
+ (void)initCache;
- (void)initWindow;
+ (void)setNavigationBarDefaults;

@end
