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
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"

@interface CardPageVC ()<CardPageViewDataSource>

@property (nonatomic,strong) CardPageView *cardPageView;

@property (nonatomic,strong) NSArray *imageArray;

@end

@implementation CardPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self imageArray];
    [self cardPageView];
    
}

- (NSInteger)numberOfRowsInCardPageView:(CardPageView *)cardPageView{
    return 5;
}

- (UIView *)cellViewInCardPageView:(CardPageView *)cardPageView indexPath:(NSIndexPath *)indexPath{
    CardPageCell *cell = [cardPageView dequeueReusableCellWithIndex:indexPath];
    if(!cell){
//        cell = [CardPageCell alloc] initWithNSIndexPath:indexPath reuseIdentifier:<#(NSString *)#>
    }
    return cell;
}


- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView{
    return CGSizeMake(SCREEN_WIDTH - 84, (SCREEN_WIDTH - 84) * 9 / 16);
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    NSLog(@"ViewController 滚动到了第%ld页",pageNumber);
}


- (CardPageView *)cardPageView{
    if (!_cardPageView) {
        _cardPageView = [[CardPageView alloc] initWithFrame:CGRectMake(0.f,0.f, SCREEN_WIDTH, 200.f)];
        _cardPageView.dataSource = self;
        [self.view addSubview:_cardPageView];
    }
    return _cardPageView;
}

- (NSArray *)imageArray{
    if (!_imageArray) {
        _imageArray = @[@"Yosemite00",@"Yosemite01",@"Yosemite02",@"Yosemite03",@"Yosemite04"];
    }
    return _imageArray;
}

@end
