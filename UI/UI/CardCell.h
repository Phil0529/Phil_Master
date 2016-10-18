//
//  CardCell.h
//  NewPagedFlowViewDemo
//
//  Created by Phil Xhc on 8/15/16.
//  Copyright © 2016 robertcell.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardPageCell.h"

@interface CardCell : CardPageCell

- (void)refreshViewWithImage:(NSString *)imgUrl title:(NSString *)title;

@end
