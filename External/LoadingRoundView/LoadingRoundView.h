//
//  LoadingRoundView.h
//  FamilyShow
//  自动转圈圈的view
//  Created by guoziyi on 14-12-25.
//  Copyright (c) 2014年 net.sunniwell.sz. All rights reserved.
//

#import <UIKit/UIKit.h>

//圈圈的位置
typedef NS_ENUM(NSInteger, LoadingRoundViewPosition) {
    LoadingRoundViewPositionDefault,    //默认（居中）
    LoadingRoundViewPositionLeftTop,    //左上角
    LoadingRoundViewPositionRightTop,    //右上角
};

typedef NS_ENUM(NSUInteger, LoadingColor) {
    Color_white = 0,
    Color_black = 1 << 0,
    Color_red = 1 << 1,
    Color_gray = 1 << 2,
};

@interface LoadingRoundView : NSObject

@property (strong, nonatomic, readonly) UIActivityIndicatorView *activityView;
@property (assign, nonatomic) LoadingRoundViewPosition position;

//默认初始化模式，显示大圈圈
- (id)initWithView:(UIView *)view;
//显示小圈圈的初始化模式
- (id)initWithSmallIconAtView:(UIView *)view;

- (void)showInView:(UIView *)view withColor:(LoadingColor)color;
- (void)showInView:(UIView *)view withColor:(LoadingColor)color text:(NSString *)text;
- (void)hide;

- (void)setPosition:(LoadingRoundViewPosition)position newParentFrame:(CGRect)frame;

@end
