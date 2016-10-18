//
//  UIViewController+BaseViewController_Ph.m
//  Master
//
//  Created by xhc on 10/17/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "UIViewController+BaseViewController_Ph.h"
#import <objc/runtime.h>

@implementation UIViewController (BaseViewController_Ph)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod([self class], @selector(viewDidLoad));
        Method newMethod = class_getInstanceMethod([self class], @selector(extension_viewDidLoad));
        method_exchangeImplementations(originalMethod, newMethod);
    });
}

- (void)extension_viewDidLoad{
    [self extension_viewDidLoad];
    if (![self isKindOfClass:NSClassFromString(@"UIInputWindowController")]) {
        [self.view setBackgroundColor:COLORFORRGBA(0xffffff,1.f)];
    }
}

@end
