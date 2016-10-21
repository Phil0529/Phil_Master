//
//  NSString+Develop.m
//  Master
//
//  Created by xhc on 10/21/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "NSString+Develop.h"
#import <objc/runtime.h>

@implementation NSString (Develop)

+ (void)load{
    [super load];
    Method originalMethod = class_getInstanceMethod([NSString class], @selector(lowercaseString));
    Method swappedMethod = class_getInstanceMethod([NSString class], @selector(dov_myLowerCaseString));
    method_exchangeImplementations(originalMethod, swappedMethod);
}

- (NSString *)dov_myLowerCaseString{
    NSString *lowercase = [self dov_myLowerCaseString];
    NSLog(@"∆∆%@∆∆",lowercase);
    return lowercase;
}

@end
