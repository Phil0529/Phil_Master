//
//  BlockVC_Ph.m
//  Master
//
//  Created by xhc on 11/11/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "BlockVC_Ph.h"

@interface BlockVC_Ph ()

@end

@implementation BlockVC_Ph

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test1];
}

- (void)test1{
    int (^addBlock)(int a,int b) = ^(int a,int b){
        return a+b;
    };
    NSLog(@"%d",addBlock(3,4));
    
    NSArray *array = @[@0,@1,@2,@3,@4];
    __block NSInteger count = 0;
    [array enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([number compare:@2]) {
            count++;
        }
    }];
    
    /*
     如果块是对象类型,那么就会自动保留它,系统在释放这个块的时候,会将其释放.
     */
    
}

@end
