//
//  SFViewController.m
//  EZTV
//
//  Created by Lee, Bo on 16/3/9.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import "SFViewController.h"

@implementation SFViewController

- (void)viewWillAppear:(BOOL)animated
{
    if (self.navigationController && self.navigationController.navigationBarHidden)
    {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
    [super viewWillAppear:animated];
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
