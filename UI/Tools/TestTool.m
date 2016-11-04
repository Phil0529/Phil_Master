//
//  TestTool.m
//  Master
//
//  Created by xhc on 11/1/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "TestTool.h"

@implementation TestTool

- (void)testBlock:(void(^)(BOOL test))block{
    if (block) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            block(YES);
        });
    }
}

@end
