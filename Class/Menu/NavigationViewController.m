//
//  NavigationViewController.m
//  Master
//
//  Created by Phil Xhc on 3/22/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (instancetype)initWithRootViewController:(UIViewController*)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]) {
        [self resetRootViewButton];
        [self.interactivePopGestureRecognizer setEnabled:NO];
    }
    return self;
}

- (void)resetRootViewButton{
    
    UIViewController *rootViewController = [self.viewControllers firstObject];
    
    UIBarButtonItem* navLogo =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_logo"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(clickOnLogo:)];
    [navLogo setTintColor:[UIColor whiteColor]];
    
    [rootViewController.navigationItem setLeftBarButtonItem:navLogo];
    UIBarButtonItem* navMy =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_my"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(clickOnMy:)];
    [navMy setTintColor:[UIColor whiteColor]];
    [rootViewController.navigationItem setRightBarButtonItem:navMy];
}

- (void)clickOnLogo:(id)sender
{
    if (_drawerDelegate &&
        [_drawerDelegate respondsToSelector:@selector(didClickOnDrawerButton)]) {
        [_drawerDelegate didClickOnDrawerButton];
    }
}

- (void)clickOnMy:(id)sender
{
//    EZUCViewController* ucView = [[EZUCViewController alloc] init];
//    [ucView setHidesBottomBarWhenPushed:YES];
//    [self pushViewController:ucView animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BACKGROUND_COLOR];
    // Do any additional setup after loading the view.
}

- (void)clickOnBack:(id)sender
{
    [self popViewControllerAnimated:YES];
}

- (void)pushViewController:(UIViewController*)viewController
                  animated:(BOOL)animated
{
    if ([self.viewControllers count] > 0) {
        [viewController setHidesBottomBarWhenPushed:YES];
        UIBarButtonItem* navBack =
        [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"]
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(clickOnBack:)];
        [navBack setTintColor:[UIColor whiteColor]];
        [viewController.navigationItem setLeftBarButtonItem:navBack];
    }
    [super pushViewController:viewController animated:animated];
}



- (BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //    return UIInterfaceOrientationMaskPortrait;
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    //    return UIInterfaceOrientationPortrait;
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}



@end
