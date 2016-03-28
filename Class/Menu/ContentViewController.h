//
//  ContentViewController.h
//  Master
//
//  Created by Phil Xhc on 3/22/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "EZColumnItem.h"

typedef NS_ENUM(NSUInteger, ContentStyle)
{
    ColumnContent = 0,
    MultiColumnContent = 1,
};

typedef NS_ENUM(NSUInteger, ButtonSet)
{
    ButtonNone = 0,
    ButtonBack = 1 << 0,
    ButtonWebClose = 1 << 1,
    ButtonWebBack = 1 << 8,
    ButtonUpload = 1 << 2,
    ButtonMyUpload = 1 << 3,
    ButtonLiveMenu = 1 << 4,
    ButtonMyFeedBack = 1 << 5,
    ButtonShare = 1 << 6,
    ButtonSign = 1 << 9,
};


@interface ContentViewController : UIViewController

- (instancetype)initWithStyle:(ContentStyle)style;

@property (nonatomic, assign, readonly) ContentStyle style;
@property (nonatomic, assign) ButtonSet buttonSet;
@property (nonatomic, retain) EZColumnItem *columnItem;

@end
