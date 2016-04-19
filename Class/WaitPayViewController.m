//
//  WaitPayViewController.m
//  Master
//
//  Created by Phil Xhc on 3/28/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "WaitPayViewController.h"
#import "WaitPayView.h"

@interface WaitPayViewController ()

@property (nonatomic, strong) WaitPayView *payView;

@end

@implementation WaitPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BACKGROUND_COLOR];
    [self.navigationItem setTitle:@"等待付款"];
    [self.view addSubview:self.payView];
    
    self.payView.buttonEvents = ^(NSInteger way){
        //支付宝
        if (way == PayMethods_AliPay) {
            
        }
        //微信支付
        else if(way == PayMethods_WeiChatPay){
            
        }
    };
    
}

- (WaitPayView *)payView{
    if (!_payView) {
        _payView = [[WaitPayView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH,305.f)];
    }
    return _payView;
}

@end
