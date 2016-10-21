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
#import "LeftDrawerVC_Ph.h"
#import "RightDrawerVC_Ph.h"
#import <UIViewController+MMDrawerController.h>

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
    for (NSInteger i = 0; i < tabMenu.count; i ++) {
        ConfigItem_Ph *item = tabMenu[i];
        UIViewController *paneVC = [MenuVC_Ph paneViewController:item];
        NavigationVC_Ph *navVC = [[NavigationVC_Ph alloc] initWithRootViewController:paneVC];
        if (i == 0) {
            LeftDrawerVC_Ph *leftVc = [[LeftDrawerVC_Ph alloc] init];
            MMDrawerController *drawController = [[MMDrawerController alloc] initWithCenterViewController:navVC leftDrawerViewController:leftVc];
            [drawController setShowsShadow:YES];
            [drawController setRestorationIdentifier:@"MMDrawer"];
            [drawController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
            [drawController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
            [drawController.tabBarItem setImage:[[UIImage imageNamed:item.normalImage]
                                        imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [drawController.tabBarItem setSelectedImage:[[UIImage imageNamed:item.selectedImage]
                                                imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [drawController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:titleFont} forState:UIControlStateNormal];
            [drawController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:FOREGROUND_COLOR} forState:UIControlStateSelected];
            [drawController.tabBarItem setTitle:item.title];
            [self addChildViewController:drawController];
            continue;
        }
        
        [navVC.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:titleFont} forState:UIControlStateNormal];
        [navVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:FOREGROUND_COLOR} forState:UIControlStateSelected];
        [navVC.tabBarItem setTitle:item.title];
        [navVC.tabBarItem setImage:[[UIImage imageNamed:item.normalImage]
                                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [navVC.tabBarItem setSelectedImage:[[UIImage imageNamed:item.selectedImage]
                                                    imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [self addChildViewController:navVC];
    }
}

- (void)addCenterButton{
//    [self.tabBar setTabBarCenterButton:^(UIButton *centerButton) {
//        [centerButton setBackgroundImage:[UIImage imageNamed:@"ic_tab_live"] forState:UIControlStateNormal];
//        
//        [centerButton setBackgroundImage:[UIImage imageNamed:@"ic_tab_live"] forState:UIControlStateSelected];
//        
//        [centerButton addTarget:self action:@selector(clickCenterButton) forControlEvents:UIControlEventTouchUpInside];
//    }];
}

- (void)clickCenterButton
{
}


@end
