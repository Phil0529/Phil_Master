//
//  UIImageView+Extension_Ph.m
//  Master
//
//  Created by xhc on 10/24/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "UIImageView+Extension_Ph.h"

@implementation UIImageView (Extension_Ph)

- (void)addTapGestureBlock:(void(^)())block{
    SEL selector = NSSelectorFromString(@"tapClick");
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:tap];
    RACSignal* tapSignal = [self rac_signalForSelector:selector];
    [tapSignal subscribeNext:^(id x) {
        block();
    }];
}

@end
