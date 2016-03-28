//
//  TransfromView.m
//  EZTV
//
//  Created by Lee, Bo on 16/2/18.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import "TransfromView.h"

@implementation TransfromView

- (instancetype)initWithFrame:(CGRect)frame neighbor:(NeighborItem *)neighbor
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        CGFloat imgHeight = floorf(CGRectGetWidth(frame) * 6/5);
        CGFloat paddingTop = (CGRectGetHeight(frame) - imgHeight)/2 + 10.f;
        CGFloat paddingBottom = paddingTop - 20.f;
        if (!ISEMPTYSTR(neighbor.appImage)) {
            UIImageView *adImg = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, paddingTop, CGRectGetWidth(frame), imgHeight)];
            [adImg setClipsToBounds:YES];
            [adImg setContentMode:UIViewContentModeScaleAspectFill];
            [self addSubview:adImg];
            [adImg sd_setImageWithURL:[NSURL URLWithString:neighbor.appImage]];
        }
        
        CGFloat space = paddingTop - 70.f > 0.f ? floorf((paddingTop - 70.f)/3) : 0.f;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 20.f + space, CGRectGetWidth(frame) - 20.f, 27.f)];
        [title setFont:[UIFont boldSystemFontOfSize:24.f]];
        [title setTextAlignment:NSTextAlignmentCenter];
        [title setTextColor:COLORFORRGB(0x666666)];
        [self addSubview:title];
        [title setText:neighbor.appName];
        
        UILabel *distance = [[UILabel alloc] initWithFrame:CGRectMake(10.f, MaxY(title) + space, Width(title), 23.f)];
        [distance setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:distance];
        
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"距离我 %@ 公里", neighbor.appDistance] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20.f]}];
        [attrString addAttribute:NSForegroundColorAttributeName value:COLORFORRGB(0xbbbbbb) range:NSMakeRange(0, 4)];
        [attrString addAttribute:NSForegroundColorAttributeName value:COLORFORRGB(0xbbbbbb) range:NSMakeRange(attrString.length - 3, 3)];
        [attrString addAttribute:NSForegroundColorAttributeName value:COLORFORRGB(0x666666) range:NSMakeRange(4, neighbor.appDistance.length)];
        [distance setAttributedText:attrString];
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [indicator setColor:[UIColor lightGrayColor]];
        [indicator setCenter:CGPointMake(CGRectGetWidth(frame)/2, CGRectGetHeight(frame) - paddingBottom/2)];
        [self addSubview:indicator];
        [indicator startAnimating];
        
        UILabel *lblDesc = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(indicator) + 10.f, MidY(indicator) - 25.f, CGRectGetWidth(frame) - MaxX(indicator) - 20.f, 50.f)];
        [lblDesc setTextColor:COLORFORRGB(0xBBBBBB)];
        [lblDesc setFont:[UIFont systemFontOfSize:18.f]];
        [lblDesc setNumberOfLines:0];
        [lblDesc setTextAlignment:NSTextAlignmentCenter];
        [lblDesc setText:neighbor.appDesc];
        [self addSubview:lblDesc];
    }
    return self;
}

@end
