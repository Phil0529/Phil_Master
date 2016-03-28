//
//  TableContentPage.m
//  Master
//
//  Created by Phil Xhc on 3/25/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "TableContentPage.h"
NSString* const baseCellReuseIdentifier = @"baseCellReuseIdentifier";

@interface TableContentPage()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataArray;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TableContentPage

@synthesize delegate = _delegate;

- (instancetype)initWithFrame:(CGRect)frame columnItem:(EZColumnItem *)item{
    if (self = [super initWithFrame:frame]) {
        [self.tableView setFrame:CGRectMake(0.f, 0.f, frame.size.width, frame.size.height)];
        [self addSubview:self.tableView];
    }
    return self;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        [_tableView setBackgroundColor:[UIColor redColor]];
//        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:baseCellReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:baseCellReuseIdentifier];
    }
    [cell.textLabel setText:@"测试"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.f;
}

- (void)refreshContentPage{
    
}


@end
