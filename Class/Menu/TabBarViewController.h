//
//  TabBarViewController.h
//  Master
//
//  Created by Phil Xhc on 3/22/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationViewController.h"
#import "ICSDrawerController.h"

@interface TabBarViewController : UITabBarController<ICSDrawerControllerChild, ICSDrawerControllerPresenting>

@property(nonatomic, weak) ICSDrawerController *drawer;


@end
