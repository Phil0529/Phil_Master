//
//  SDPageFlowView.m
//  NewPagedFlowViewDemo
//
//  Created by Phil Xhc on 8/12/16.
//  Copyright © 2016 robertcell.net. All rights reserved.
//

#import "CardPageView.h"
#import "UIImageView+WebCache.h"
#import "CardPageCell.h"

@interface CardPageView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scView;

@property (nonatomic,strong) NSMutableArray *cellArray;

@property (nonatomic,strong) NSMutableDictionary *resuableCellDict;

@property (nonatomic,assign) NSInteger cellCount;

@property (nonatomic,retain) UIView *cellView;

@property (nonatomic,assign) BOOL isLoading;

@property (nonatomic,assign) CGFloat scaleFactor;

@property (nonatomic, strong) UIImageView *placeHolderBg;

@property (nonatomic, copy) NSArray *arrImage;

@property (nonatomic,strong) UIView *firBaseView;

@property (nonatomic,strong) UIView *secBaseView;

@property (nonatomic,strong) UIView *thiBaseView;

@property (nonatomic,strong) UIView *fouBaseView;

@property (nonatomic,strong) UIView *fivBaseView;

@property (nonatomic,strong) UIView *firstView;

@property (nonatomic,strong) UIView *preView;

@property (nonatomic,strong) UIView *currentView;

@property (nonatomic,strong) UIView *nextView;

@property (nonatomic,strong) UIView *lastView;

@property (nonatomic,strong) UIImageView *firstImgView;

@property (nonatomic,strong) UIImageView *preImgView;

@property (nonatomic,strong) UIImageView *currentImgView;

@property (nonatomic,strong) UIImageView *nextImgView;

@property (nonatomic,strong) UIImageView *lastImgView;

@property (nonatomic,assign) NSInteger currentIndex;

@property (nonatomic,assign) NSInteger preIndex;

@property (nonatomic,assign) NSInteger nextIndex;

@property (nonatomic,assign) BOOL autoRoll;

@property (nonatomic,strong) NSTimer *autoRollTimer;

@property (nonatomic,assign) CGFloat autoRollTime;

@property (nonatomic,strong) NSMutableArray *reusableCells;

@property (nonatomic,assign) BOOL needsLayout;

@end

@implementation CardPageView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _itemSize = CGSizeMake(SCREEN_WIDTH - 100.f, 40.f);
        _scaleWidth = 0.8;
        _scaleHeight = 0.8;
        _cellSpace = 20.f;
        _autoRollTime = 2.f;
        _autoRoll = YES;
        _reusableCells = [[NSMutableArray alloc] init];
        _resuableCellDict = [[NSMutableDictionary alloc] init];
        [self scView];
    }
    return self;
}

- (void)setDelegate:(id<CardPageViewDelegate>)delegate{
    _delegate = delegate;
}

- (void)setDataSource:(id<CardPageViewDataSource>)dataSource{
    _dataSource = dataSource;
    [self preLoad];
}

- (void)preLoad{
    if (_cellCount == 0) {
        [self resetEmpty];
        return;
    }
    if (_dataSource && [_dataSource respondsToSelector:@selector(numberOfRowsInCardPageView:)]) {
        _cellCount = [_dataSource numberOfRowsInCardPageView:self];
    }
    if (_cellCount <= 1) {
        _scView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    } else {
        _scView.contentSize = CGSizeMake(self.frame.size.width * 5, self.frame.size.height);
    }
    [self reloadView];
}

- (void)setAdsWithImages:(NSArray *)imageArray
{
    if (imageArray.count == 0) {
        [self resetEmpty];
        return;
    }
    _arrImage = imageArray;
    
    if (!_scView) {
        [self initUI];
    }
    if (_arrImage.count <= 1) {
        _scView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    } else {
        _scView.contentSize = CGSizeMake(self.frame.size.width * 5, self.frame.size.height);
    }
    [self reloadView];
}

- (void)resetEmpty{
    
}

- (void)initUI{
    [self scView];
    
    CGFloat W = self.frame.size.width;
    CGFloat H = self.frame.size.height;
    
    CGFloat w = self.itemSize.width;
    CGFloat h = self.itemSize.height;
    
    CGFloat alphaW = w*_scaleWidth;
    CGFloat alphaH = h*_scaleHeight;
    
    [_scView addSubview:self.firBaseView];
    [_scView addSubview:self.secBaseView];
    [_scView addSubview:self.thiBaseView];
    [_scView addSubview:self.fouBaseView];
    [_scView addSubview:self.fivBaseView];
    
    _firstView = [[UIView alloc] initWithFrame:CGRectMake(W-alphaW+_cellSpace, (H-alphaH)/2, alphaW, alphaH)];
    _preView = [[UIView alloc] initWithFrame:CGRectMake(W-alphaW+_cellSpace, (H-alphaH)/2, alphaW, alphaH)];
    _currentView = [[UIView alloc] initWithFrame:CGRectMake((W-w)/2, (H-h)/2, w, h)];
    _nextView = [[UIView alloc] initWithFrame:CGRectMake(-_cellSpace, (H-alphaH)/2, alphaW, alphaH)];
    _lastView = [[UIView alloc] initWithFrame:CGRectMake(-_cellSpace, (H-alphaH)/2, alphaW,alphaH)];
    
    [_firBaseView addSubview:_firstView];
    [_secBaseView addSubview:_preView];
    [_thiBaseView addSubview:_currentView];
    [_fouBaseView addSubview:_nextView];
    [_fivBaseView addSubview:_lastView];
    
    //    _firstImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f,0.f, alphaW, alphaH)];
    //    _preImgView = [[UIImageView alloc] initWithFrame:_firstImgView.bounds];
    //    _currentImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, w, h)];
    //    _nextImgView = [[UIImageView alloc] initWithFrame:_firstImgView.bounds];
    //    _lastImgView = [[UIImageView alloc] initWithFrame:_firstImgView.bounds];
    //
    //    _firstImgView.contentMode = UIViewContentModeScaleToFill;
    //    _preImgView.contentMode = UIViewContentModeScaleToFill;
    //    _currentImgView.contentMode = UIViewContentModeScaleToFill;
    //    _nextImgView.contentMode = UIViewContentModeScaleToFill;
    //    _lastImgView.contentMode = UIViewContentModeScaleToFill;
    //
    //    [_firstView addSubview:_firstImgView];
    //    [_preView addSubview:_preImgView];
    //    [_currentView addSubview:_currentImgView];
    //    [_nextView addSubview:_nextImgView];
    //    [_lastView addSubview:_lastImgView];
}

- (void)reloadImageView{
    NSInteger a = _currentIndex;
    NSInteger b = _arrImage.count;
    if (a >= b) {
        _currentIndex = 0;
    }
    if (_currentIndex < 0) {
        _currentIndex = _arrImage.count - 1;
    }
    NSInteger firstIndex = _currentIndex - 2;
    if (firstIndex < 0) {
        firstIndex = _arrImage.count - 2;
    }
    
    NSInteger prev = _currentIndex - 1;
    if (prev < 0) {
        prev = _arrImage.count - 1;
    }
    NSInteger next = _currentIndex + 1;
    if (next > _arrImage.count - 1) {
        next = 0;
    }
    NSInteger lastIndex = _currentIndex + 2;
    if (lastIndex > _arrImage.count - 1) {
        lastIndex = lastIndex - _arrImage.count;
    }
    
    NSString *firstImage = [_arrImage objectAtIndex:firstIndex];
    NSString *prevImage = [_arrImage objectAtIndex:prev];
    NSString *curImage = [_arrImage objectAtIndex:_currentIndex];
    NSString *nextImage = [_arrImage objectAtIndex:next];
    NSString *lastImage = [_arrImage objectAtIndex:lastIndex];
    
    [_firstImgView sd_setImageWithURL:[NSURL URLWithString:firstImage] placeholderImage:[UIImage imageNamed:@"holder"]];
    [_preImgView sd_setImageWithURL:[NSURL URLWithString:prevImage] placeholderImage:[UIImage imageNamed:@"holder"]];
    [_currentImgView sd_setImageWithURL:[NSURL URLWithString:curImage] placeholderImage:[UIImage imageNamed:@"holder"]];
    [_nextImgView sd_setImageWithURL:[NSURL URLWithString:nextImage] placeholderImage:[UIImage imageNamed:@"holder"]];
    [_lastImgView sd_setImageWithURL:[NSURL URLWithString:lastImage] placeholderImage:[UIImage imageNamed:@"holder"]];
    
    [_scView scrollRectToVisible:CGRectMake(2*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
}

- (void)reloadView{
    if (_needsLayout) {
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfRowsInCardPageView:)]) {
            self.cellCount = [self.dataSource numberOfRowsInCardPageView:self];
        }
        [self.reusableCells removeAllObjects];
    }
    
    NSInteger a = _currentIndex;
    NSInteger b = self.cellCount;
    if (a >= b) {
        _currentIndex = 0;
    }
    if (_currentIndex < 0) {
        _currentIndex = b - 1;
    }
    NSInteger firstIndex = _currentIndex - 2;
    if (firstIndex < 0) {
        firstIndex = b - 2;
    }
    
    NSInteger prev = _currentIndex - 1;
    if (prev < 0) {
        prev = b - 1;
    }
    NSInteger next = _currentIndex + 1;
    if (next > b - 1) {
        next = 0;
    }
    NSInteger lastIndex = _currentIndex + 2;
    if (lastIndex > b - 1) {
        lastIndex = lastIndex - b;
    }
    if (self.resuableCellDict.allKeys.count == 0) {
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(cellViewInCardPageView:index:)]) {
            UIView *firstView = [self.dataSource cellViewInCardPageView:self index:firstIndex];
            [self.resuableCellDict setValue:firstView forKey:[NSString stringWithFormat:@"%ld",(long)firstIndex]];
            [firstView setFrame:_firstView.bounds];
            [_firstView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [_firstView addSubview:firstView];
            
            
            UIView *preView = [self.dataSource cellViewInCardPageView:self index:prev];
            [preView setFrame:_preView.bounds];
            [self.resuableCellDict setValue:preView forKey:[NSString stringWithFormat:@"%ld",(long)prev]];
            [_preView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [_preView addSubview:preView];
            
            
            UIView *currentView = [self.dataSource cellViewInCardPageView:self index:_currentIndex];
            [currentView setFrame:_currentView.bounds];
            [self.resuableCellDict setValue:currentView forKey:[NSString stringWithFormat:@"%ld",(long)_currentIndex]];
            [_currentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [_currentView addSubview:currentView];
            
            
            UIView *nextView = [self.dataSource cellViewInCardPageView:self index:next];
            [nextView setFrame:_nextView.bounds];
            [self.resuableCellDict setValue:nextView forKey:[NSString stringWithFormat:@"%ld",(long)next]];
            [_nextView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [_nextView addSubview:nextView];
            
            
            UIView *lastView = [self.dataSource cellViewInCardPageView:self index:lastIndex];
            [lastView setFrame:_lastView.bounds];
            [self.resuableCellDict setValue:lastView forKey:[NSString stringWithFormat:@"%ld",(long)lastIndex]];
            [_lastView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [_lastView addSubview:lastView];
            
        }
    }else{
        UIView *firstView = [self.resuableCellDict objectForKey:[NSString stringWithFormat:@"%ld",(long)firstIndex]];
        [_firstView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_firstView addSubview:firstView];
        
        UIView *preView = [self.resuableCellDict objectForKey:[NSString stringWithFormat:@"%ld",(long)firstIndex]];
        [_preView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_preView addSubview:preView];
        
        UIView *currentView = [self.resuableCellDict objectForKey:[NSString stringWithFormat:@"%ld",(long)firstIndex]];
        [_currentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_currentView addSubview:currentView];
        
        UIView *nextView = [self.resuableCellDict objectForKey:[NSString stringWithFormat:@"%ld",(long)firstIndex]];
        [_nextView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_nextView addSubview:nextView];
        
        UIView *lastView = [self.resuableCellDict objectForKey:[NSString stringWithFormat:@"%ld",(long)firstIndex]];
        [_lastView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_lastView addSubview:lastView];
        
    }
    //    }
    //    NSString *firstImage = [_arrImage objectAtIndex:firstIndex];
    //    NSString *prevImage = [_arrImage objectAtIndex:prev];
    //    NSString *curImage = [_arrImage objectAtIndex:_currentIndex];
    //    NSString *nextImage = [_arrImage objectAtIndex:next];
    //    NSString *lastImage = [_arrImage objectAtIndex:lastIndex];
    //
    //    [_firstImgView sd_setImageWithURL:[NSURL URLWithString:firstImage] placeholderImage:[UIImage imageNamed:@"holder"]];
    //    [_preImgView sd_setImageWithURL:[NSURL URLWithString:prevImage] placeholderImage:[UIImage imageNamed:@"holder"]];
    //    [_currentImgView sd_setImageWithURL:[NSURL URLWithString:curImage] placeholderImage:[UIImage imageNamed:@"holder"]];
    //    [_nextImgView sd_setImageWithURL:[NSURL URLWithString:nextImage] placeholderImage:[UIImage imageNamed:@"holder"]];
    //    [_lastImgView sd_setImageWithURL:[NSURL URLWithString:lastImage] placeholderImage:[UIImage imageNamed:@"holder"]];
    
    [_scView scrollRectToVisible:CGRectMake(2*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
}

- (void)tapAds{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat W = self.frame.size.width;
    CGFloat H = self.frame.size.height;
    
    CGFloat w = self.itemSize.width;
    CGFloat h = self.itemSize.height;
    CGFloat alphaW = w*_scaleWidth;
    CGFloat alphaH = h*_scaleHeight;
    
    CGRect preFrame = CGRectMake(W-alphaW+_cellSpace, (H-alphaH)/2, alphaW,alphaH);
    CGRect currentFrame = CGRectMake((W-w)/2, (H-h)/2, w, h);
    CGRect nextFrame = CGRectMake(-_cellSpace, (H-alphaH)/2, alphaW,alphaH);
    
    UIView *currentCell = [_currentView.subviews firstObject];
    UIView *preCell = [_preView.subviews firstObject];
    UIView *nextCell = [_nextView.subviews firstObject];
    
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
            
            CGFloat changeWidthRate;
            CGFloat changeHeightRate;
            
            [preCell setFrame:_preView.bounds];
            [currentCell setFrame:_currentView.bounds];
            [nextCell setFrame:_nextView.bounds];
            
            for (UIView *subView in currentCell.subviews) {
                changeWidthRate = subView.frame.size.width/_currentView.frame.size.width;
                changeHeightRate = subView.frame.size.height/_currentView.frame.size.height;
                [subView setFrame:CGRectMake(subView.frame.origin.x, subView.frame.origin.y, subView.frame.size.width/changeWidthRate, subView.frame.size.height/changeHeightRate)];
            }
            for (UIView *subView in nextCell.subviews) {
                changeWidthRate = subView.frame.size.width/_nextView.frame.size.width;
                changeHeightRate = subView.frame.size.height/_nextView.frame.size.height;
                [subView setFrame:CGRectMake(subView.frame.origin.x, subView.frame.origin.y, subView.frame.size.width/changeWidthRate, subView.frame.size.height/changeHeightRate)];
            }
        }
    }
    else if (scrollView.contentOffset.x < 2*self.frame.size.width) {
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
            [_nextView setFrame:frame];
        }
    }else{
        [_preView setFrame:preFrame];
        [_currentView setFrame:currentFrame];
        [_nextView setFrame:nextFrame];
        CGFloat changeWidthRate;
        CGFloat changeHeightRate;
        [preCell setFrame:_preView.bounds];
        [currentCell setFrame:_currentView.bounds];
        [nextCell setFrame:_nextView.bounds];
        for (UIView *subView in currentCell.subviews) {
            changeWidthRate = subView.frame.size.width/_currentView.frame.size.width;
            changeHeightRate = subView.frame.size.height/_currentView.frame.size.height;
            [subView setFrame:CGRectMake(subView.frame.origin.x, subView.frame.origin.y,currentFrame.size.width,subView.frame.size.height)];
        }
        for (UIView *subView in nextCell.subviews) {
            changeWidthRate = subView.frame.size.width/_nextView.frame.size.width;
            changeHeightRate = subView.frame.size.height/_nextView.frame.size.height;
            [subView setFrame:CGRectMake(subView.frame.origin.x, subView.frame.origin.y, subView.frame.size.width/changeWidthRate, subView.frame.size.height/changeHeightRate)];
        }
        for (UIView *subView in preCell.subviews){
            changeWidthRate = subView.frame.size.width/_preView.frame.size.width;
            changeHeightRate = subView.frame.size.height/_preView.frame.size.height;
            [subView setFrame:CGRectMake(subView.frame.origin.x, subView.frame.origin.y, subView.frame.size.width/changeWidthRate, subView.frame.size.height/changeHeightRate)];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    [self startMoving];
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    [self stopMoving];
}

- (void)scrollTimer
{
    if (_arrImage.count > 1) {
        [UIView animateWithDuration:.8f animations:^{
            CGPoint contentOffset = _scView.contentOffset;
            [_scView setContentOffset:CGPointMake(contentOffset.x + CGRectGetWidth(self.frame), contentOffset.y)];
        } completion:^(BOOL finished) {
            _currentIndex++;
            [self reloadView];
        }];
    }
}

- (void)startMoving
{
//    if (_autoRoll) {
//        _autoRollTimer = [NSTimer scheduledTimerWithTimeInterval:_autoRollTime target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
//    }
}

- (void)stopMoving
{
//    if ([_autoRollTimer isValid]) {
//        [_autoRollTimer invalidate];
//        _autoRollTimer = nil;
//    }
}

- (void)dealloc
{
    [self stopMoving];
}

- (UIView *)dequeueReusableCellWithIndex:(NSInteger)index{
    if ([self.resuableCellDict objectForKey:[NSString stringWithFormat:@"%ld",index]]) {
        return [self.resuableCellDict objectForKey:[NSString stringWithFormat:@"%ld",index]];
        
    }else{
        return nil;
    }
    
}

- (void)reloadData{
    _needsLayout = YES;
    [self reloadView];
}

-(UIScrollView *)scView{
    if (!_scView) {
        _scView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:_scView];
        _scView.delegate = self;
        [_scView setBounces:NO];
        [_scView setShowsVerticalScrollIndicator:NO];
        [_scView setShowsHorizontalScrollIndicator:NO];
        _scView.pagingEnabled = YES;
        [_scView setScrollsToTop:NO];
    }
    return _scView;
}

- (UIView *)firBaseView{
    if (!_firBaseView) {
        _firBaseView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
    }
    return _firBaseView;
}

- (UIView *)secBaseView{
    if (!_secBaseView) {
        _secBaseView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0.f, self.frame.size.width, self.frame.size.height)];
    }
    return _secBaseView;
}

- (UIView *)thiBaseView{
    if (!_thiBaseView) {
        _thiBaseView = [[UIView alloc] initWithFrame:CGRectMake(2*self.frame.size.width, 0.f, self.frame.size.width, self.frame.size.height)];
    }
    return _thiBaseView;
}

- (UIView *)fouBaseView{
    if (!_fouBaseView) {
        _fouBaseView = [[UIView alloc] initWithFrame:CGRectMake(3*self.frame.size.width, 0.f, self.frame.size.width, self.frame.size.height)];
    }
    return _fouBaseView;
}

- (UIView *)fivBaseView{
    if (!_fivBaseView) {
        _fivBaseView = [[UIView alloc] initWithFrame:CGRectMake(4*self.frame.size.width, 0.f, self.frame.size.width, self.frame.size.height)];
    }
    return _fivBaseView;
}


@end
