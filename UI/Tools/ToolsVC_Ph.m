//
//  ToolsVC_Ph.m
//  Master
//
//  Created by xhc on 10/21/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "ToolsVC_Ph.h"
#import "FadeAnimationVC_Ph.h"
#import "CategoryToolVC_Ph.h"
#import "ProgressHUDVC_Ph.h"
#import "GCDVC_Ph.h"
#import "FMDBVC_Ph.h"
#import "BlockVC_Ph.h"
#import "TestVC_Ph.h"

NSString *const Test_Address = @"123";

@interface ToolsVC_Ph ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation ToolsVC_Ph

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataArray];
    [self tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UIVC_Ph_UITableViewCell_Reuse"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UIVC_Ph_UITableViewCell_Reuse"];
    }
    
    NSString *title;
    ToolsType type = [_dataArray[indexPath.row] integerValue];
    switch (type) {
        case ToolsType_Animation:{
            title = @"Animation";
        }
            break;
        case ToolsType_Category:{
            title = @"Category";
        }
            break;
        case ToolsType_Progress:{
            title = @"Progresss";
        }
            break;
        case ToolsType_GCD:{
            title = @"GCD";
        }
            break;
        case ToolsType_FMDB:{
            title = @"FMDB";
        }
            break;
        case ToolsType_Block:{
            title = @"Block";
        }
            break;
        case ToolsType_Test:{
            title = @"Test";
        }
            break;
    }
    [cell.textLabel setText:title];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ToolsType type = [_dataArray[indexPath.row] integerValue];
    UIViewController *vc;
    switch (type) {
        case ToolsType_Animation:{
            vc = [FadeAnimationVC_Ph new];
        }
            break;
        case ToolsType_Category:{
            vc = [CategoryToolVC_Ph new];
        }
            break;
        case ToolsType_Progress:{
            vc = [ProgressHUDVC_Ph new];
        }
            break;
        case ToolsType_GCD:{
            vc = [GCDVC_Ph new];
        }
            break;
        case ToolsType_FMDB:{
            vc = [FMDBVC_Ph new];
        }
            break;
        case ToolsType_Block:{
            vc = [BlockVC_Ph new];
        }
            break;
        case ToolsType_Test:{
            vc = [TestVC_Ph new];
        }
            break;
    }
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UITableView *)tableView{
    if (!_tableView) {
        @weakify(self);
        _tableView = ({
            @strongify(self);
            UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
            [tableView setRowHeight:SCALING_FACTOR_H(64.f)];
            [tableView setDelegate:self];
            [tableView setDataSource:self];
            [self.view addSubview:tableView];
            tableView;
        });
    }
    return _tableView;
}

- (NSArray *)dataArray{
    if(!_dataArray){
        _dataArray = @[@(ToolsType_Animation),@(ToolsType_Category),@(ToolsType_Progress),@(ToolsType_GCD),@(ToolsType_FMDB),@(ToolsType_Block),@(ToolsType_Test)];
    }
    return _dataArray;
}

@end
