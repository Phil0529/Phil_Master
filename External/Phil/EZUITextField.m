//
//  EZUITextField.m
//  EZTV
//
//  Created by Sunni on 15/6/15.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "EZUITextField.h"

@implementation EZUITextField
{
    UIView *_underLine;
}

- (instancetype)initWithFrame:(CGRect)frame leftView:(UIView *)leftView
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setLeftView:leftView];
        [self setTextColor:COLORFORRGB(0x212121)];
        [self setFont:[UIFont systemFontOfSize:15.f]];
        [self setLeftViewMode:UITextFieldViewModeAlways];
        [self setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self setTextColor:COLORFORRGB(0xFFFFFF)];
        self.tintColor = self.textColor;
        _underLine = [[UIView alloc] initWithFrame:CGRectMake(0.f, CGRectGetHeight(frame) - .5f, CGRectGetWidth(frame), .5f)];
        [self addSubview:_underLine];
        [self sendSubviewToBack:_underLine];
        [_underLine setBackgroundColor:COLORFORRGB(0xd4d3d3)];
    }
    return self;
}

- (BOOL)becomeFirstResponder
{
    BOOL success = [super becomeFirstResponder];
    if (success) {
        [_underLine setBackgroundColor:FOREGROUND_COLOR];
    }
    return success;
}

- (BOOL)resignFirstResponder
{
    BOOL success = [super resignFirstResponder];
    if (success) {
        [_underLine setBackgroundColor:COLORFORRGB(0xd4d3d3)];
    }
    return success;
}

- (void)setPlaceholder_b:(NSString *)placeholder
{
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.f], NSForegroundColorAttributeName: COLORFORRGB(0x999999)}];
    [self setAttributedPlaceholder:attrStr];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
