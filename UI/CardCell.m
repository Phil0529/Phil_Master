//
//  CardCell.m
//  NewPagedFlowViewDemo
//
//  Created by Phil Xhc on 8/15/16.
//  Copyright © 2016 robertcell.net. All rights reserved.
//

#import "CardCell.h"
#import "UIImageView+WebCache.h"

@interface CardCell()

@property (nonatomic,strong) UIImageView *mainImg;

@property (nonatomic,strong) UILabel *titleLbl;

@end

@implementation CardCell

- (instancetype)init{
    if (self = [super init]) {
        [self addSubview:self.mainImg];
        [self addSubview:self.titleLbl];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        [self addSubview:self.mainImg];
//        [self addSubview:self.titleLbl];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_mainImg setFrame:CGRectMake(0.f, 0.f,self.frame.size.width,self.frame.size.height-20.f)];
    [_titleLbl setFrame:CGRectMake(0.f, CGRectGetMaxY(self.mainImg.frame), self.frame.size.width, 20.f)];
}

- (void)refreshViewWithImage:(NSString *)imgUrl title:(NSString *)title{
    [self.mainImg sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"holder"]];
    [self.titleLbl setText:title];
}

- (UIImageView *)mainImg{
    if (!_mainImg) {
        _mainImg = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f,220.f, 180 - 20.f)];
        [_mainImg setContentMode:UIViewContentModeScaleToFill];
        [_mainImg setUserInteractionEnabled:YES];
    }
    return _mainImg;
}

- (UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(20.f,CGRectGetMaxY(self.mainImg.frame),200.f, 20)];
        [_titleLbl setTextAlignment:NSTextAlignmentCenter];
        [_titleLbl setFont:[UIFont systemFontOfSize:16.f]];
    }
    return _titleLbl;
}


@end
