//
//  BNTabBarController.m
//  EZTV
//
//  Created by Lee, Bo on 15/10/10.
//  Copyright © 2015年 Joygo. All rights reserved.
//

#import "TabBarViewController.h"
#import "ConfigManger.h"
#import "AppConfig.h"
#import "MenuViewController.h"
#import "UserCenter.h"
#import "MenuItem.h"
#import "MenuManager.h"
#import "NavTitleView.h"

@interface TabBarViewController () <NavigationControllerDelegate>

@end

@implementation TabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor redColor]];
    [self resetTabArray];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)resetTabArray
{
    [[UINavigationBar appearance] setBarTintColor:[AppConfig sharedConfig].appColor];
    NSArray* tabMenu = [ConfigManger sharedManager].tabMenuArray;
    tabMenu = tabMenu.count >5?[tabMenu subarrayWithRange:NSMakeRange(0, 5)]:tabMenu;
    UIFont* titleFont = [UIFont systemFontOfSize:12.f];
    
    NSMutableArray* tabViewControllers = [[NSMutableArray alloc] initWithCapacity:[tabMenu count]];
    
    for (MenuItem* item in tabMenu) {
        UIViewController* paneView = [MenuViewController paneViewControllerForMenuItem:item];
        NavigationViewController *navVC = [[NavigationViewController alloc] initWithRootViewController:paneView];
        [navVC setDrawerDelegate:self];
        [navVC.tabBarItem setImage: [MenuManager normalImage:item]];
        [navVC.tabBarItem setSelectedImage:[MenuManager selectedImage:item]];
        navVC.tabBarItem.title = item.name;
        [tabViewControllers addObject:navVC];
        
        NavTitleView *view = [[NavTitleView alloc] initWithFrame:CGRectMake(0.f, 0.f, 200.f, 20.f) title:item.name];
        [paneView.navigationItem setTitleView:(UIView *)view];
        
        [navVC.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:titleFont}
                                        forState:UIControlStateNormal];
        [navVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:FOREGROUND_COLOR}
                                        forState:UIControlStateSelected];

    }
    [self setViewControllers:tabViewControllers animated:NO];
}

#pragma mark - BNNavigationController delegate

- (void)didClickOnDrawerButton
{
    if (_drawer && _drawer.drawerState == ICSDrawerControllerStateClosed) {
        [_drawer open];
        if ([self.selectedViewController isKindOfClass:[UINavigationController class]]) {
            UIViewController* visableViewC =
            [(UINavigationController*)
             self.selectedViewController visibleViewController];
            if ([visableViewC respondsToSelector:@selector(viewWillDisappear:)]) {
                [visableViewC performSelector:@selector(viewWillDisappear:)];
            }
        }
    }
    else if (_drawer && _drawer.drawerState == ICSDrawerControllerStateOpen) {
        [_drawer close];
    }
}

- (void)pushMenuViewController:(UIViewController*)viewController
                      animated:(BOOL)animated
{
    if ([self.selectedViewController
         isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController*)self.selectedViewController
         pushViewController:viewController
         animated:animated];
    }
}

#pragma mark - ICSDrawerControllerPresenting

/**
 Tells the child controller that the drawer controller is about to open.
 
 @param drawerController The drawer object that is about to open.
 */
- (void)drawerControllerWillOpen:(ICSDrawerController*)drawerController
{
    [self.selectedViewController beginAppearanceTransition:NO animated:YES];
    self.view.userInteractionEnabled = NO;
}

/**
 Tells the child controller that the drawer controller has completed the opening
 phase and is now open.
 
 @param drawerController The drawer object that is now open.
 */
- (void)drawerControllerDidOpen:(ICSDrawerController*)drawerController
{
    [self.selectedViewController endAppearanceTransition];
}
/**
 Tells the child controller that the drawer controller is about to close.
 
 @param drawerController The drawer object that is about to close.
 */
- (void)drawerControllerWillClose:(ICSDrawerController*)drawerController
{
    [self.selectedViewController beginAppearanceTransition:YES animated:YES];
}
/**
 Tells the child controller that the drawer controller has completed the closing
 phase and is now closed.
 
 @param drawerController The drawer object that is now closed.
 */
- (void)drawerControllerDidClose:(ICSDrawerController*)drawerController
{
    [self.selectedViewController endAppearanceTransition];
    self.view.userInteractionEnabled = YES;
}

- (BOOL)shouldAutorotate
{
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return
    [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.selectedViewController beginAppearanceTransition:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.selectedViewController endAppearanceTransition];
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.selectedViewController beginAppearanceTransition:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.selectedViewController endAppearanceTransition];
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little
 preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
