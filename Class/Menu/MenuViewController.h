//
//  MenuViewController.h
//  Master
//
//  Created by Phil Xhc on 3/22/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICSDrawerController.h"
#import "MenuItem.h"

@interface MenuViewController : UIViewController<ICSDrawerControllerChild, ICSDrawerControllerPresenting>

+ (UIViewController *)paneViewControllerForMenuItem:(MenuItem *)menuItem;

@end
