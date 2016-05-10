//
//  UCTopView_Ph.m
//  Master
//
//  Created by Phil Xhc on 4/22/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "UCTopView_Ph.h"

@interface UCTopView_Ph()

@property (nonatomic, strong) UIImageView *bigImgView;

@end

@implementation UCTopView_Ph

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.bigImgView];
    }
    return self;
}

- (void)layoutSubviews{
    
}

- (UIImageView *)bigImgView{
    if (!_bigImgView) {
        _bigImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, SCREEN_WIDTH*BeautifulScale)];
        [_bigImgView setImage:IMAGE(@"test")];
        [_bigImgView setContentMode:UIViewContentModeScaleAspectFill];
        [_bigImgView setClipsToBounds:YES];
    }
    return _bigImgView;
}


@end
