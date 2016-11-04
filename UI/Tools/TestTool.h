//
//  TestTool.h
//  Master
//
//  Created by xhc on 11/1/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestTool : NSObject

- (void)testBlock:(void(^)(BOOL test))block;

@end
