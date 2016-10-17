//
//  SDPageFlowView.m
//  NewPagedFlowViewDemo
//
//  Created by Phil Xhc on 8/12/16.
//  Copyright © 2016 robertcell.net. All rights reserved.
//

#import "SDPageFlowView.h"
#import "UIImageView+WebCache.h"

static Class _cellClass = nil;

@interface SDPageFlowView()<UIScrollViewDelegate>

{
    CGFloat _scaleW;
    CGFloat _scaleH;
    CGFloat _z;
}

@property (nonatomic, strong) UIScrollView *scView;

@property (nonatomic,retain) NSArray *dataArray;

@property (nonatomic,assign) BOOL isLoading;

@property (nonatomic,assign) CGFloat scaleFactor;

@property (nonatomic, strong) UIImageView *placeHolderBg;

@property (nonatomic, copy) NSArray *arrImage;

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

@end

@implementation SDPageFlowView

- (id)initWithFrame:(CGRect)frame itemSize:(CGSize)itemSize{
    if (self = [super initWithFrame:frame]) {
        self.itemSize = itemSize;
        _scaleW = 0.8;
        _scaleH = 0.8;
        _z = 20.f;
        _autoRollTime = 2.f;
        _autoRoll = YES;
        [self stopMoving];
        [self startMoving];
    }
    return self;
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
    [self reloadImageView];
}

- (void)resetEmpty{
    [self setAdsWithImages:[NSArray arrayWithObjects:@"holder", nil]];
}

- (void)initUI{
    _scView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scView.delegate = self;
    _scView.pagingEnabled = YES;
    [_scView setBounces:NO];
    
    _scView.showsHorizontalScrollIndicator = NO;
    _scView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAds)];
    [_scView addGestureRecognizer:tap];
    
    CGFloat W = self.frame.size.width;
    CGFloat H = self.frame.size.height;
    
    CGFloat w = self.itemSize.width;
    CGFloat h = self.itemSize.height;
    
    
    _firstView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, W, H)];
    _preView = [[UIView alloc] initWithFrame:CGRectMake(W, 0.f, W, H)];
    _currentView = [[UIView alloc] initWithFrame:CGRectMake(2*W, 0.f, W, H)];
    _nextView = [[UIView alloc] initWithFrame:CGRectMake(3*W, 0.f, W, H)];
    _lastView = [[UIView alloc] initWithFrame:CGRectMake(4*W, 0.f, W, H)];
    
    CGFloat alphaW = w*_scaleW;
    _firstImgView = [[UIImageView alloc] initWithFrame:CGRectMake(W-alphaW+_z, (H-_scaleH*h)/2, alphaW, h*_scaleH)];
    _preImgView = [[UIImageView alloc] initWithFrame:CGRectMake(W-alphaW+_z, (H-_scaleH*h)/2, alphaW, h*_scaleH)];
    _currentImgView = [[UIImageView alloc] initWithFrame:CGRectMake((W-w)/2, (H-h)/2, w, h)];
    _nextImgView = [[UIImageView alloc] initWithFrame:CGRectMake(-_z, (H-_scaleH*h)/2, alphaW, h*_scaleH)];
    _lastImgView = [[UIImageView alloc] initWithFrame:CGRectMake(-_z, (H-_scaleH*h)/2, alphaW, h*_scaleH)];
    
    _firstView.contentMode = UIViewContentModeScaleToFill;
    _preImgView.contentMode = UIViewContentModeScaleToFill;
    _currentImgView.contentMode = UIViewContentModeScaleToFill;
    _nextImgView.contentMode = UIViewContentModeScaleToFill;
    _lastImgView.contentMode = UIViewContentModeScaleToFill;
    
    [_firstView addSubview:_firstImgView];
    [_preView addSubview:_preImgView];
    [_currentView addSubview:_currentImgView];
    [_nextView addSubview:_nextImgView];
    [_lastView addSubview:_lastImgView];
    
    [_scView addSubview:_firstView];
    [_scView addSubview:_preView];
    [_scView addSubview:_currentView];
    [_scView addSubview:_nextView];
    [_scView addSubview:_lastView];
    
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

- (void)tapAds{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat W = self.frame.size.width;
    CGFloat H = self.frame.size.height;
    
    CGFloat w = self.itemSize.width;
    CGFloat h = self.itemSize.height;
    CGFloat alphaW = w*_scaleW;
    
    CGRect preFrame = CGRectMake(W-alphaW+_z, (H-_scaleH*h)/2, alphaW, h*_scaleH);
    CGRect currentFrame = CGRectMake((W-w)/2, (H-h)/2, w, h);
    CGRect nextFrame = CGRectMake(-_z, (H-_scaleH*h)/2, alphaW, h*_scaleH);
    
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
            [_currentImgView setFrame:frame];
            
            
            frame = nextFrame;
            frame.origin.x = nextFrame.origin.x + changeRate*fabs(currentFrame.origin.x - nextFrame.origin.x);
            frame.origin.y = nextFrame.origin.y - changeRate*fabs(currentFrame.origin.y - nextFrame.origin.y);
            frame.size.width = nextFrame.size.width + changeRate*fabs(currentFrame.size.width - nextFrame.size.width);
            frame.size.height = nextFrame.size.height + changeRate*fabs(currentFrame.size.height - nextFrame.size.height);
            [_nextImgView setFrame:frame];
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
           [_currentImgView setFrame:frame];
           
           frame = preFrame;
           frame.origin.x = preFrame.origin.x - changeRate*fabs(preFrame.origin.x - currentFrame.origin.x);
           frame.origin.y = preFrame.origin.y - changeRate*fabs(preFrame.origin.y - currentFrame.origin.y);
           frame.size.width = preFrame.size.width + changeRate*fabs(preFrame.size.width - currentFrame.size.width);
           frame.size.height = preFrame.size.height + changeRate*fabs(preFrame.size.height - currentFrame.size.height);
           [_preImgView setFrame:frame];
       }
   }else{
       [_preImgView setFrame:preFrame];
       [_currentImgView setFrame:currentFrame];
       [_nextImgView setFrame:nextFrame];
   }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self startMoving];
    if (scrollView.contentOffset.x >= self.frame.size.width * 3) {
        _currentIndex++;
    } else if (scrollView.contentOffset.x < 2*self.frame.size.width) {
        _currentIndex--;
    }
    scrollView.scrollEnabled = YES;
    [self reloadImageView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x >= self.frame.size.width * 2) {
        _currentIndex++;
    } else if (scrollView.contentOffset.x < self.frame.size.width) {
        _currentIndex--;
    }
    scrollView.scrollEnabled = YES;
    [self reloadImageView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopMoving];
}

- (void)scrollTimer
{
    if (_arrImage.count > 1) {
        [UIView animateWithDuration:.8f animations:^{
            CGPoint contentOffset = _scView.contentOffset;
            [_scView setContentOffset:CGPointMake(contentOffset.x + CGRectGetWidth(self.frame), contentOffset.y)];
        } completion:^(BOOL finished) {
            _currentIndex++;
            [self reloadImageView];
        }];
    }
}

- (void)startMoving
{
    if (_autoRoll) {
        _autoRollTimer = [NSTimer scheduledTimerWithTimeInterval:_autoRollTime target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
    }
}

- (void)stopMoving
{
    if ([_autoRollTimer isValid]) {
        [_autoRollTimer invalidate];
        _autoRollTimer = nil;
    }
}

- (void)dealloc
{
    [self stopMoving];
}
@end
