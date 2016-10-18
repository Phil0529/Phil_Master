//
//  PGIndexBannerSubiew.m
//  NewPagedFlowViewDemo
//
//  Created by Mars on 16/6/18.
//  Copyright © 2016年 Mars. All rights reserved.
//  Designed By PageGuo,
//  QQ:799573715
//  github:https://github.com/PageGuo/NewPagedFlowView

#import "PGIndexBannerSubiew.h"

@implementation PGIndexBannerSubiew

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.mainImageView];
//        [self addSubview:self.coverView];
        [self addSubview:self.titleLabel];
        
        CALayer *layer = [self layer];
        layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(-10,-10,self.bounds.size.width,self.bounds.size.height)].CGPath;
        layer.masksToBounds = NO;
        layer.shadowOffset = CGSizeMake(10, 10);
        layer.shadowRadius = 5.f;
        layer.shadowOpacity = 0.5;
    }
    
    return self;
}

- (UIImageView *)mainImageView {
    
    if (_mainImageView == nil) {
        _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f,self.bounds.size.width, self.bounds.size.height-20.f)];
        [_mainImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_mainImageView setClipsToBounds:YES];
        _mainImageView.userInteractionEnabled = YES;
    }
    return _mainImageView;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] initWithFrame:self.bounds];
        _coverView.backgroundColor = [UIColor clearColor];
    }
    return _coverView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, self.bounds.size.height - 20.f, self.bounds.size.width, 20.f)];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setText:@"测试标题"];
    }
    return _titleLabel;
}

@end
