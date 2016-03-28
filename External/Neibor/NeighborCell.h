//
//  NeighborCell.h
//  EZTV
//
//  Created by Lee, Bo on 16/2/18.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NeighborItem.h"

extern CGFloat const neighborCellHeight;
extern NSString* const neighborCellReuseIdentifer;

@interface NeighborCell : UITableViewCell

- (void)updateWithItem:(NeighborItem *)item row:(NSInteger)row;

@end
