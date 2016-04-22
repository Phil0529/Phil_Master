//
//  UserCenterVC_Ph.m
//  Master
//
//  Created by Phil Xhc on 4/21/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "UserCenterVC_Ph.h"

@interface UserCenterVC_Ph ()

@end

@implementation UserCenterVC_Ph

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.navigationController && !self.navigationController.navigationBarHidden)
    {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}



@end
