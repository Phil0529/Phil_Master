//
//  TableContentPage.h
//  Master
//
//  Created by Phil Xhc on 3/25/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "EZColumnItem.h"
#import "ContentPageProtocol.h"

@interface TableContentPage : UIView<ContentPageProtocol>

- (instancetype)initWithFrame:(CGRect)frame columnItem:(EZColumnItem *)item;

@end
