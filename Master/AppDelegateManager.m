//
//  AppDelegateManager.m
//  Master
//
//  Created by Phil Xhc on 3/22/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "AppDelegateManager.h"
#import <AMapLocationKit/AMapLocationServices.h>
#import <MMDrawerController/MMDrawerController.h>
#import "TabBarVC_Ph.h"
#import "LeftDrawerVC_Ph.h"
#import "RightDrawerVC_Ph.h"

@implementation AppDelegateManager

- (instancetype)init{
    if (self = [super init]) {
        [AMapLocationServices sharedServices].apiKey = @"79b84bca56a4f499b6a20a31c9469c16";
    }
    return self;
}

- (void)openSystemLocationService:(NSNotification *)obj{
    if ([[obj object] isEqualToString:@"YES"]) {
        self.openLocation = YES;
    }
}

//Handle Exception
+ (void)handleException{
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
}

void uncaughtExceptionHandler(NSException *exception)
{
    // Internal error reporting
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
}

+ (void)initCache{
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
}

- (void)initWindow{
    TabBarVC_Ph *tabBarController = [[TabBarVC_Ph alloc] init];
    LeftDrawerVC_Ph *leftDrawerVC = [[LeftDrawerVC_Ph alloc] init];
    RightDrawerVC_Ph *rightDrawer = [[RightDrawerVC_Ph alloc] init];
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:tabBarController
                                                            leftDrawerViewController:leftDrawerVC
                                                           rightDrawerViewController:rightDrawer];
    [self.drawerController setShowsShadow:YES];
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setMaximumRightDrawerWidth:200.0];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningCenterView];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [self.window setRootViewController:self.drawerController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
}

- (UIWindow *)window{
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _window;
}

- (void)resetRootViewController{
    
}

+ (void)setNavigationBarDefaults
{
    NSDictionary* textAttributes =
    @{NSFontAttributeName:[UIFont boldSystemFontOfSize:19.5f],
      NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    [[UINavigationBar appearance] setBarTintColor:[UIColor grayColor]];
    if (IS_OS_8_OR_LATER) {
        [[UINavigationBar appearance] setTranslucent:NO];
    }
}


@end
