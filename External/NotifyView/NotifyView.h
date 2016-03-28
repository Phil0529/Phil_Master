//
//  NotifyView.h
//  HuaXia
//
//  Created by Lee, Bo on 15/4/7.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotifyView : UIView

- (instancetype)initWithFrame:(CGRect)frame msg:(NSString *)msg;

- (void)showMsg:(NSString *)msg;

@end
