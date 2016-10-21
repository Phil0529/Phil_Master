//
//  HomeView_Ph.m
//  Master
//
//  Created by xhc on 10/20/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "HomeView_Ph.h"
#import "NSDate+Helper.h"

@interface HomeView_Ph()

@property (nonatomic,strong) UILabel *titleLbl;

@property (nonatomic,strong) UILabel *dayLbl;

@property (nonatomic,strong) UILabel *secLbl;

@property (nonatomic,strong) dispatch_source_t gcdTimer;

@end

@implementation HomeView_Ph

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self titleLbl];
        [self dayLbl];
        [self secLbl];
        
        [_titleLbl setText:@"Never Walk Backwards"];
        [_dayLbl setText:[NSString stringWithFormat:@"%@",@([NSDate daysAgoWith:1993 month:8 day:7])]];

        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _gcdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_gcdTimer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
        @weakify(self);
        dispatch_source_set_event_handler(_gcdTimer, ^{
            @strongify(self);

            MAIN((^{
                @strongify(self);
                [self.secLbl setText:[NSString stringWithFormat:@"%ld",(long)[NSDate secondsAgoWith:1993 month:8 day:7]]];
            }));
        });
        dispatch_resume(_gcdTimer);

    }
    return self;
}

- (UILabel *)titleLbl{
    if (!_titleLbl) {
        @weakify(self);
        _titleLbl = ({
            @strongify(self);
            UILabel *label = [[UILabel alloc] init];
            [self addSubview:label];
            [label setFont:FONT_DEFAULT(25)];
            [label setTextColor:COLORFORRGB(0x000000)];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.top.equalTo(self).offset(20.f);
                make.height.equalTo(@SCALING_FACTOR_H(25.f));
            }];
            label;
        });
    }
    return _titleLbl;
}

- (UILabel *)dayLbl{
    if (!_dayLbl) {
        @weakify(self);
        _dayLbl = ({
            @strongify(self);
            UILabel *label = [[UILabel alloc] init];
            [self addSubview:label];
            [label setFont:FONT_DEFAULT(30.f)];
            [label setTextColor:COLORFORRGB(0x000000)];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.centerY.equalTo(self.mas_centerY).offset(-20.f);
                make.height.equalTo(@SCALING_FACTOR_H(30.f));
            }];
            label;
        });
    }
    return _dayLbl;
}

- (UILabel *)secLbl{
    if (!_secLbl) {
        @weakify(self);
        _secLbl = ({
            @strongify(self);
            UILabel *label = [[UILabel alloc] init];
            [self addSubview:label];
            [label setFont:FONT_DEFAULT(25.f)];
            [label setTextColor:COLORFORRGB(0x000000)];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.centerY.equalTo(self.mas_centerY).offset(20.f);
                make.height.equalTo(@SCALING_FACTOR_H(25.f));
            }];
            label;
        });
    }
    return _secLbl;
}



@end
