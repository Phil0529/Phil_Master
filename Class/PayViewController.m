//
//  PayViewController.m
//  Master
//
//  Created by Phil Xhc on 3/28/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "PayViewController.h"
#import "WaitPayViewController.h"

@interface PayViewController ()

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(20.f,SCREEN_HEIGHT - 200.f, SCREEN_WIDTH-40.f, 40.f)];
    [btn setTitle:@"去支付" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(payClick) forControlEvents:1<<6];
    [self.view addSubview:btn];
}

- (void)payClick{
    WaitPayViewController *vc = [[WaitPayViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
