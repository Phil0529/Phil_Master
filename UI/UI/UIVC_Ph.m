//
//  UIVC_Ph.m
//  Master
//
//  Created by xhc on 10/17/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "UIVC_Ph.h"
#import "CardPageVC.h"

@interface UIVC_Ph ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation UIVC_Ph

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
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@",_dataArray[indexPath.row]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIType type = [_dataArray[indexPath.row] integerValue];
    UIViewController *vc;
    switch (type) {
        case UIType_3DCardPage:{
            vc = [CardPageVC new];
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
        _dataArray = @[@(UIType_3DCardPage)];
    }
    return _dataArray;
}

@end
