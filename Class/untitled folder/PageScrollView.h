//
//  PageScrollView.h
//  ShowProduct
//
//  Created by lin on 14-5-23.
//  Copyright (c) 2014年 @"". All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EZColumnItem.h"
#import "ContentPageProtocol.h"

@class PageScrollView;

@protocol PageScrollViewDelegate <NSObject>

@optional
- (void)pageScrollView:(PageScrollView *)pageScrollView scrollToPage:(NSInteger)page;

@end

@protocol PageScrollViewDataSource <NSObject>

@required
- (NSInteger)numberOfContentPagesInPageScrollView:(PageScrollView *)pageScrollView;

- (UIView<ContentPageProtocol> *)pageScrollView:(PageScrollView *)pageScrollView contentPageIndex:(NSInteger)pageIndex;

@end

@interface PageScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic,assign) id<PageScrollViewDelegate> delegate;
@property (nonatomic, assign) id<PageScrollViewDataSource> dataSource;

// 刷新ScrollowView的ContentPage
- (void)reloadPageScrollView;

// 刷新某个页面
- (void)refreshContentPageAtIndex:(NSInteger)pageIndex;

//滑动到某个页面
- (void)scrollViewToPage:(NSInteger)pageIndex;

- (UIView<ContentPageProtocol> *)contentPageIndex:(NSInteger)pageIndex;

@end
