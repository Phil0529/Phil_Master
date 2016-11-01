//
//  ProgressHUDVC_Ph.m
//  Master
//
//  Created by xhc on 10/27/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "ProgressHUDVC_Ph.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "UIView+Toast.h"

@interface ProgressHUDVC_Ph ()

@end

@implementation ProgressHUDVC_Ph

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *mbProgressBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [mbProgressBtn setTitle:@"MBProgressHUD" forState:0];
    [mbProgressBtn setFrame:CGRectMake(100.f, 20.f, 200.f, 30.f)];
    [self.view addSubview:mbProgressBtn];
    @weakify(self);
    mbProgressBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [HUD setMode:MBProgressHUDModeText];
        [HUD.label setFont:[UIFont boldSystemFontOfSize:14.f]];
        [HUD.label setText:@"Progressas案例看是否都看见了看见了看见啥地方"];
        [HUD.label setNumberOfLines:0];
        [HUD setCompletionBlock:nil];
        [HUD setRemoveFromSuperViewOnHide:YES];
        HUD.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
        HUD.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.2f];
        [HUD hideAnimated:YES afterDelay:10.0];

        return [RACSignal empty];
    }];
    
    UIButton *toastBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [toastBtn setTitle:@"Toast" forState:0];
    [toastBtn setFrame:CGRectMake(100.f, 80.f, 200.f, 30.f)];
    [self.view addSubview:toastBtn];
    
    toastBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.view makeToast:@"Toast" duration:2.0f position:CSToastPositionCenter];
        return [RACSignal empty];
    }];
}

@end
