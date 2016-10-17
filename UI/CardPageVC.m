//
//  CardPageVC.m
//  Master
//
//  Created by xhc on 10/17/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "CardPageVC.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>

@interface CardPageVC ()

@end

@implementation CardPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModePanningCenterView];
}

@end
