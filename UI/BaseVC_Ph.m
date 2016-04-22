//
//  BaseVC_Ph.m
//  Master
//
//  Created by Phil Xhc on 4/20/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "BaseVC_Ph.h"

@interface BaseVC_Ph ()

@end

@implementation BaseVC_Ph

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

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
