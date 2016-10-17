//
//  MenuVC_Ph.m
//  Master
//
//  Created by Phil Xhc on 4/21/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "MenuVC_Ph.h"
#import "HomeVC_Ph.h"
#import "UserCenterVC_Ph.h"
#import "MasterVC_Ph.h"
#import "CardPageVC.h"
#import <UIViewController+MMDrawerController.h>

@interface MenuVC_Ph ()

@end

@implementation MenuVC_Ph

- (void)viewDidLoad {
    [super viewDidLoad];
}

+ (UIViewController *)paneViewController:(ConfigItem_Ph *)item{
    UIViewController *vc;
    switch (item.type) {
        case ConfigType_Home:{
            vc = [[HomeVC_Ph alloc] init];
        }
            break;
        case ConfigType_UserCenter:{
            
            vc = [[UserCenterVC_Ph alloc] init];
        }
            break;
        case ConfigType_Master:{
            vc = [MasterVC_Ph new];
        }
            break;
        case ConfigType_CardPage:{
            vc = [CardPageVC new];
        }
            break;
        default:{
            UserCenterVC_Ph *vc = [[UserCenterVC_Ph alloc] init];
            vc.navigationItem.title = item.title;
            return vc;
        }
            break;
    }
    [vc.navigationItem setTitle:item.title];
    return vc;
}

@end
