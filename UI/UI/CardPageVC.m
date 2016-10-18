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

@interface CardPageVC ()<CardPageViewDelegate,CardPageViewDataSource,NewPagedFlowViewDelegate,NewPagedFlowViewDataSource>

@property (nonatomic,strong) CardPageView *cardPageView;

@property (nonatomic,strong) NewPagedFlowView *pagedFlowView;

@property (nonatomic,strong) NSArray *imageArray;

@end

@implementation CardPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self imageArray];
    [self cardPageView];
    [self pagedFlowView];
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

- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView{
    return _imageArray.count;
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 84, (SCREEN_WIDTH - 84) * 9 / 16)];
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    //在这里下载网络图片
    //  [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
    bannerView.mainImageView.image = self.imageArray[index];
    
    return bannerView;

}

- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView{
    return CGSizeMake(SCREEN_WIDTH - 84, (SCREEN_WIDTH - 84) * 9 / 16);
}

- (CardPageView *)cardPageView{
    if (!_cardPageView) {
        _cardPageView = [[CardPageView alloc] initWithFrame:CGRectMake(0.f,50.f, SCREEN_WIDTH, 200.f)];
        [self.view addSubview:_cardPageView];
    }
    return _cardPageView;
}

- (NewPagedFlowView *)pagedFlowView{
    if (!_pagedFlowView) {
        _pagedFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0.f, 300.f, SCREEN_WIDTH, (SCREEN_WIDTH - 84) * 9 / 16 + 24)];
        _pagedFlowView.backgroundColor = [UIColor whiteColor];
        _pagedFlowView.delegate = self;
        _pagedFlowView.dataSource = self;
        _pagedFlowView.minimumPageAlpha = 0.1;
        _pagedFlowView.minimumPageScale = 0.85;
        _pagedFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
        
        //提前告诉有多少页
        //    pageFlowView.orginPageCount = self.imageArray.count;
        
        _pagedFlowView.isOpenAutoScroll = YES;
        
        //初始化pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _pagedFlowView.frame.size.height - 24 - 8, SCREEN_WIDTH, 8)];
        _pagedFlowView.pageControl = pageControl;
        [_pagedFlowView addSubview:pageControl];
        
        /****************************
         使用导航控制器(UINavigationController)
         如果控制器中不存在UIScrollView或者继承自UIScrollView的UI控件
         请使用UIScrollView作为NewPagedFlowView的容器View,才会显示正常,如下
         *****************************/
        
        UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        [bottomScrollView addSubview:_pagedFlowView];
        
        [_pagedFlowView reloadData];
        
        [self.view addSubview:bottomScrollView];
        
        
    }
    return _pagedFlowView;
}

- (NSArray *)imageArray{
    if (!_imageArray) {
        _imageArray = @[@"Yosemite00",@"Yosemite01",@"Yosemite02",@"Yosemite03",@"Yosemite04"];
    }
    return _imageArray;
}

@end
