//
//  FMDBVC_Ph.m
//  Master
//
//  Created by xhc on 11/1/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "FMDBVC_Ph.h"
#import <FMDB/FMDB.h>
#import "TestTool.h"
#import "FMDBView_Ph.h"
#import "TestVC_Ph.h"

@interface FMDBVC_Ph ()

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) void(^block)(BOOL test);

@property (nonatomic,strong) TestTool *tool;

@property (nonatomic,strong) FMDBView_Ph *mainView;

@end

@implementation FMDBVC_Ph

- (void)viewDidLoad {
    [super viewDidLoad];
    [self mainView];
    [self.mainView.firBtn setTitle:@"测试" forState:0];
    self.dataArray = @[@1,@2].mutableCopy;
    self.mainView.firBtnClick = ^{
//        [self.mainView setBackgroundColor:[UIColor redColor]];
//        [self.navigationController pushViewController:[TestVC_Ph new] animated:YES];
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"123" userInfo:nil];
    };
//    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [self.dataArray removeObjectAtIndex:0];
//    }];
    
//    self.block = ^(BOOL Test){
//        //        NSLog(@"self.dataArrat =%@",self.dataArray);
//        [self.dataArray addObject:@3];
//    };
    self.tool = [TestTool new];
//    [[TestTool new] testBlock:^(BOOL test) {
////        [self.mainView setBackgroundColor:[UIColor redColor]];
//        [self.dataArray addObject:@3];
//    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"控制器被dealloc: %@", [[self class] description]);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"进入控制器：%@", [[self class] description]);
}

- (FMDBView_Ph *)mainView{
    if (!_mainView) {
        _mainView = [[FMDBView_Ph alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, SCREEN_HEIGHT-64.f)];
        [self.view addSubview:_mainView];
    }
    return _mainView;
}




@end
