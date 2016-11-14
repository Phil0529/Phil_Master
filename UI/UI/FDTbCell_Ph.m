//
//  FDTbCell_Ph.m
//  Master
//
//  Created by xhc on 11/8/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "FDTbCell_Ph.h"
#import "FDFeedEntity.h"

@interface FDTbCell_Ph()

@property (nonatomic, strong)  UILabel *titleLabel;
@property (nonatomic, strong)  UILabel *contentLabel;
@property (nonatomic, strong)  UIImageView *contentImageView;
@property (nonatomic, strong)  UILabel *usernameLabel;
@property (nonatomic, strong)  UILabel *timeLabel;

@property (nonatomic, weak) FDFeedEntity *entity;

@end

NSString *const FDTbCell_Ph_ReuseIdentifier = @"_FDTbCell_Ph_ReuseIdentifier";

@implementation FDTbCell_Ph

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setAccessoryType:UITableViewCellAccessoryNone];
        [self titleLabel];
        [self contentLabel];
        [self contentImageView];
        [self usernameLabel];
        [self timeLabel];
    }
    return self;
}

- (void)refreshViewWith:(FDFeedEntity *)model{
    _entity = model;
    _titleLabel.text = model.title;
    _contentLabel.text = model.content;
    _contentImageView.image = model.imageName.length > 0 ? [UIImage imageNamed:model.imageName] : nil;
    _usernameLabel.text = model.username;
    _timeLabel.text = model.time;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        @weakify(self);
        _titleLabel = ({
            @strongify(self);
            UILabel *label = [[UILabel alloc] init];
            [self addSubview:label];
            [label setFont:FONT_BOLD(16.f)];
            [label setNumberOfLines:0];
            [label setTextColor:COLORFORRGB(0x000000)];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(self).offset(16.f);
                make.trailing.equalTo(self).offset(-10.f);
                make.top.equalTo(self).offset(10.f);
            }];
            label;
        });
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        @weakify(self);
        _contentLabel = ({
            @strongify(self);
            UILabel *label = [[UILabel alloc] init];
            [self addSubview:label];
            [label setFont:[UIFont systemFontOfSize:14.f]];
            [label setNumberOfLines:0];
            [label setTextColor:COLORFORRGB(0x000000)];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.trailing.equalTo(self.titleLabel);
                make.top.equalTo(self.titleLabel.mas_bottom).offset(6.f);
            }];
            label;
        });
    }
    return _contentLabel;
}

- (UIImageView *)contentImageView{
    if (!_contentImageView) {
        @weakify(self);
        _contentImageView = ({
            @strongify(self);
            UIImageView *imgView = [[UIImageView alloc] init];
            [imgView setContentMode:UIViewContentModeScaleAspectFit];
            [self addSubview:imgView];
            [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(self.titleLabel);
                make.top.equalTo(self.contentLabel.mas_bottom).offset(8.f);
                make.trailing.mas_greaterThanOrEqualTo(self).offset(16.f);
            }];
            imgView;
        });
    }
    return _contentImageView;
}

- (UILabel *)usernameLabel{
    if (!_usernameLabel) {
        @weakify(self);
        _usernameLabel = ({
            @strongify(self);
            UILabel *label = [[UILabel alloc] init];
            [self addSubview:label];
            [label setFont:FONT_DEFAULT(14.f)];
            [label setTextColor:COLORFORRGB(0x000000)];
            [label setTextAlignment:NSTextAlignmentLeft];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentImageView.mas_bottom).offset(8.f);
                make.leading.equalTo(self.titleLabel);
                make.bottom.equalTo(self).offset(-4.f);
            }];
            label;
        });
    }
    return _usernameLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        @weakify(self);
        _timeLabel = ({
            @strongify(self);
            UILabel *label = [[UILabel alloc] init];
            [self addSubview:label];
            [label setFont:FONT_DEFAULT(14.f)];
            [label setTextColor:COLORFORRGB(0x000000)];
            [label setTextAlignment:NSTextAlignmentRight];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self.usernameLabel);
                make.leading.equalTo(self.usernameLabel.mas_trailing);
                make.trailing.equalTo(self.titleLabel);
            }];
            label;
        });
    }
    return _timeLabel;
}

- (CGSize)sizeThatFits:(CGSize)size{
    CGFloat totalHeight = 0;
    totalHeight += [_titleLabel sizeThatFits:size].height;
    totalHeight += [_contentLabel sizeThatFits:size].height;
    totalHeight += [_contentImageView sizeThatFits:size].height;
    totalHeight += [_usernameLabel sizeThatFits:size].height;
    totalHeight += 40.f;
    return CGSizeMake(size.width,totalHeight);
}

@end
