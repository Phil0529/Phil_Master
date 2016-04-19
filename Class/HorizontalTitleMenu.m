//
//  HorizontalTitleMenu.h
//  ShowProduct
//
//  Created by lin on 14-5-22.
//  Copyright (c) 2014年 @"". All rights reserved.
//

#import "HorizontalTitleMenu.h"

#define kFontSize 15.5f

@implementation HorizontalTitleMenu
{
    UIView *_indicator;
    UIButton *_lastSelected;
    NSMutableArray *_buttonArray;
    UIScrollView *_scrollView;
    UIImageView *_coverLeft;
    UIImageView *_coverRight;
    BOOL _hasCover;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame cover:NO];
}

- (id)initWithFrame:(CGRect)frame cover:(BOOL)cover
{
    self = [super initWithFrame:frame];
    if (self) {
        _hasCover = cover;
        [self setBackgroundColor:BACKGROUND_COLOR];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setDelegate:self];
        _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [self addSubview:_scrollView];
        
        _indicator = [[UIView alloc] init];
        [_indicator setBackgroundColor:FOREGROUND_COLOR];
        [_scrollView addSubview:_indicator];
        
        _buttonArray = [[NSMutableArray alloc] init];
        
        if (cover) {
            _coverLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, 25.f, CGRectGetHeight(frame) - .5f)];
            [_coverLeft setImage:[UIImage imageNamed:@"coverLeft"]];
            [_coverLeft setAlpha:0.f];
            [self addSubview:_coverLeft];
            
            _coverRight = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - 25.f, 0.f, 25.f, CGRectGetHeight(frame) - .5f)];
            [_coverRight setImage:[UIImage imageNamed:@"coverRight"]];
            [_coverRight setAlpha:0.f];
            [self addSubview:_coverRight];
        }
    }
    return self;
}

- (void)refreshMenuView
{
    if (!_dataSource) {
        return;
    }
    if ([_buttonArray count] > 0) {
        [_buttonArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_buttonArray removeAllObjects];
    }
    [_indicator setFrame:CGRectMake([self getMenuSpace]/2 + 5.f,Height(self) - 12.f, 30.f, 2.5f)];
    CGFloat menuWidth = 0.0;
    CGFloat buttonHeight = kFontSize;
    UIFont *titleFont = [UIFont systemFontOfSize:kFontSize];
    NSInteger count = [_dataSource numberOfItemsInHorizontalMenu:self];
   CGFloat defaultSpace = [self getMenuSpace];
    for (int i = 0; i < count ; i++) {
        NSString *title = [_dataSource horizontalMenu:self titleForItemAtIndex:i];
        CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:titleFont}];
        CGFloat buttonWidth = titleSize.width + defaultSpace;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(menuWidth, 7.5f, buttonWidth, buttonHeight)];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:RGBCOLOR(186.f, 202.f, 198.f) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button.titleLabel setFont:titleFont];
        [button setTag:(i + 100)];
        [button addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:[UIColor clearColor]];
        [_scrollView addSubview:button];
        [_buttonArray addObject:button];
        menuWidth += buttonWidth;
    }
    // 设置滚动范围
    [_scrollView setContentSize:CGSizeMake(menuWidth, buttonHeight)];
    [self bringSubviewToFront:_indicator];
    if (_hasCover) {
        if (menuWidth > CGRectGetWidth(_scrollView.frame)) {
            [_coverRight setAlpha:1.f];
        }
    }
    [self clickOnButtonAtIndex:0];
}

- (void)menuButtonClicked:(UIButton *)button
{
    if (_lastSelected && _lastSelected.tag == button.tag) {
        return;
    }
    NSInteger index = button.tag - 100;
    [self setButtonSelectedAtIndex:index];
    if (_menuDelegate && [_menuDelegate respondsToSelector:@selector(horizontalMenu:didClickedAtIndex:)]) {
        [_menuDelegate horizontalMenu:self didClickedAtIndex:index];
    }
}

- (void)clickOnButtonAtIndex:(NSInteger)index
{
    if (ISINDEXINRANGE(index, _buttonArray)) {
        UIButton *button = [_buttonArray objectAtIndex:index];
        [self menuButtonClicked:button];
    }
}

- (void)setButtonSelectedAtIndex:(NSInteger)index
{
    if (!ISINDEXINRANGE(index, _buttonArray)) {
        return;
    }
    UIButton *button = [_buttonArray objectAtIndex:index];
    if ((_lastSelected && _lastSelected.tag == button.tag)) {
        return;
    }
    [_lastSelected setSelected:NO];
    [button setSelected:YES];
    _lastSelected = button;
    
    CGPoint cOffset = [_scrollView contentOffset];
    CGFloat xOffset = 45.f;
    
    if (button.frame.origin.x < cOffset.x) {
        xOffset *= -1;
    }
    CGFloat defaultSpace = [self getMenuSpace];
    NSString *title = [_dataSource horizontalMenu:self titleForItemAtIndex:index];
    CGSize currentTitleSize = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kFontSize]}];
    [UIView animateWithDuration:0.2f
                     animations:^
     {
         [_indicator setFrame:CGRectMake(CGRectGetMinX(button.frame) + defaultSpace/2 + 5.f, Height(self) - 12, currentTitleSize.width - 10.f, 2.5f)];
         [_scrollView scrollRectToVisible:CGRectMake(CGRectGetMinX(button.frame) + xOffset, 0.f, CGRectGetWidth(button.frame), CGRectGetHeight(button.frame)) animated:YES];
     }];
}

- (void)scrollToNextPage
{
    CGFloat viewWidth = _scrollView.frame.size.width;
    CGPoint cOffset = [_scrollView contentOffset];
    CGSize  cSize = [_scrollView contentSize];
    if (cOffset.x >= (cSize.width - viewWidth)) {
        return;
    } else {
        CGFloat offsetX = (cOffset.x + viewWidth) > (cSize.width - viewWidth) ? (cSize.width - viewWidth) : (cOffset.x + viewWidth);
        [_scrollView setContentOffset:CGPointMake(offsetX, cOffset.y) animated:YES];
    }
}

#pragma mark -- UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_hasCover) {
        CGFloat contentWidth = scrollView.contentSize.width;
        CGFloat contentOffsetX = scrollView.contentOffset.x;
        if (contentOffsetX < 9.f) {
            CGFloat alpha = (contentOffsetX < 0.f ? 0.f : contentOffsetX)/25.f;
            [_coverLeft setAlpha:alpha];
        } else if ((contentWidth - contentOffsetX - scrollView.frame.size.width) < 9.f)
        {
            CGFloat alpha = ((contentWidth - contentOffsetX - scrollView.frame.size.width) < 0.f ? 0.f : (contentWidth - contentOffsetX - scrollView.frame.size.width))/25.f;
            [_coverRight setAlpha:alpha];
        } else {
            [_coverRight setAlpha:1.f];
            [_coverLeft setAlpha:1.f];
        }
    }
}

- (CGFloat)getMenuSpace{

    UIFont *titleFont = [UIFont systemFontOfSize:kFontSize];
    NSInteger count = [_dataSource numberOfItemsInHorizontalMenu:self];
    CGFloat defaultSpace = 30.f;
    CGFloat totalTitleWidth = 0.f;
    for (int i = 0; i < count ; i++) {
        NSString *title = [_dataSource horizontalMenu:self titleForItemAtIndex:i];
        CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:titleFont}];
        totalTitleWidth += titleSize.width;
    }
    defaultSpace = MAX((CGRectGetWidth(self.frame) - totalTitleWidth)/count, defaultSpace);
    return defaultSpace;
}
@end
