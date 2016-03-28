//
//  PageScrollView.m
//  ShowProduct
//
//  Created by lin on 14-5-23.
//  Copyright (c) 2014年 @"". All rights reserved.
//

#import "PageScrollView.h"

@implementation PageScrollView
{
    NSInteger _currentPage;
    BOOL _needDelegate;
    
    UIScrollView *_scrollView;
    NSMutableArray *_contentPages;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _needDelegate = YES;
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        _scrollView.pagingEnabled = YES;
//        [_scrollView setBounces:NO];
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }
    return self;
}

#pragma mark 添加ScrollowViewd的ContentView
- (void)reloadPageScrollView
{
    if (!_contentPages) {
        _contentPages = [[NSMutableArray alloc] init];
    } else {
        for (UIView *page in _contentPages) {
            [page removeFromSuperview];
        }
        [_contentPages removeAllObjects];
    }
    
    if (_dataSource) {
        NSInteger count = [_dataSource numberOfContentPagesInPageScrollView:self];
        for (int i = 0; i < count ; i++) {
            UIView<ContentPageProtocol> *contentPage = [_dataSource pageScrollView:self contentPageIndex:i];
            [_scrollView addSubview:contentPage];
            [_contentPages addObject:contentPage];
            if (i == 0) {
                [contentPage refreshContentPage];
            }
        }
        [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.frame) * count, CGRectGetHeight(self.frame))];
    }
}

#pragma mark 刷新某个页面
- (void)refreshContentPageAtIndex:(NSInteger)pageIndex
{
    if (ISINDEXINRANGE(pageIndex, _contentPages)) {
        UIView<ContentPageProtocol> *contentPage = [_contentPages objectAtIndex:pageIndex];
        [contentPage refreshContentPage];
    }
}

- (UIView<ContentPageProtocol> *)contentPageIndex:(NSInteger)pageIndex
{
    UIView<ContentPageProtocol> *contentPage;
    if (ISINDEXINRANGE(pageIndex, _contentPages)) {
        contentPage = [_contentPages objectAtIndex:pageIndex];
    }
    return contentPage;
}

#pragma mark 移动ScrollView到某个页面
- (void)scrollViewToPage:(NSInteger)pageIndex
{
    if (ISINDEXINRANGE(pageIndex, _contentPages)) {
    _needDelegate = NO;
    [_scrollView scrollRectToVisible:CGRectMake(CGRectGetWidth(self.frame) * pageIndex, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) animated:YES];
    _currentPage = pageIndex;
    if ([_delegate respondsToSelector:@selector(pageScrollView:scrollToPage:)]) {
        [_delegate pageScrollView:self scrollToPage:pageIndex];
    }
        [self refreshContentPageAtIndex:pageIndex];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _needDelegate = YES;
}
 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (_scrollView.contentOffset.x + CGRectGetWidth(self.frame)/2) / CGRectGetWidth(self.frame);
    if (_currentPage == page) {
        return;
    }
    _currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    if ([_delegate respondsToSelector:@selector(pageScrollView:scrollToPage:)] && _needDelegate) {
        [_delegate pageScrollView:self scrollToPage:_currentPage];
        [self refreshContentPageAtIndex:_currentPage];
    }
}


@end
