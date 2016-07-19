//
//  UITabBar+CenterBtnExtension.h
//  Master
//
//  Created by Phil Xhc on 5/12/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (CenterBtnExtension)

@property (nonnull, nonatomic, retain) NSString *showCenterButton;
@property (nonnull, nonatomic, retain) UIView *badgeView;

- (void)setTabBarCenterButton:(void ( ^ _Nullable )(UIButton * _Nullable centerButton ))centerButtonBlock;

- (void)reloadTabbarWithShowCenterButton:(BOOL)showCenterButton;

- (void)setBadgeOfThirdButton:(BOOL)show;

@end
