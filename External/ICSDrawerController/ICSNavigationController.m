//
//  ICSNavigationController.m
//  ICSCustomize
//
//  Created by Lee, Bo on 15/3/18.
//  Copyright (c) 2015年 Sunniwell. All rights reserved.
//

#import "ICSNavigationController.h"

@interface ICSNavigationController ()
{
    CGPoint startLocation;
}
@end

@implementation ICSNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
//    pan.delegate = self;
//    [self.view addGestureRecognizer:pan];
    [self.interactivePopGestureRecognizer setEnabled:NO];
}

//- (void)handlePanGesture:(UIPanGestureRecognizer *)panGestureRecognizer
//{
//    CGPoint location = [panGestureRecognizer locationInView:self.view];
//    CGPoint velocity = [panGestureRecognizer velocityInView:self.view];
//
//    switch (panGestureRecognizer.state) {
//        case UIGestureRecognizerStateBegan:
//        {
//            startLocation = location;
//        }
//            break;
//        case UIGestureRecognizerStateRecognized:
//        {
//            if (velocity.x > 20.f) {
//                [self popViewControllerAnimated:YES];
//            }
//        }
//            break;
//        default:
//            break;
//    }
//}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([self.viewControllers count] > 1) {
        return YES;
    }
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - delegate ICSDrawerControllerPresenting

/**
 Tells the child controller that the drawer controller is about to open.
 
 @param drawerController The drawer object that is about to open.
 */
- (void)drawerControllerWillOpen:(ICSDrawerController *)drawerController
{
    if (self.topViewController) {
        [self.topViewController.view setUserInteractionEnabled:NO];
    }
}
/**
 Tells the child controller that the drawer controller has completed the opening phase and is now open.
 
 @param drawerController The drawer object that is now open.
 */
- (void)drawerControllerDidOpen:(ICSDrawerController *)drawerController
{
    if (self.topViewController) {
        [self.topViewController.view setUserInteractionEnabled:YES];
    }
}
/**
 Tells the child controller that the drawer controller is about to close.
 
 @param drawerController The drawer object that is about to close.
 */
- (void)drawerControllerWillClose:(ICSDrawerController *)drawerController
{
    if (self.topViewController) {
        [self.topViewController.view setUserInteractionEnabled:NO];
    }
}
/**
 Tells the child controller that the drawer controller has completed the closing phase and is now closed.
 
 @param drawerController The drawer object that is now closed.
 */
- (void)drawerControllerDidClose:(ICSDrawerController *)drawerController
{
    if (self.topViewController) {
        [self.topViewController.view setUserInteractionEnabled:YES];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
