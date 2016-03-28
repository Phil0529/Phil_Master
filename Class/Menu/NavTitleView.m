//
//  NavTitleView.m
//  Master
//
//  Created by Phil Xhc on 3/24/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "NavTitleView.h"

@implementation NavTitleView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        [self.titleLbl setFrame:frame];
        [self.titleLbl setText:title];
        [self addSubview:self.titleLbl];
    }
    return self;
}

- (UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        [_titleLbl setTextColor:[UIColor whiteColor]];
        [_titleLbl setFont:[UIFont boldSystemFontOfSize:19.f]];
        [_titleLbl setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLbl;
}

//sizeToFit->phil

@end
