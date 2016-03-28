//
//  HorizontalMenu.h
//  ShowProduct
//
//  Created by lin on 14-5-22.
//  Copyright (c) 2014年 @"". All rights reserved.
//

#import <UIKit/UIKit.h>

@class HorizontalMenu;

@protocol HorizontalMenuDelegate <NSObject>

@optional
-(void)horizontalMenu:(HorizontalMenu *)horizontalMenu didClickedAtIndex:(NSInteger)index;

@end

@protocol HorizontalMenuDataSource <NSObject>

- (NSInteger)numberOfItemsInHorizontalMenu:(HorizontalMenu *)horizontalMenu;

- (NSString *)horizontalMenu:(HorizontalMenu *)horizontalMenu titleForItemAtIndex:(NSInteger)index;

@end

@interface HorizontalMenu : UIView<UIScrollViewDelegate>

@property (nonatomic, assign) id<HorizontalMenuDelegate> menuDelegate;
@property (nonatomic, assign) id<HorizontalMenuDataSource> dataSource;

- (instancetype)initWithFrame:(CGRect)frame cover:(BOOL)cover;

- (void)refreshMenuView;

//选中某个button
- (void)clickOnButtonAtIndex:(NSInteger)index;

//改变第几个button为选中状态，不发送delegate
- (void)setButtonSelectedAtIndex:(NSInteger)index;

//翻页
- (void)scrollToNextPage;

@end
