//
//  UIView+Extent.m
//  StarFactory
//
//  Created by Phil Xhc on 5/28/16.
//  Copyright © 2016 Joygo. All rights reserved.
//

#import "UIView+Extent.h"

@implementation UIView (Extent)

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


@end
