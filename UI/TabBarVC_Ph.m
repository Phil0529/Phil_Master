//
//  TabBarVC_Ph.m
//  Master
//
//  Created by Phil Xhc on 4/20/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "TabBarVC_Ph.h"
#import "ConfigManager_Ph.h"
#import "MenuVC_Ph.h"
#import "NavigationVC_Ph.h"

@interface TabBarVC_Ph ()

@end

@implementation TabBarVC_Ph

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self resetTabArray];
}

- (void)resetTabArray{
    NSArray* tabMenu = [ConfigManager_Ph sharedManager].tabMenuArray;
    if (tabMenu.count > 5) {
        
    }
    UIFont* titleFont = [UIFont systemFontOfSize:12.f];
    for (ConfigItem_Ph *item in tabMenu) {
        UIViewController* paneController = [MenuVC_Ph paneViewController:item];
        NavigationVC_Ph *navController = [[NavigationVC_Ph alloc] initWithRootViewController:paneController];
        [navController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:titleFont} forState:UIControlStateNormal];
        [navController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:FOREGROUND_COLOR} forState:UIControlStateSelected];
        [navController.tabBarItem setTitle:item.title];
        [navController.tabBarItem setImage:[[UIImage imageNamed:item.normalImage]
                    imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [navController.tabBarItem setSelectedImage:[[UIImage imageNamed:item.selectedImage]
                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [self addChildViewController:navController];
    }
}

@end
