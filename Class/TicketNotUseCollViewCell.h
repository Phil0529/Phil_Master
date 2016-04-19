//
//  TicketNotUseCollViewCell.h
//  Master
//
//  Created by Phil Xhc on 4/5/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TicketItem;

extern NSString* const TicketNotUseCollViewCellReuseIdentifier;

@interface TicketNotUseCollViewCell : UICollectionViewCell

- (void)refreshCell:(TicketItem *)item;

@end
