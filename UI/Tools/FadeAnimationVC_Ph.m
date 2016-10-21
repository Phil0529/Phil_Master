//
//  FadeAnimationVC_Ph.m
//  Master
//
//  Created by xhc on 10/21/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "FadeAnimationVC_Ph.h"
#import "FadeAnimationView_Ph.h"

@interface FadeAnimationVC_Ph ()

@property (nonatomic,strong) FadeAnimationView_Ph *animationView;

@end

@implementation FadeAnimationVC_Ph

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (FadeAnimationView_Ph *)animationView{
    if (!_animationView) {
        _animationView = [[FadeAnimationView_Ph alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    }
    return _animationView;
}

@end
