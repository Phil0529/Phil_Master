//
//  UINavigationController+Rotation_IOS6.m
//  EZTV
//
//  Created by Lee, Bo on 15/4/16.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "UINavigationController+Rotation_IOS6.h"

@implementation UINavigationController (Rotation_IOS6)
-(BOOL)shouldAutorotate {
    return [[self.viewControllers lastObject] shouldAutorotate];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

@end
