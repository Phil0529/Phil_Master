//
//  MasterVC_ph.m
//  Master
//
//  Created by Phil Xhc on 7/18/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "MasterVC_Ph.h"
#import "ObjcMsgSendVC_Ph.h"

@interface MasterVC_Ph ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation MasterVC_Ph

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
    MasterType type = [_dataArray[indexPath.row] integerValue];
    switch (type) {
        case MasterType_Objc_MsgSend:{
            title = @"Objc_Msg_Send";
        }
            break;
        default:
            break;
    }
    [cell.textLabel setText:title];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MasterType type = [_dataArray[indexPath.row] integerValue];
    UIViewController *vc;
    switch (type) {
        case MasterType_Objc_MsgSend:{
            vc = [ObjcMsgSendVC_Ph new];
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
        _dataArray = @[@(MasterType_Objc_MsgSend)];
    }
    return _dataArray;
}

@end
