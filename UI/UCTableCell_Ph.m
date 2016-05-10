//
//  UCTableCell_Ph.m
//  Master
//
//  Created by Phil Xhc on 4/22/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "UCTableCell_Ph.h"
#import "UITools.h"

NSString *const UCTableCell_PhReuseIdentifier = @"UCTableCell_PhReuseIdentifier";

@interface UCTableCell_Ph()

@end

@implementation UCTableCell_Ph

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:UNDERGROUND_COLOR];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setIsFirstLine:(BOOL)isFirstLine{
    if (isFirstLine) {
        return;
    }
    [self addSubview:[UITools lineView]];
}


@end
