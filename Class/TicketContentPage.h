//
//  TicketContentPage.h
//  Master
//
//  Created by Phil Xhc on 4/5/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketItem.h"
#import "ContentPageProtocol.h"

@interface TicketContentPage : UIView<ContentPageProtocol>

@property (nonatomic, assign) id<ContentPageDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame item:(TicketItem *)item;

@end
