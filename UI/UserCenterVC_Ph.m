//
//  UserCenterVC_Ph.m
//  Master
//
//  Created by Phil Xhc on 4/21/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "UserCenterVC_Ph.h"
#import "UCHeadView_Ph.h"
#import "UCTableCell_Ph.h"
#import "UCTopView_Ph.h"
#import "UCAlbumVC_Ph.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>

@interface UserCenterVC_Ph ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UCHeadView_Ph *headView;
@property (nonatomic, strong) UCTopView_Ph *topView;

@end

@implementation UserCenterVC_Ph

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
    [self showUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.navigationController && !self.navigationController.navigationBarHidden)
    {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
}

- (void)showUI{
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    [self.tableView setContentInset:UIEdgeInsetsMake(SCREEN_WIDTH*BeautifulScale, 0.f, 0.f, 0.f)];
    [self.tableView setContentOffset:CGPointMake(0.f,-SCREEN_WIDTH*BeautifulScale)];
    [self.tableView addSubview:self.topView];
    [self.tableView sendSubviewToBack:self.topView];
}

#pragma UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UCTableCell_Ph *cell = [tableView dequeueReusableCellWithIdentifier:UCTableCell_PhReuseIdentifier];
    [cell setIsFirstLine:indexPath.row == 0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UCAlbumVC_Ph *vc = [[UCAlbumVC_Ph alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, SCREEN_HEIGHT-49.f) style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setRowHeight:66.f];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView setShowsVerticalScrollIndicator:NO];
        [_tableView setBackgroundColor:BACKGROUND_COLOR];
        [_tableView setTableHeaderView:self.headView];
        [_tableView registerClass:[UCTableCell_Ph class] forCellReuseIdentifier:UCTableCell_PhReuseIdentifier];
    }
    return _tableView;
}

- (UCTopView_Ph *)topView{
    if (!_topView) {
        _topView = [[UCTopView_Ph alloc] initWithFrame:CGRectMake(0.f, -SCREEN_WIDTH*BeautifulScale, SCREEN_WIDTH, SCREEN_WIDTH*BeautifulScale)];
    }
    return _topView;
}

- (UCHeadView_Ph *)headView{
    if (!_headView) {
        _headView = [[UCHeadView_Ph alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, 50.f)];
        [_headView setBackgroundColor:[UIColor greenColor]];
    }
    return _headView;
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[
                       
                       ];
    }
    return _dataArray;
}

@end
