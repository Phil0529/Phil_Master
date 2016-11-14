//
//  FDTbCell_Ph.h
//  Master
//
//  Created by xhc on 11/8/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FDFeedEntity;

extern NSString *const FDTbCell_Ph_ReuseIdentifier;

@interface FDTbCell_Ph : UITableViewCell

- (void)refreshViewWith:(FDFeedEntity *)model;

@end
