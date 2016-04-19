//
//  WaitPayView.m
//  Master
//
//  Created by Phil Xhc on 3/28/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "WaitPayView.h"

@interface WaitPayView()
{
    PayMethods _payMethods;
}

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *unitPriceLbl;
@property (nonatomic, strong) UILabel *countLbl;
@property (nonatomic, strong) UILabel *totalPriceLbl;
@property (nonatomic, strong) UIView *alipayView;
@property (nonatomic, strong) UIView *wechatView;
@property (nonatomic, strong) UIImageView *weichatSelectImg;
@property (nonatomic, strong) UIImageView *alipaySelectImg;
@property (nonatomic, strong) UIButton *payBtn;

@end

@implementation WaitPayView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUserInteractionEnabled:YES];
        [self addSubview:self.titleLbl];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addPageView];
        [self addSubview:self.unitPriceLbl];
        [self addSubview:self.countLbl];
        [self addSubview:self.totalPriceLbl];
        [self addSubview:self.alipayView];
        [self addSubview:self.wechatView];
        [self addSubview:self.payBtn];
    }
    return self;
}

- (void)addPageView{
    UIView *firstLineView = [[UIView alloc] initWithFrame:CGRectMake(0.f, MaxY(self.titleLbl), SCREEN_WIDTH-55.f, 0.5f)];
    [firstLineView setBackgroundColor:RGBCOLOR(235.f, 235.f, 235.f)];
    [self addSubview:firstLineView];
    
    NSArray *titleArray = @[@"单价",@"数量",@"应付金额"];
    for (NSInteger i = 0; i < 3; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12.f, MaxY(self.titleLbl) + 40*i, SCREEN_WIDTH/2 - 12.f, 40.f)];
        [label setText:titleArray[i]];
        [label setFont:[UIFont systemFontOfSize:14.f]];
        [label setTextColor:COLORFORRGB(0x787878)];
        [self addSubview:label];
    }
    UIView *blankView = [[UIView alloc] initWithFrame:CGRectMake(0.5f,MaxY(self.totalPriceLbl), SCREEN_WIDTH, 35.f/2)];
    [blankView setBackgroundColor:BACKGROUND_COLOR];
    [self addSubview:blankView];
}

- (void)aliPayTap:(UITapGestureRecognizer *)tap{
    _payMethods = PayMethods_AliPay;
    [self.alipaySelectImg setImage:IMAGE(@"ic_list_yixuan")];
    [self.weichatSelectImg setImage:IMAGE(@"ic_list_weixuan")];
}

- (void)weiChatTap:(UITapGestureRecognizer *)tap{
    _payMethods = PayMethods_WeiChatPay;
    [self.alipaySelectImg setImage:IMAGE(@"ic_list_weixuan")];
    [self.weichatSelectImg setImage:IMAGE(@"ic_list_yixuan")];
}

- (void)payClick{
    self.buttonEvents(_payMethods);
}


- (UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(12.f, 0.f, SCREEN_WIDTH-24.f, 55.f)];
        [_titleLbl setFont:[UIFont systemFontOfSize:16.f]];
        [_titleLbl setTextColor:COLORFORRGB(0x333333)];
        [_titleLbl setText:@"C测试"];
    }
    return _titleLbl;
}

- (UILabel *)unitPriceLbl{
    if (!_unitPriceLbl) {
        _unitPriceLbl = [[UILabel alloc] initWithFrame:CGRectMake(13.f,MaxY(self.titleLbl), SCREEN_WIDTH-26.f, 40.f)];
        [_unitPriceLbl setTextAlignment:NSTextAlignmentRight];
        [_unitPriceLbl setFont:[UIFont systemFontOfSize:14.f]];
        [_unitPriceLbl setTextColor:COLORFORRGB(0x787878)];
        [_unitPriceLbl setText:@"¥200测试"];
    }
    return _unitPriceLbl;
}

- (UILabel *)countLbl{
    if (!_countLbl) {
        _countLbl = [[UILabel alloc] initWithFrame:CGRectMake(13.f,MaxY(self.titleLbl)+40.f, SCREEN_WIDTH-26.f, 40.f)];
        [_countLbl setTextAlignment:NSTextAlignmentRight];
        [_countLbl setFont:[UIFont systemFontOfSize:14.f]];
        [_countLbl setTextColor:COLORFORRGB(0x787878)];
        [_countLbl setText:@"5测试"];
    }
    return _countLbl;
}

- (UILabel *)totalPriceLbl{
    if (!_totalPriceLbl) {
        _totalPriceLbl = [[UILabel alloc] initWithFrame:CGRectMake(13.f,MaxY(self.titleLbl)+80.f, SCREEN_WIDTH-26.f, 40.f)];
        [_totalPriceLbl setTextAlignment:NSTextAlignmentRight];
        [_totalPriceLbl setFont:[UIFont systemFontOfSize:14.f]];
        [_totalPriceLbl setTextColor:RGBCOLOR(235.f, 51.f, 61.f)];
        [_totalPriceLbl setText:@"¥1000测试"];
    }
    return _totalPriceLbl;
}

- (UIView *)alipayView{
    if (!_alipayView) {
        _alipayView = [[UIView alloc] initWithFrame:CGRectMake(0.f, MaxY(self.totalPriceLbl) + 35.f/2, SCREEN_WIDTH, 56.f)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aliPayTap:)];
        [_alipayView addGestureRecognizer:tap];
        [_alipayView setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView *img = [[UIImageView alloc] initWithImage:IMAGE(@"ic_zhifubao")];
        [img setCenter:CGPointMake(13.f+35.f/2, Height(_alipayView)/2)];
        [_alipayView addSubview:img];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(56.f, 0.f, 42.f, Height(_alipayView))];
        [label setText:@"支付宝"];
        [label setFont:[UIFont systemFontOfSize:14.f]];
        [label setTextColor:COLORFORRGB(0x585858)];
        [_alipayView addSubview:label];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0.f,Height(_alipayView)-0.5f, SCREEN_WIDTH-55.f, 0.5f)];
        [lineView setBackgroundColor:RGBCOLOR(235.f, 235.f, 235.f)];
        [_alipayView addSubview:lineView];
        
        [_alipayView addSubview:self.alipaySelectImg];
    }
    return _alipayView;
}

- (UIView *)wechatView{
    if (!_wechatView) {
        _wechatView = [[UIView alloc] initWithFrame:CGRectMake(0.f, MaxY(self.alipayView), SCREEN_WIDTH, 56.f)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weiChatTap:)];
        [_wechatView addGestureRecognizer:tap];
        
        UIImageView *img = [[UIImageView alloc] initWithImage:IMAGE(@"ic_wechat")];
        [img setCenter:CGPointMake(13.f+35.f/2, Height(_wechatView)/2)];
        [_wechatView addSubview:img];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(56.f, 0.f, 42.f, Height(_wechatView))];
        [label setText:@"微信"];
        [label setFont:[UIFont systemFontOfSize:14.f]];
        [label setTextColor:COLORFORRGB(0x585858)];
        [_wechatView addSubview:label];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0.f,Height(_wechatView)-0.5f, SCREEN_WIDTH-55.f, 0.5f)];
        [lineView setBackgroundColor:RGBCOLOR(235.f, 235.f, 235.f)];
        [_wechatView addSubview:lineView];
        [_wechatView setBackgroundColor:[UIColor whiteColor]];
        [_wechatView addSubview:self.weichatSelectImg];
        
    }
    return _wechatView;
}

- (UIImageView *)weichatSelectImg{
    if (!_weichatSelectImg) {
        _weichatSelectImg = [[UIImageView alloc] initWithImage:IMAGE(@"ic_list_weixuan")];
        [_weichatSelectImg setCenter:CGPointMake(SCREEN_WIDTH-22.f, Height(_wechatView)/2)];
    }
    return _weichatSelectImg;
}

- (UIImageView *)alipaySelectImg{
    if (!_alipaySelectImg) {
        _alipaySelectImg = [[UIImageView alloc] initWithImage:IMAGE(@"ic_list_yixuan")];
        [_alipaySelectImg setCenter:CGPointMake(SCREEN_WIDTH-22.f, Height(_alipayView)/2)];
    }
    return _alipaySelectImg;
}

- (UIButton *)payBtn{
    if (!_payBtn) {
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payBtn setFrame:CGRectMake(48.f, MaxY(self.wechatView)+90.f*SCREEN_WIDTH/375.f, SCREEN_WIDTH-96.f, 44.f)];
        [_payBtn.titleLabel setFont:[UIFont systemFontOfSize:16.f]];
        [_payBtn setBackgroundColor:FOREGROUND_COLOR];
        [_payBtn setClipsToBounds:YES];
        [_payBtn.layer setCornerRadius:4.f];
        [_payBtn setTitleColor:[UIColor whiteColor] forState:0];
        [_payBtn setTitle:@"立即支付" forState:0];
        [_payBtn addTarget:self action:@selector(payClick) forControlEvents:1<<6];
    }
    return _payBtn;
}




@end
