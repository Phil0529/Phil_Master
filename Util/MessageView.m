//
//  MessageView.m
//  EZTV
//
//  Created by Sunniwell on 11/11/15.
//  Copyright © 2015 Joygo. All rights reserved.
//

#import "MessageView.h"

@implementation MessageView
{
//    UIButton *cancelButton;
    NSInteger totalTime;
    NSString *buttonTitleStr;
    NSTimer *timer;
}

- (instancetype)initWithFrame:(CGRect )frame title:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle withTime:(int)autoHideTime
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor lightGrayColor]];
        self.alpha = 0.8;
        UIView *testView = [[UIView alloc] init];
        [testView setBackgroundColor:[UIColor whiteColor]];
        [testView.layer setCornerRadius:10.0f];
        [testView setClipsToBounds:YES];
        NSInteger viewWidth;
        
        viewWidth = frame.size.width - 300 > 100 ? 360 : 300;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 50)];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
        [testView addSubview:titleLabel];
//        [titleLabel setBackgroundColor:[UIColor lightGrayColor]];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, viewWidth, 1.0f)];
        [testView addSubview:lineView];
        [lineView setBackgroundColor:[UIColor lightGrayColor]];
        
        //初始化label
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
        [label setTextAlignment:NSTextAlignmentLeft];
        //设置自动行数与字符换行
        [label setNumberOfLines:0];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        // 测试字串
        label.text = message;
        label.font = [UIFont systemFontOfSize:24];
        //设置一个行高上限
//        CGSize size = CGSizeMake(viewWidth,1000);
        //计算实际frame大小，并将label的frame变成实际大小
        CGSize size = [label sizeThatFits:CGSizeMake(viewWidth - 10.0f, MAXFLOAT)];
        [label setFrame:CGRectMake(10.0f, 61.0f, viewWidth -20.f, size.height)];
        
        [testView addSubview:label];
        
        UIView *line1View = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame) + 10.0f, viewWidth, 1.0f)];
        [testView addSubview:line1View];
        [line1View setBackgroundColor:[UIColor lightGrayColor]];
        
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line1View.frame), viewWidth, 50)];
        NSString *titleStr = [NSString stringWithFormat:@"%@( %ds )",buttonTitle,autoHideTime];
        [[_cancelBtn titleLabel] setText:titleStr];
        [_cancelBtn setTitle:titleStr forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        totalTime = autoHideTime;
        buttonTitleStr = buttonTitle;
        [_cancelBtn titleLabel].textAlignment = NSTextAlignmentCenter;
        [[_cancelBtn titleLabel] setFont:[UIFont boldSystemFontOfSize:16.0f]];

        [testView addSubview:_cancelBtn];
        
        int height = CGRectGetHeight(titleLabel.frame) + CGRectGetHeight(lineView.frame)+ CGRectGetHeight(label.frame) + CGRectGetHeight(line1View.frame)+ CGRectGetHeight(_cancelBtn.frame) + 20.0f;
        [testView setFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - viewWidth) / 2, ([[UIScreen mainScreen] bounds].size.height - height) / 2, viewWidth, height)];
        
        [self addSubview:testView];
    }
    
    return self;
}
- (void)dealloc
{
    NSLog(@"messageview dealloc");
}
-(void)removeFromSuperview
{
    if (timer && [timer isValid]) {
        [timer invalidate];
        timer = nil;
    }
    [super removeFromSuperview];
}
-(void)show
{
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateButtonTitle) userInfo:nil repeats:YES];
}

- (void) updateButtonTitle
{
    
    if (totalTime <= 0) {
        if (timer) {
            [timer invalidate];
            timer = nil;
        }
        
        [_cancelBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        totalTime = totalTime -1;
        NSString *titleStr = [NSString stringWithFormat:@"%@( %lds )",buttonTitleStr,(long)totalTime];
        [_cancelBtn setTitle:titleStr forState:UIControlStateNormal];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
