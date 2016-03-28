//
//  NeighborViewController.m
//  EZTV
//
//  Created by Lee, Bo on 16/2/1.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import "NeighborViewController.h"
#import "AppConfig.h"
#import "NeighborQuery.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "TransfromView.h"
#import "NeighborCell.h"
#import "HysteriaPlayer.h"

@interface NeighborViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, strong) UITableView *neighborTableView;

@end

@implementation NeighborViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:BACKGROUND_COLOR];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    
//    if (SYSTEM_VERSION_LESS_THAN(@"8.0")) {
//        [self.navigationController.navigationBar setTranslucent:NO];
//    }
    
    UIView *navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, 64.f)];
    [navigationBar setBackgroundColor:COLORFORRGB(0xFAFAFA)];
    [self.view addSubview:navigationBar];
    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 20.f, NAVBTN_WIDTH + 20.f, 44.f)];
    [btnBack setImage:[UIImage imageNamed:@"ic_mypartner_back"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(viewDissmiss) forControlEvents:UIControlEventTouchUpInside];
    [navigationBar addSubview:btnBack];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(btnBack), 20.f, SCREEN_WIDTH - 2 * MaxX(btnBack), 44.f)];
    [lblTitle setFont:[UIFont boldSystemFontOfSize:19.f]];
    [lblTitle setTextColor:COLORFORRGB(0x333333)];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [navigationBar addSubview:lblTitle];
    [lblTitle setText:@"neibor"];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0.f, Height(navigationBar) - 1.f, Width(navigationBar), 1.f)];
    [line setBackgroundColor:COLORFORRGB(0xE7E7E7)];
    [navigationBar addSubview:line];
    
    _neighborTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, MaxY(navigationBar), SCREEN_WIDTH, SCREEN_HEIGHT - MaxY(navigationBar)) style:UITableViewStylePlain];
    [_neighborTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_neighborTableView setDataSource:self];
    [_neighborTableView setDelegate:self];
    [_neighborTableView setRowHeight:neighborCellHeight];
    [_neighborTableView registerClass:[NeighborCell class] forCellReuseIdentifier:neighborCellReuseIdentifer];
    [_neighborTableView setContentInset:UIEdgeInsetsMake(20.f, 0.f, 20.f, 0.f)];
    [self.view addSubview:_neighborTableView];
    
    UIImageView *imgBg = [[UIImageView alloc] initWithFrame:_neighborTableView.bounds];
    [imgBg setContentMode:UIViewContentModeScaleAspectFill];
    [imgBg setImage:[UIImage imageNamed:@"ic_myparter_bg"]];
    //
    UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(Width(imgBg)/2 - 1.f, 0.f, 2.f, Height(imgBg))];
    [vLine setBackgroundColor:COLORFORRGB(0xBFC3C6)];
    [imgBg addSubview:vLine];
    
    [_neighborTableView setBackgroundView:imgBg];
    
    __weak __typeof(self) weakSelf = self;
    [NeighborQuery getMyNeighbors:^(NSArray *result) {
        if (weakSelf && [result count] > 0) {
#ifndef RELEASE_VER
            NSMutableArray *testData = [[NSMutableArray alloc] init];
            [result enumerateObjectsUsingBlock:^(NeighborItem*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.userPath rangeOfString:@"user.test"].length > 0) {
                    [testData addObject:obj];
                }
            }];
            MAIN(^{
                weakSelf.dataArray = [NSArray arrayWithArray:testData];
                [weakSelf.neighborTableView reloadData];
            });
#else
            MAIN(^{
                weakSelf.dataArray = result;
                [weakSelf.neighborTableView reloadData];
            });
#endif

        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NeighborItem *item = [_dataArray objectAtIndex:indexPath.row];
    NeighborCell *cell = [tableView dequeueReusableCellWithIdentifier:neighborCellReuseIdentifer];
    if (!cell) {
        cell = [[NeighborCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:neighborCellReuseIdentifer];
    }
    [cell updateWithItem:item row:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NeighborItem *item = [_dataArray objectAtIndex:indexPath.row];
    CGRect initFrame = self.view.bounds;
    initFrame.origin.x += CGRectGetWidth(initFrame);
    TransfromView *tView = [[TransfromView alloc] initWithFrame:initFrame neighbor:item];
    [self.view addSubview:tView];
    [self.view setUserInteractionEnabled:NO];
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        [tView setCenter:CGPointMake(Width(self.view)/2, Height(self.view)/2)];
    } completion:^(BOOL finished) {
        [weakSelf.view setUserInteractionEnabled:YES];
        [[AppConfig sharedConfig] jumpToNeighbor:item completion:^{
            if (weakSelf) {
                if ([HysteriaPlayer sharedInstance].isPlaying) {
                    [[HysteriaPlayer sharedInstance] pause];
                    [[HysteriaPlayer sharedInstance] pausePlayerForcibly:YES];
                }
                [weakSelf performSelector:@selector(viewDissmiss) withObject:nil afterDelay:3.0];
            }
        }];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewDissmiss
{
//    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ( (UIInterfaceOrientationMaskPortrait & (1 << interfaceOrientation)) != 0 )
        return YES;
    
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return YES;
}



@end
