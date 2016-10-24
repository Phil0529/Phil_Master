
//
//  CategoryToolView_ph.m
//  Master
//
//  Created by xhc on 10/24/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "CategoryToolView_ph.h"
#import "UIImageView+Extension_Ph.h"

@interface CategoryToolView_ph()

@property (nonatomic,strong) UIImageView *imgView1;

@end

@implementation CategoryToolView_ph

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self imgView1];
        [_imgView1 addTapGestureBlock:^{
            NSLog(@"1");
        }];
        
    }
    return self;
}

- (UIImageView *)imgView1{
    if (!_imgView1) {
        @weakify(self);
        _imgView1 = ({
            @strongify(self);
            UIImageView *imgView = [[UIImageView alloc] init];
            [imgView setContentMode:UIViewContentModeScaleAspectFill];
            [self addSubview:imgView];
            [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(20.f);
                make.top.equalTo(self).offset(20.f);
                make.width.height.equalTo(@80.f);
            }];
            [imgView layoutIfNeeded];
            [imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img.jinglingtrip.com/headImg/934f6c4a56604f3fbe388e2f8a164c0d_20160920170903.jpg"]];
            imgView;
        });
    }
    return _imgView1;
}


@end
