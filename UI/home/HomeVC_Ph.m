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
#import "TabBarVC_Ph.h"
#import "UITabBar+CenterBtnExtension.h"

@interface HomeVC_Ph ()

@end

@implementation HomeVC_Ph

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLeftMenuButton];
//    MMDrawerController *drawerController = (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    TabBarVC_Ph *tabBarController = (TabBarVC_Ph *)drawerController.centerViewController;
//    [self setupRightMenuButton];
//    NSMutableArray *element = [@[@"1",@"2"] mutableCopy];
//    NSMutableArray *arr = [@[element] mutableCopy];
//    NSMutableArray *mArr = [arr mutableCopy];
//    [element replaceObjectAtIndex:0 withObject:@"a"];
//    NSArray *coArr = [arr copy];
//
//    NSMutableArray *element = [NSMutableArray arrayWithObject:@"1"];
//    NSMutableArray *array = [NSMutableArray arrayWithObject:element];
//    
//    id mutableCopyArray = [array mutableCopy];
//    [element replaceObjectAtIndex:0 withObject:@"a"];
    
}

/*
 1.无论是copy 还是 mutableCopy. 都是浅拷贝,都是容器拷贝.
 2.
 */

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
