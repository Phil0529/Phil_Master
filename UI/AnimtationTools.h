//
//  AnimtationTools.h
//  Master
//
//  Created by Phil Xhc on 7/18/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AnimationToolsProtocol <NSObject>

@optional;

- (void)viewWillPop;

- (void)viewWillDismiss;

- (void)viewDidPop;

- (void)viewDidDismiss;

@end

@interface AnimtationTools : NSObject

@property (nonatomic,weak)     id<AnimationToolsProtocol> delegate;

- (void)addAnimationPopView:(UIView *)view duration:(float)time;

@end
