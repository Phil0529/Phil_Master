//
//  WaitPayView.h
//  Master
//
//  Created by Phil Xhc on 3/28/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PayMethods){
    PayMethods_AliPay = 11,
    PayMethods_WeiChatPay = 12,
};

@interface WaitPayView : UIView

@property (nonatomic, strong) void (^buttonEvents)(NSInteger payMethods);

@end
