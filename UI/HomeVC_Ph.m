//
//  HomeVC_Ph.m
//  Master
//
//  Created by Phil Xhc on 4/21/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "HomeVC_Ph.h"
#import <MMDrawerController/MMDrawerBarButtonItem.h>
#import "UIViewController+MMDrawerController.h"

@interface HomeVC_Ph ()

@end

@implementation HomeVC_Ph

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLeftMenuButton];
//    [self setupRightMenuButton];
}


-(void)setupLeftMenuButton{
    UIBarButtonItem* leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_logo"]
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(leftDrawerButtonPress:)];
    [leftBtn setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:leftBtn animated:YES];
}

-(void)setupRightMenuButton{
    UIBarButtonItem* rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_logo"]
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(rightDrawerButtonPress:)];
    [rightBtn setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightBtn animated:YES];
}

#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)rightDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

@end
