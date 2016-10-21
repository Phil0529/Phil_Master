//
//  AnimationTool.h
//  Master
//
//  Created by Phil Xhc on 7/18/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnimationToolProtocol.h"

@interface AnimationTool : NSObject

@property (nonatomic,weak)     id<AnimationToolProtocol> delegate;

- (void)addAnimationPopView:(UIView *)view duration:(float)time orientation:(AnimationOrientation)orientation;

- (void)addAnimationDismissView:(UIView *)view duration:(float)time orientation:(AnimationOrientation)orientation;

@end
