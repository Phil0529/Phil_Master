//
//  UIButton+Function_Ph.h
//  StarFactory
//
//  Created by Phil Xhc on 4/25/16.
//  Copyright © 2016 Joygo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Function_Ph)

@property (nonatomic, assign) CGFloat enlargedEdge;

- (void)setEnlargedEdgeWithTop:(CGFloat )top left:(CGFloat)left height:(CGFloat )bottom width:(CGFloat)right;

@end
