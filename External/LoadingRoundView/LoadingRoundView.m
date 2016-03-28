//
//  LoadingRoundView.m
//  FamilyShow
//
//  Created by guoziyi on 14-12-25.
//  Copyright (c) 2014年 net.sunniwell.sz. All rights reserved.
//

#import "LoadingRoundView.h"

@interface LoadingRoundView ()

@property (nonatomic ,strong) UILabel *lblTitle;

@end

@implementation LoadingRoundView
{
    LoadingColor _color;
    BOOL _isSmall;
    BOOL _needTitle;
    CGSize _parentViewSize;
}

@synthesize position = _position;
@synthesize activityView = _activityView;

- (UILabel *)lblTitle
{
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10.f, MaxY(_activityView) + 5.f, _parentViewSize.width - 20.f, 20.f)];
        [_lblTitle setFont:[UIFont systemFontOfSize:13.f]];
        [_lblTitle setTextAlignment:NSTextAlignmentCenter];
        [_lblTitle setTextColor:[UIColor whiteColor]];
    }
    return _lblTitle;
}

- (id)initWithView:(UIView *)view
{
    NSAssert(view, @"View must not be nil.");
    _isSmall = NO;
    return [self initWithFrame:view.bounds];
}

//显示小圈圈的初始化模式
- (id)initWithSmallIconAtView:(UIView *)view
{
    NSAssert(view, @"View must not be nil.");
    _isSmall = YES;
    return [self initWithFrame:view.bounds];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        _parentViewSize = frame.size;
        UIActivityIndicatorViewStyle style = _isSmall? UIActivityIndicatorViewStyleWhite : UIActivityIndicatorViewStyleWhiteLarge;
        _activityView = [[UIActivityIndicatorView alloc]
                         initWithActivityIndicatorStyle:style];
        [self setIndicatorColor:Color_black];
        _activityView.hidesWhenStopped = YES;
        [self setPosition:LoadingRoundViewPositionDefault];
    }
    return self;
}

- (void)setIndicatorColor:(LoadingColor)color
{
    if (_color != color) {
        _color = color;
        switch (color) {
            case Color_white:
            {
                [_activityView setColor:[UIColor whiteColor]];
            }
                break;
            case Color_black:
            {
                _activityView.color = [UIColor blackColor];
            }
                break;
            case Color_red:
            {
                [_activityView setColor:COLORFORRGB(0xeb413d)];
            }
                break;
            case Color_gray:
            {
                _activityView.color = [UIColor lightGrayColor];
            }
                break;
        }
    }
}

- (void)setPosition:(LoadingRoundViewPosition)position newParentFrame:(CGRect)frame
{
    _parentViewSize = frame.size;
    [self setPosition:position];
}

- (void)setPosition:(LoadingRoundViewPosition)pos
{
    _position = pos;
    
    CGSize size = _parentViewSize;
    if (CGSizeEqualToSize(CGSizeZero, size)) {
        return;
    }
    switch (_position) {
        case LoadingRoundViewPositionLeftTop:
            _activityView.center = CGPointMake(40.0f, 40.0f);
            break;
        case LoadingRoundViewPositionRightTop:
            _activityView.center = CGPointMake(size.width/2 - 40.0f, 40.0f);
            break;
        case LoadingRoundViewPositionDefault:
        default:
        {
            if (_needTitle) {
                [_activityView setCenter:CGPointMake(size.width/2, size.height/2 - 12.f)];
                [self.lblTitle setCenter:CGPointMake(size.width/2, size.height/2 + 13.f)];
            } else {
                _activityView.center = CGPointMake(size.width/2, size.height/2);
            }
        }
            break;
    }
    
    
}

- (void)showInView:(UIView *)view withColor:(LoadingColor)color
{
    [self showInView:view withColor:color text:nil];
}

- (void)showInView:(UIView *)view withColor:(LoadingColor)color text:(NSString *)text
{
    NSAssert(view, @"View must not be nil.");
    if (!view || (_activityView.superview && _activityView.superview == view)) {
        return;
    }
    if (!ISEMPTYSTR(text)) {
        _needTitle = YES;
        if ([self.lblTitle superview]) {
            [self.lblTitle removeFromSuperview];
        }
        [self.lblTitle setText:text];
    } else {
        _needTitle = NO;
    }
    if (_activityView.superview) {
        [_activityView removeFromSuperview];
    }
    [self setIndicatorColor:color];
    _parentViewSize = view.frame.size;
    [self setPosition:_position];

    [view addSubview:_activityView];
    [view bringSubviewToFront:_activityView];
    [_activityView startAnimating];
    
    if (_needTitle) {
        [view addSubview:self.lblTitle];
        [view bringSubviewToFront:self.lblTitle];
    }
}

- (void)hide
{
    if (_activityView.superview) {
        [_activityView stopAnimating];
        [_activityView removeFromSuperview];
    }
    if (_lblTitle && [_lblTitle superview]) {
        [_lblTitle removeFromSuperview];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
