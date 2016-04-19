//
//  TicketNotUseCollViewCell.m
//  Master
//
//  Created by Phil Xhc on 4/5/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "TicketNotUseCollViewCell.h"

NSString *const TicketNotUseCollViewCellReuseIdentifier = @"TicketNotUseCollViewCellReuseIdentifier";

@interface TicketNotUseCollViewCell()

@property (nonatomic, strong) UILabel *ticketNameLbl;
@property (nonatomic, strong) UILabel *validTimeLbl;
@property (nonatomic, strong) UILabel *ticketIdLbl;
@property (nonatomic, strong) UIImageView *lineImgView;
@property (nonatomic, strong) UIImageView *bottomImgView;

@end

@implementation TicketNotUseCollViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 5.f;
        [self addSubview:self.lineImgView];
        [self addSubview:self.ticketNameLbl];
        [self addSubview:self.validTimeLbl];
        [self addSubview:self.ticketIdLbl];
        
    }
    return self;
}

- (UILabel *)ticketNameLbl{
    if (!_ticketNameLbl) {
        _ticketNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(22.f, 77.f/2, Width(self) - 22.f, 24.f)];
        [_ticketNameLbl setFont:[UIFont boldSystemFontOfSize:24.f*SCREEN_WIDTH/375.f]];
        [_ticketNameLbl setTextColor:COLORFORRGB(0x333333)];
        [_ticketNameLbl setText:@"测试 · 测试测试"];
    }
    return _ticketNameLbl;
}

- (UILabel *)validTimeLbl{
    if (!_validTimeLbl) {
        _validTimeLbl = [[UILabel alloc] initWithFrame:CGRectMake(MinX(self.ticketNameLbl), Height(self) - 25.f, Width(self) - MinX(self.ticketNameLbl), 11.f)];
        [_validTimeLbl setFont:[UIFont systemFontOfSize:11.f]];
        [_validTimeLbl setTextColor:COLORFORRGB(0x585858)];
        [_validTimeLbl setText:@"测试日期-2016-05-01"];
    }
    return _validTimeLbl;
}

- (UILabel *)ticketIdLbl{
    if (!_ticketIdLbl) {
        _ticketIdLbl = [[UILabel alloc] initWithFrame:CGRectMake(Width(self)-130.f, Height(self)/2-8.f, 130.f, 16.f)];
        [_ticketIdLbl setFont:[UIFont systemFontOfSize:16.f]];
        [_ticketIdLbl setTextColor:COLORFORRGB(0x333333)];
        [_ticketIdLbl setTextAlignment:NSTextAlignmentCenter];
        [_ticketIdLbl setText:@"ID:Test123"];
    }
    return _ticketIdLbl;
}

- (UIImageView *)lineImgView{
    if (!_lineImgView) {
        _lineImgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width(self)-130.f, 20.f, 2.f,Height(self)-40.f)];
        
        UIGraphicsBeginImageContext(_lineImgView.frame.size);
        [_lineImgView.image drawInRect:CGRectMake(0, 0, _lineImgView.frame.size.width, _lineImgView.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapSquare);
        
        
        CGFloat lengths[] = {10,5};
        CGContextRef line = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(line, RGBCOLOR(229.f, 229.f, 229.f).CGColor);
        
        CGContextSetLineDash(line, 0, lengths, 2);
        CGContextMoveToPoint(line, 2.0, 0.f);
        CGContextAddLineToPoint(line, 2.f, 310.f);
        CGContextStrokePath(line);
        
        _lineImgView.image = UIGraphicsGetImageFromCurrentImageContext();

    }
    return _lineImgView;
}

- (UIImageView *)bottomImgView{
    if (!_bottomImgView) {
        _bottomImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, Height(self) - 4.f, Width(self), 4.f)];
        [_bottomImgView setImage:IMAGE(@"")];
    }
    return _bottomImgView;
}

- (void)refreshCell:(TicketItem *)item{
    
}

@end
