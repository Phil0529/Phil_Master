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
        Method originalMethodViewDidLoad = class_getInstanceMethod([self class], @selector(viewDidLoad));
        Method newMethodViewDidLoad = class_getInstanceMethod([self class], @selector(extension_viewDidLoad));
        method_exchangeImplementations(originalMethodViewDidLoad, newMethodViewDidLoad);
        
        Method originalMethodViewDidAppear = class_getInstanceMethod([self class], @selector(viewDidAppear:));
        Method newMethodViewDidAppear = class_getInstanceMethod([self class], @selector(extension_viewDidAppear:));
        method_exchangeImplementations(originalMethodViewDidAppear, newMethodViewDidAppear);
        
        
//        Method originalMethodDealloc= class_getInstanceMethod([self class], @selector(dealloc));
//        Method newMethodDealloc = class_getInstanceMethod([self class], @selector(extension_viewDidLoad));
//        method_exchangeImplementations(originalMethodDealloc, newMethodDealloc);
        
    });
}

- (void)extension_viewDidLoad{
    [self extension_viewDidLoad];
    if (![self isKindOfClass:NSClassFromString(@"UIInputWindowController")]) {
        [self.view setBackgroundColor:COLORFORRGBA(0xffffff,1.f)];
    }
}

- (void)extension_viewDidAppear:(BOOL)animated {
    [self extension_viewDidAppear:animated];
    NSLog(@"enter controller：%@", [[self class] description]);
}



@end
