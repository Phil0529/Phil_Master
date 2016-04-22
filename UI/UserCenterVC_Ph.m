//
//  UserCenterVC_Ph.m
//  Master
//
//  Created by Phil Xhc on 4/21/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "UserCenterVC_Ph.h"
#import "UCHeadView_Ph.h"

@interface UserCenterVC_Ph ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, strong) UCHeadView_Ph *headView;

@end

@implementation UserCenterVC_Ph

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@"",@""];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.navigationController && !self.navigationController.navigationBarHidden)
    {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView setShowsVerticalScrollIndicator:NO];
        [_tableView setBackgroundColor:BACKGROUND_COLOR];
        [_tableView setTableHeaderView:self.headView];
    }
    return _tableView;
}


@end
