//
//  SDPageFlowView.m
//  NewPagedFlowViewDemo
//
//  Created by Phil Xhc on 8/12/16.
//  Copyright © 2016 robertcell.net. All rights reserved.
//

#import "CardPageView.h"
#import "CardPageCell.h"

@interface CardPageView()<UIScrollViewDelegate>

@property (nonatomic, assign, readwrite) NSInteger currentPageIndex;

/**
 *  计时器用到的页数
 */

@property (nonatomic, assign) NSInteger page;

@property (nonatomic,assign) CGSize pageSize;

@property (nonatomic,assign) NSInteger cellCount;


@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,assign) NSInteger currentIndex;

@property (nonatomic,strong) UIView *firBaseView;

@property (nonatomic,strong) UIView *secBaseView;

@property (nonatomic,strong) UIView *thiBaseView;

@property (nonatomic,strong) UIView *fouBaseView;

@property (nonatomic,strong) UIView *fivBaseView;



@property (nonatomic,strong) CardPageCell *firstView;

@property (nonatomic,strong) CardPageCell *preView;

@property (nonatomic,strong) CardPageCell *currentView;

@property (nonatomic,strong) CardPageCell *nextView;

@property (nonatomic,strong) CardPageCell *lastView;

@property (nonatomic,retain) NSArray *preArray;

@property (nonatomic,retain) NSArray *curArray;

@property (nonatomic,retain) NSArray *nextArray;

@end

@implementation CardPageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _scaleWidth = 0.8;
        _scaleHeight = 0.8;
        _cellSpace = 20.f;
        _itemSize = CGSizeMake(Width(self)-40.f-40, Height(self)-40.f);
        
        [self scrollView];
        [self firBaseView];
        [self secBaseView];
        [self thiBaseView];
        [self fouBaseView];
        [self fivBaseView];
        
        CGFloat W = self.frame.size.width;
        CGFloat H = self.frame.size.height;
        
        CGFloat w = self.itemSize.width;
        CGFloat h = self.itemSize.height;
        
        CGFloat alphaW = w*_scaleWidth;
        CGFloat alphaH = h*_scaleHeight;
        
        _firstView = [[CardPageCell alloc] initWithFrame:CGRectMake(W-alphaW+_cellSpace, (H-alphaH)/2, alphaW, alphaH)];
        _preView = [[CardPageCell alloc] initWithFrame:CGRectMake(W-alphaW+_cellSpace, (H-alphaH)/2, alphaW, alphaH)];
        _currentView = [[CardPageCell alloc] initWithFrame:CGRectMake((W-w)/2, (H-h)/2, w, h)];
        _nextView = [[CardPageCell alloc] initWithFrame:CGRectMake(-_cellSpace, (H-alphaH)/2, alphaW, alphaH)];
        _lastView = [[CardPageCell alloc] initWithFrame:CGRectMake(-_cellSpace, (H-alphaH)/2, alphaW,alphaH)];
        
        [_firstView setBackgroundColor:[UIColor redColor]];
        [_preView setBackgroundColor:[UIColor yellowColor]];
        [_currentView setBackgroundColor:[UIColor greenColor]];
        [_nextView setBackgroundColor:[UIColor blueColor]];
        [_lastView setBackgroundColor:[UIColor purpleColor]];
        
        [_firBaseView addSubview:_firstView];
        [_secBaseView addSubview:_preView];
        [_thiBaseView addSubview:_currentView];
        [_fouBaseView addSubview:_nextView];
        [_fivBaseView addSubview:_lastView];
        
        [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*2, 0)];
    }
    return self;
}

- (void)setDataSource:(id<CardPageViewDataSource>)dataSource{
    _dataSource = dataSource;
    if (_dataSource && [_dataSource respondsToSelector:@selector(numberOfRowsInCardPageView:)]) {
        _cellCount = [_dataSource numberOfRowsInCardPageView:self];
    }
}

- (void)reloadView{
    NSInteger a = _currentIndex;
    NSInteger b = self.cellCount;
    
    _currentIndex = a >=b ? 0 : _currentIndex < 0 ? b - 1 : _currentIndex;
//    
//    NSInteger firstIndex = _currentIndex - 2 < 0 ? _currentIndex + b - 2 :_currentIndex - 2;
//    
//    NSInteger prev = _currentIndex - 1 < 0 ? b - 1 : _currentIndex - 1;
//    
//    NSInteger next = _currentIndex + 1 > b - 1 ? 0 : _currentIndex + 1;
//    
//    NSInteger lastIndex = _currentIndex + 2 > b - 1 ? _currentIndex + 2 - b : _currentIndex + 2;
    
    
    
    CardPageCell *testView;
    if (_scrollView.contentOffset.x > 2*self.frame.size.width) {
        testView = _currentView;
        _currentView = _nextView;
        _nextView = _lastView;
        _lastView = _firstView;
        _firstView = _preView;
        _preView = testView;
    }
    else if(_scrollView.contentOffset.x < 2*self.frame.size.width){
        testView = _currentView;
        _currentView = _preView;
        _preView = _firstView;
        _firstView = _lastView;
        _lastView = _nextView;
        _nextView = testView;
    }
    [_firBaseView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_firBaseView addSubview:_firstView];
    [_secBaseView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_secBaseView addSubview:_preView];
    [_thiBaseView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_thiBaseView addSubview:_currentView];
    [_fouBaseView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_fouBaseView addSubview:_nextView];
    [_fivBaseView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_fivBaseView addSubview:_lastView];
    
    CGFloat W = self.frame.size.width;
    CGFloat H = self.frame.size.height;
    
    CGFloat w = self.itemSize.width;
    CGFloat h = self.itemSize.height;
    
    CGFloat alphaW = w*_scaleWidth;
    CGFloat alphaH = h*_scaleHeight;

    [_firstView setFrame:CGRectMake(W-alphaW+_cellSpace, (H-alphaH)/2, alphaW, alphaH)];
    [_lastView setFrame:CGRectMake(-_cellSpace, (H-alphaH)/2, alphaW,alphaH)];

    [_scrollView scrollRectToVisible:CGRectMake(2*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        @weakify(self);
        _scrollView = ({
            @strongify(self);
            UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
            [self addSubview:scrollView];
            [scrollView setDelegate:self];
            [scrollView setScrollsToTop:YES];
            [scrollView setClipsToBounds:YES];
            [scrollView setPagingEnabled:YES];
            [scrollView setShowsVerticalScrollIndicator:NO];
            [scrollView setShowsHorizontalScrollIndicator:NO];
            [scrollView setContentSize:CGSizeMake(SCREEN_WIDTH*5,Height(self))];
            scrollView;
        });
    }
    return _scrollView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat W = self.frame.size.width;
    CGFloat H = self.frame.size.height;
    
    CGFloat w = self.itemSize.width;
    CGFloat h = self.itemSize.height;
    
    CGFloat alphaW = w*_scaleWidth;
    CGFloat alphaH = h*_scaleHeight;
    
    CGRect preFrame = CGRectMake(W-alphaW+_cellSpace, (H-alphaH)/2, alphaW,alphaH);
    CGRect currentFrame = CGRectMake((W-w)/2, (H-h)/2, w, h);
    CGRect nextFrame = CGRectMake(-_cellSpace, (H-alphaH)/2, alphaW,alphaH);
    
    CGFloat offset = fabs(scrollView.contentOffset.x - 2*self.frame.size.width);
    float changeRate = (float)offset/(float)self.frame.size.width;
    CGRect frame;
    
    if (scrollView.contentOffset.x > 2*self.frame.size.width) {
        if (scrollView.contentOffset.x > 3*self.frame.size.width) {
            scrollView.scrollEnabled = NO;
        }else{
            frame = currentFrame;
            frame.origin.x = currentFrame.origin.x + changeRate*fabs(preFrame.origin.x - currentFrame.origin.x);
            frame.origin.y = currentFrame.origin.y + changeRate*fabs(preFrame.origin.y - currentFrame.origin.y);
            frame.size.width = currentFrame.size.width - changeRate*fabs(preFrame.size.width - currentFrame.size.width);
            frame.size.height = currentFrame.size.height - changeRate*fabs(preFrame.size.height - currentFrame.size.height);
            [_currentView setFrame:frame];
            
            frame = nextFrame;
            frame.origin.x = nextFrame.origin.x + changeRate*fabs(currentFrame.origin.x - nextFrame.origin.x);
            frame.origin.y = nextFrame.origin.y - changeRate*fabs(currentFrame.origin.y - nextFrame.origin.y);
            frame.size.width = nextFrame.size.width + changeRate*fabs(currentFrame.size.width - nextFrame.size.width);
            frame.size.height = nextFrame.size.height + changeRate*fabs(currentFrame.size.height - nextFrame.size.height);
            [_nextView setFrame:frame];
        }
    }
    else if (scrollView.contentOffset.x < 2 * self.frame.size.width) {
        if (scrollView.contentOffset.x < self.frame.size.width) {
            scrollView.scrollEnabled = NO;
        }else{
            frame = currentFrame;
            frame.origin.x = currentFrame.origin.x - changeRate*fabs(currentFrame.origin.x - nextFrame.origin.x);
            frame.origin.y = currentFrame.origin.y + changeRate*fabs(currentFrame.origin.y - nextFrame.origin.y);
            frame.size.width = currentFrame.size.width - changeRate*fabs(currentFrame.size.width - nextFrame.size.width);
            frame.size.height = currentFrame.size.height - changeRate*fabs(currentFrame.size.height - nextFrame.size.height);
            [_currentView setFrame:frame];
            
            frame = preFrame;
            frame.origin.x = preFrame.origin.x - changeRate*fabs(preFrame.origin.x - currentFrame.origin.x);
            frame.origin.y = preFrame.origin.y - changeRate*fabs(preFrame.origin.y - currentFrame.origin.y);
            frame.size.width = preFrame.size.width + changeRate*fabs(preFrame.size.width - currentFrame.size.width);
            frame.size.height = preFrame.size.height + changeRate*fabs(preFrame.size.height - currentFrame.size.height);
            [_preView setFrame:frame];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x >= self.frame.size.width * 3) {
        _currentIndex++;
    } else if (scrollView.contentOffset.x < 2*self.frame.size.width) {
        _currentIndex--;
    }
    scrollView.scrollEnabled = YES;
    [self reloadView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x >= self.frame.size.width * 2) {
        _currentIndex++;
    } else if (scrollView.contentOffset.x < self.frame.size.width) {
        _currentIndex--;
    }
    scrollView.scrollEnabled = YES;
    [self reloadView];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.x == 3*Width(self) || scrollView.contentOffset.x == Width(self)) {
        [self reloadView];
    }
    scrollView.scrollEnabled = YES;
}

- (UIView *)firBaseView{
    if (!_firBaseView) {
        _firBaseView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
        [_scrollView addSubview:_firBaseView];
    }
    return _firBaseView;
}

- (UIView *)secBaseView{
    if (!_secBaseView) {
        _secBaseView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0.f, self.frame.size.width, self.frame.size.height)];
        [_scrollView addSubview:_secBaseView];
    }
    return _secBaseView;
}

- (UIView *)thiBaseView{
    if (!_thiBaseView) {
        _thiBaseView = [[UIView alloc] initWithFrame:CGRectMake(2*self.frame.size.width, 0.f, self.frame.size.width, self.frame.size.height)];
        [_scrollView addSubview:_thiBaseView];
    }
    return _thiBaseView;
}

- (UIView *)fouBaseView{
    if (!_fouBaseView) {
        _fouBaseView = [[UIView alloc] initWithFrame:CGRectMake(3*self.frame.size.width, 0.f, self.frame.size.width, self.frame.size.height)];
        [_scrollView addSubview:_fouBaseView];
    }
    return _fouBaseView;
}

- (UIView *)fivBaseView{
    if (!_fivBaseView) {
        _fivBaseView = [[UIView alloc] initWithFrame:CGRectMake(4*self.frame.size.width, 0.f, self.frame.size.width, self.frame.size.height)];
        [_scrollView addSubview:_fivBaseView];
    }
    return _fivBaseView;
}
@end

