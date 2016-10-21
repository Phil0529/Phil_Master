//
//  AnimationTool.h
//  Master
//
//  Created by Phil Xhc on 7/18/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnimationToolProtocol.h"
//
//typedef NS_ENUM(NSInteger, AnimationOrientation){
//    AnimationOrientation_Left  = 1,
//    AnimationOrientation_Right = 2,
//    AnimationOrientation_Top   = 3,
//    AnimationOrientation_Bottom= 4,
//};
//
//
//@protocol AnimationToolProtocol <NSObject>
//
//@optional;
//
//- (void)viewWillPop:(UIView *)view;
//
//- (void)viewWillDismiss:(UIView *)view;
//
//- (void)viewDidPop:(UIView *)view;
//
//- (void)viewDidDismiss:(UIView *)view;
//
//@end

@interface AnimationTool : NSObject

@property (nonatomic,weak)     id<AnimationToolProtocol> delegate;

- (void)addAnimationPopView:(UIView *)view duration:(float)time orientation:(AnimationOrientation)orientation;

- (void)addAnimationDismissView:(UIView *)view duration:(float)time orientation:(AnimationOrientation)orientation;

@end
