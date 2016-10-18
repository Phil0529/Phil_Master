//
//  UCAlbumVC_Ph.m
//  Master
//
//  Created by Phil Xhc on 5/9/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "UCAlbumVC_Ph.h"
#import "TabBarVC_Ph.h"
#import <MMDrawerController/MMDrawerController.h>
#import "UITabBar+CenterBtnExtension.h"

@implementation UCAlbumVC_Ph

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor greenColor]];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"明星登陆" forState:0];
    
    [btn addTarget:self action:@selector(click) forControlEvents:1<<6];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setFrame:CGRectMake(200, 200, 100, 100)];
    [btn1 setTitle:@"普通用户" forState:0];
    
    [btn1 addTarget:self action:@selector(normalClick) forControlEvents:1<<6];
    [self.view addSubview:btn1];
}

- (void)click{
//    MMDrawerController *drawerController = (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    TabBarVC_Ph *tabBarController = (TabBarVC_Ph *)drawerController.centerViewController;
}

- (void)normalClick{
//    MMDrawerController *drawerController = (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    TabBarVC_Ph *tabBarController = (TabBarVC_Ph *)drawerController.centerViewController;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.navigationController && self.navigationController.navigationBarHidden)
    {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
    [super viewWillAppear:animated];
//    [self.tabBarController.tabBar setHidden:YES];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


@end
