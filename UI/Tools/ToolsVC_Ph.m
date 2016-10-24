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
        default:
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
        _dataArray = @[@(ToolsType_Animation),@(ToolsType_Category)];
    }
    return _dataArray;
}

@end
