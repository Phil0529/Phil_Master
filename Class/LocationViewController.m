//
//  LocationViewController.m
//  Master
//
//  Created by Phil Xhc on 3/25/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "LocationViewController.h"
#import "NavTitleView.h"
#import "LocationManager.h"

@interface LocationViewController()

@property (nonatomic, strong) LocationManager *locaManager;

@end

@implementation LocationViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:BACKGROUND_COLOR];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locaSuccess:) name:LOCATION_INFORMATION object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.locaManager = [[LocationManager alloc] init];
    [self.locaManager startGetLocation];
}

- (void)locaSuccess:(NSNotification *)notification{
    LocationItem *item = [notification object];
    UILabel *locaLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 100.f, SCREEN_WIDTH, 20.f)];
    [locaLabel setBackgroundColor:[UIColor blackColor]];
    [locaLabel setTextColor:[UIColor whiteColor]];
    [locaLabel setFont:[UIFont systemFontOfSize:14.f]];
    [locaLabel setText:[NSString stringWithFormat:@"%@",item.address]];
    [self.view addSubview:locaLabel];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}





@end
