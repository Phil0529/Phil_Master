//
//  HorizontalTitleMenu.h
//  ShowProduct
//
//  Created by lin on 14-5-22.
//  Copyright (c) 2014年 @"". All rights reserved.
//

#import <UIKit/UIKit.h>

@class HorizontalTitleMenu;

@protocol HorizontalTitleMenuDelegate <NSObject>

@optional

-(void)horizontalMenu:(HorizontalTitleMenu *)horizontalMenu didClickedAtIndex:(NSInteger)index;

@end

@protocol HorizontalTitleMenuDataSource <NSObject>

- (NSInteger)numberOfItemsInHorizontalMenu:(HorizontalTitleMenu *)horizontalMenu;

- (NSString *)horizontalMenu:(HorizontalTitleMenu *)horizontalMenu titleForItemAtIndex:(NSInteger)index;

@end

@interface HorizontalTitleMenu : UIView<UIScrollViewDelegate>

@property (nonatomic, assign) id<HorizontalTitleMenuDelegate> menuDelegate;
@property (nonatomic, assign) id<HorizontalTitleMenuDataSource> dataSource;

- (instancetype)initWithFrame:(CGRect)frame cover:(BOOL)cover;

//刷新
- (void)refreshMenuView;

//选中某个button
- (void)clickOnButtonAtIndex:(NSInteger)index;

//改变第几个button为选中状态，不发送delegate
- (void)setButtonSelectedAtIndex:(NSInteger)index;

//翻页
- (void)scrollToNextPage;

@end
