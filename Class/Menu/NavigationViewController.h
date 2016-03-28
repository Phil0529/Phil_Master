//
//  NavigationViewController.h
//  Master
//
//  Created by Phil Xhc on 3/22/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavigationControllerDelegate <NSObject>

- (void)didClickOnDrawerButton;

@end

@interface NavigationViewController : UINavigationController

@property (nonatomic, assign) id<NavigationControllerDelegate> drawerDelegate;

@end
