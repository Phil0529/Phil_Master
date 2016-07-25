//
//  MasterView.m
//  Master
//
//  Created by Phil Xhc on 7/18/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "MasterView.h"

@implementation MasterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0.f, 10.f, 50.f, 20.f)];
        [btn setBackgroundColor:[UIColor greenColor]];
        [self addSubview:btn];
        
        [btn addTarget:self action:@selector(click) forControlEvents:1<<6];
    }
    return self;
}

- (void)click{
    
}

- (void)viewWillPop{
    NSLog(@"将要显示>>>>>>>>>");
}

- (void)viewWillDismiss{
    NSLog(@"将要消失<<<<<<<<<");
}

@end
