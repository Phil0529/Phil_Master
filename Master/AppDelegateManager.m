//
//  AppDelegateManager.m
//  Master
//
//  Created by Phil Xhc on 3/22/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "AppDelegateManager.h"
#import "TabBarViewController.h"
#import "NavigationViewController.h"
#import "MenuViewController.h"

@implementation AppDelegateManager

- (instancetype)init{
    if (self = [super init]) {
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
    TabBarViewController *tabBarController = [[TabBarViewController alloc] init];
    MenuViewController *menuViewController = [[MenuViewController alloc] init];
    
    _drawerController = [[ICSDrawerController alloc] initWithLeftViewController:menuViewController centerViewController:tabBarController];
    [self.window setRootViewController:_drawerController];
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
    
    [[UINavigationBar appearance] setBarTintColor:FOREGROUND_COLOR];
    if (IS_OS_8_OR_LATER) {
        [[UINavigationBar appearance] setTranslucent:NO];
    }
}


@end
