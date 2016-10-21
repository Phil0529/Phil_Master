//
//  NonWindowAnimationTool.h
//  OSLive
//
//  Created by xhc on 9/26/16.
//  Copyright © 2016 gltrip. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnimationToolProtocol.h"

@interface NonWindowAnimationTool : NSObject

@property (nonatomic,assign) BOOL appeared;

@property (nonatomic,assign) BOOL disappeared;


@property (nonatomic,weak)     id<AnimationToolProtocol> delegate;

- (void)addAnimationPopView:(UIView *)view targetSuperView:(UIView *)targetSuperView duration:(float)time orientation:(AnimationOrientation)orientation;

- (void)addAnimationDismissView:(UIView *)view duration:(float)time orientation:(AnimationOrientation)orientation;

@end
