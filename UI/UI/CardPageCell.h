//
//  CardPageCell.h
//  Master
//
//  Created by xhc on 10/18/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardPageCell : UIView

@property (nonatomic,strong) UIImageView *imgView;

- (instancetype)initWithNSIndexPath:(NSIndexPath *)indexPath reuseIdentifier:(NSString *)reuseIdentifier;

@end
