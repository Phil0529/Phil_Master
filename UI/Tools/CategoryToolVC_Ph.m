//
//  CategoryToolVC_Ph.m
//  Master
//
//  Created by xhc on 10/24/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "CategoryToolVC_Ph.h"
#import "CategoryToolView_ph.h"

@interface CategoryToolVC_Ph ()

@property (nonatomic,strong) CategoryToolView_ph *mainView;

@end

@implementation CategoryToolVC_Ph

- (void)viewDidLoad {
    [super viewDidLoad];
    [self mainView];
}

- (CategoryToolView_ph *)mainView{
    if (!_mainView) {
        _mainView = [[CategoryToolView_ph alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, SCREEN_HEIGHT-64.f)];
        [self.view addSubview:_mainView];
    }
    return _mainView;
}

@end
