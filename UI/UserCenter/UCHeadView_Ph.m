//
//  UCHeadView_Ph.m
//  Master
//
//  Created by Phil Xhc on 4/22/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "UCHeadView_Ph.h"

NSString *const UCHeadView_PhReuseIdentifier = @"UCHeadView_PhReuseIdentifier";

@interface UCHeadView_Ph()

@property (nonatomic, strong) UIImageView *bigImgView;

@end

@implementation UCHeadView_Ph

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor redColor]];
    }
    return self;
}

- (void)layoutSubviews{
    
}

- (UIImageView *)bigImgView{
    if (!_bigImgView) {
        _bigImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, SCREEN_WIDTH*9/16)];
        [_bigImgView setImage:IMAGE(@"holder")];
        [_bigImgView setContentMode:UIViewContentModeScaleAspectFit];
        
    }
    return _bigImgView;
}
@end
