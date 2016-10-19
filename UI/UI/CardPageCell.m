//
//  CardPageCell.m
//  Master
//
//  Created by xhc on 10/18/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "CardPageCell.h"

@interface CardPageCell()

@property (nonatomic,strong) NSString *reuseIdentifier;

@end

@implementation CardPageCell

- (instancetype)initWithNSIndexPath:(NSIndexPath *)indexPath reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super init]) {
//        self.reuseIdentifier = reuseIdentifier;
        _reuseIdentifier = [NSString stringWithFormat:@"%@%ld",reuseIdentifier,(long)indexPath.row];
        NSLog(@"%@",_reuseIdentifier);
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 100.f, 20.f)];
        [label setBackgroundColor:[UIColor whiteColor]];
        [label setText:@"无敌第一帅"];
        [label setTag:10001];
        [self addSubview:label];
        
        UILabel *rightLbl = [[UILabel alloc] initWithFrame:CGRectMake(Width(self)-100.f, 40.f, 100.f, 20.f)];
        [rightLbl setTag:1000];
        [rightLbl setTextColor:COLORFORRGB(0xffffff)];
        [rightLbl setBackgroundColor:[UIColor blackColor]];
        [rightLbl setText:@"天下第二帅"];
        [self addSubview:rightLbl];
        
        self.imgView = [[UIImageView alloc] init];
        [self.imgView setContentMode:UIViewContentModeScaleToFill];
        [self addSubview:self.imgView];
    }
    return self;
}

- (void)layoutSubviews{
    UILabel *label = [self viewWithTag:1000];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.width.equalTo(@100.f);
        make.top.equalTo(self).offset(40.f);
        make.height.equalTo(@20.f);
    }];
    
    UILabel *label2 = [self viewWithTag:1002];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20.f);
        make.width.equalTo(@100.f);
        make.top.equalTo(self).offset(10.f);
        make.height.equalTo(@20.f);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(40.f);
        make.width.height.equalTo(@60.f);
        make.top.equalTo(self).offset(40.f);
    }];
}

@end
