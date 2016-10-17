//
//  MasterVC_ph.m
//  Master
//
//  Created by Phil Xhc on 7/18/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "MasterVC_Ph.h"
#import "MasterView.h"
#import "AnimationTool.h"
#import <ReactiveCocoa.h>

@interface MasterVC_Ph ()

@property (nonatomic,strong)      MasterView *testView;                  //

@end

@implementation MasterVC_Ph

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.userInteractionEnabled = YES;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0.f, 100.f,SCREEN_WIDTH, 50.f)];
    [btn setBackgroundColor:[UIColor redColor]];
    
    
    
    [[btn rac_signalForControlEvents:1<<6] subscribeNext:^(UIButton *btn) {
        AnimationTool *animationTool = [[AnimationTool alloc] init];
        [animationTool addAnimationPopView:self.testView duration:.5f orientation:AnimationOrientation_Bottom];
    }];

    [self.view addSubview:btn];
}

- (MasterView *)testView{
    if (!_testView) {
        _testView = [[MasterView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH,100.f)];
    }
    return _testView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
