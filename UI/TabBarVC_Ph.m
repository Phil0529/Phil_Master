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
#import "UITabBar+CenterBtnExtension.h"
#import "LaunchLiveVC.h"
#import <MMDrawerController/MMDrawerController.h>
#import "LeftDrawerVC_Ph.h"
#import "RightDrawerVC_Ph.h"

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
        UIViewController* paneController = [MenuVC_Ph paneViewController:item];
        NavigationVC_Ph *navController = [[NavigationVC_Ph alloc] initWithRootViewController:paneController];
        [navController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:titleFont} forState:UIControlStateNormal];
        [navController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:FOREGROUND_COLOR} forState:UIControlStateSelected];
        [navController.tabBarItem setTitle:item.title];
        [navController.tabBarItem setImage:[[UIImage imageNamed:item.normalImage]
                                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [navController.tabBarItem setSelectedImage:[[UIImage imageNamed:item.selectedImage]
                                                    imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        
        if(i == 0){
            LeftDrawerVC_Ph *leftDrawerVC = [[LeftDrawerVC_Ph alloc] init];
            RightDrawerVC_Ph *rightDrawer = [[RightDrawerVC_Ph alloc] init];
            MMDrawerController *drawerController = [[MMDrawerController alloc] initWithCenterViewController:navController
                                                                    leftDrawerViewController:leftDrawerVC
                                                                   rightDrawerViewController:rightDrawer];
            [drawerController setShowsShadow:YES];
            [drawerController setRestorationIdentifier:@"MMDrawer"];
            [drawerController setMaximumRightDrawerWidth:200.0];
            [drawerController setOpenDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
            
            [self addChildViewController:drawerController];

        }else{
            [self addChildViewController:navController];
        }
    }
    //    * 配置中间按钮
//    [self addCenterButton];
    [self.tabBar reloadTabbarWithShowCenterButton:NO];
    
}

- (void)addCenterButton{
    [self.tabBar setTabBarCenterButton:^(UIButton *centerButton) {
        [centerButton setBackgroundImage:[UIImage imageNamed:@"ic_tab_live"] forState:UIControlStateNormal];
        
        [centerButton setBackgroundImage:[UIImage imageNamed:@"ic_tab_live"] forState:UIControlStateSelected];
        
        [centerButton addTarget:self action:@selector(clickCenterButton) forControlEvents:UIControlEventTouchUpInside];
    }];
    
}

- (void)clickCenterButton
{
    LaunchLiveVC *vc = [[LaunchLiveVC alloc] init];
    vc.modalTransitionStyle = UIModalPresentationPopover;
    
    [UIView animateWithDuration:0.5f animations:^{
        [self presentViewController:vc animated:YES completion:nil];
    }];
}


@end
