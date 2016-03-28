//
//  NotifyView.m
//  HuaXia
//
//  Created by Lee, Bo on 15/4/7.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "NotifyView.h"

@implementation NotifyView
{
    NSString *_msg;
    UILabel *_lblMsg;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame msg:@""];
}

- (instancetype)initWithFrame:(CGRect)frame msg:(NSString *)msg
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:.8f]];
        self.layer.cornerRadius = 3.5f;
        [self.layer setShadowOffset:CGSizeMake(2.f, 2.f)];
        [self.layer setShadowOpacity:.8f];
        
        _msg = msg;
        
        _lblMsg = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, frame.size.width, frame.size.height)];
        [_lblMsg setTextAlignment:NSTextAlignmentCenter];
        [_lblMsg setTextColor:[UIColor whiteColor]];
        [_lblMsg setNumberOfLines:0];
        [_lblMsg setFont:[UIFont boldSystemFontOfSize:15.f]];
        [_lblMsg setText:msg];
        [self addSubview:_lblMsg];
    }
    return self;
}

- (void)showMsg:(NSString *)msg
{
    [_lblMsg setText:msg];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
