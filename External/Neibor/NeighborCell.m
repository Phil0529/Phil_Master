//
//  NeighborCell.m
//  EZTV
//
//  Created by Lee, Bo on 16/2/18.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import "NeighborCell.h"

CGFloat const neighborCellHeight = 70.f;
NSString* const neighborCellReuseIdentifer = @"_neighborCellReuseIdentifer";

@implementation NeighborCell
{
    UIImageView *_appIcon;
    UIImageView *_triangle;
    UIView *_dialogBg;
    UILabel *_lblTitle;
    UILabel *_lblDept;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor clearColor]];
        _appIcon = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 50.f)/2, 0.f, 50.f, 50.f)];
        [_appIcon.layer setCornerRadius:25.f];
        [_appIcon setClipsToBounds:YES];
        [_appIcon.layer setBorderColor:COLORFORRGB(0xFFFFFF).CGColor];
        [_appIcon.layer setBorderWidth:2.f];
        [self.contentView addSubview:_appIcon];
        
        _dialogBg = [[UIView alloc] init];
        [_dialogBg setBackgroundColor:[UIColor whiteColor]];
        [_dialogBg.layer setBorderWidth:.5f];
        [_dialogBg.layer setBorderColor:COLORFORRGB(0xe7e7e7).CGColor];
        [_dialogBg.layer setShadowColor:COLORFORRGB(0xd8d8d8).CGColor];
        [_dialogBg.layer setShadowOffset:CGSizeMake(3.5f, 3.5f)];
        [_dialogBg.layer setCornerRadius:4.f];
        [_dialogBg setClipsToBounds:YES];
        [self.contentView addSubview:_dialogBg];
        
        _lblTitle = [[UILabel alloc] init];
        [_lblTitle setTextColor:COLORFORRGB(0x333333)];
        [_lblTitle setTextAlignment:NSTextAlignmentCenter];
        [_lblTitle setFont:[UIFont systemFontOfSize:17.f]];
        [_lblTitle setAdjustsFontSizeToFitWidth:YES];
        [_lblTitle setLineBreakMode:NSLineBreakByTruncatingMiddle];
        [_dialogBg addSubview:_lblTitle];
        
        _lblDept = [[UILabel alloc] init];
        [_lblDept setTextColor:COLORFORRGB(0x999999)];
        [_lblDept setTextAlignment:NSTextAlignmentCenter];
        [_lblDept setFont:[UIFont systemFontOfSize:10.f]];
        [_lblDept setNumberOfLines:0];
        [_dialogBg addSubview:_lblDept];
        
        _triangle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_mypartner_sanjiao"]];
        [self.contentView addSubview:_triangle];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)updateWithItem:(NeighborItem *)item row:(NSInteger)row
{
    if (!ISEMPTYSTR(item.appIcon)) {
        [_appIcon sd_setImageWithURL:[NSURL URLWithString:item.appIcon]];
    }
    if (ISEMPTYSTR(item.appName)) {
        item.appName = @"未知";
    }
    if (ISEMPTYSTR(item.appDept)) {
        item.appDept = @"未知";
    }
    CGFloat dialogX = 5.f;
    if (row%2 == 0) {
        dialogX += MaxX(_appIcon);
        _triangle.transform = CGAffineTransformIdentity;
        [_triangle setCenter:CGPointMake(MaxX(_appIcon) + 6.f - Width(_triangle)/2, MidY(_appIcon))];
    } else {
        _triangle.transform = CGAffineTransformMakeRotation(180*M_PI/180.0);
        [_triangle setCenter:CGPointMake(MinX(_appIcon) - 6.f + Width(_triangle)/2, MidY(_appIcon))];
    }
    [_lblTitle setText:item.appName];
    [_lblTitle sizeToFit];
    
    CGFloat maxTextWidth = (SCREEN_WIDTH - Width(_appIcon))/2 - 20.f;
    if (Width(_lblTitle) > maxTextWidth) {
        [_lblTitle setFrame:CGRectMake(0.f, 0.f, maxTextWidth, Height(_lblTitle))];
    }
    
    CGSize boundingSize = CGSizeMake(maxTextWidth, 60.f);
    CGSize requiredSize = CGSizeZero;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:10.f]};
    requiredSize = [item.appDept boundingRectWithSize:boundingSize
                                             options:\
                    NSStringDrawingTruncatesLastVisibleLine |
                    NSStringDrawingUsesLineFragmentOrigin |
                    NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    [_dialogBg setFrame:CGRectMake(dialogX, 2.f, maxTextWidth + 10.f, 24.f + Height(_lblTitle) + requiredSize.height)];
    [_lblTitle setCenter:CGPointMake(Width(_dialogBg)/2, 10.f + Height(_lblTitle)/2)];
    [_lblDept setText:item.appDept];
    if (requiredSize.height < 15.f) {
        [_lblDept setTextAlignment:NSTextAlignmentCenter];
    } else {
        //超过一行了 左对齐
        [_lblDept setTextAlignment:NSTextAlignmentLeft];
    }
    [_lblDept setFrame:CGRectMake(5.f, MaxY(_lblTitle) + 4.f, maxTextWidth, requiredSize.height)];
}

@end
