//
//  CardPageVC.m
//  Master
//
//  Created by xhc on 10/17/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "CardPageVC.h"
#import "CardPageView.h"
#import "CardCell.h"

@interface CardPageVC ()<CardPageViewDelegate,CardPageViewDataSource>

@property (nonatomic,strong) CardPageView *cardPageView;

@end

@implementation CardPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cardPageView];
}

- (NSInteger)numberOfRowsInCardPageView:(CardPageView *)cardPageView{
    return 5;
}

- (UIView *)cellViewInCardPageView:(CardPageView *)cardPageView index:(NSInteger)index{
    CardCell *cell;
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UIVC_Ph_UITableViewCell_Reuse"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UIVC_Ph_UITableViewCell_Reuse"];
//    }
    
//    CardCell *cell = [NSCalendarDayChangedNotification ;;]

    
    return cell;
}

- (CardPageView *)cardPageView{
    if (!_cardPageView) {
        _cardPageView = [[CardPageView alloc] initWithFrame:CGRectMake(0.f,100.f, SCREEN_WIDTH, 200.f)];
        [self.view addSubview:_cardPageView];
    }
    return _cardPageView;
}

@end
