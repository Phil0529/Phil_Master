//
//  UIButton+Function_Ph.m
//  StarFactory
//
//  Created by Phil Xhc on 4/25/16.
//  Copyright © 2016 Joygo. All rights reserved.
//

#import "UIButton+Function_Ph.h"
#import <objc/runtime.h>

@implementation UIButton (Function_Ph)

static char topEdgeKey;
static char leftEdgeKey;
static char heightEdgeKey;
static char widthEdgeKey;

- (void)setEnlargedEdge:(CGFloat)enlargedEdge{
    [self setEnlargedEdgeWithTop:enlargedEdge left:enlargedEdge height:enlargedEdge*2 width:enlargedEdge*2];
}

- (CGFloat)enlargedEdge{
    return [(NSNumber *)objc_getAssociatedObject(self, &topEdgeKey) floatValue];
}

- (void)setEnlargedEdgeWithTop:(CGFloat)top left:(CGFloat)left height:(CGFloat)height width:(CGFloat)width{
    objc_setAssociatedObject(self, &topEdgeKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &leftEdgeKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &heightEdgeKey, [NSNumber numberWithFloat:height], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &widthEdgeKey, [NSNumber numberWithFloat:width], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect )enlargeRect{
    NSNumber *topEdge = objc_getAssociatedObject(self, &topEdgeKey);
    NSNumber *leftEdge = objc_getAssociatedObject(self, &leftEdgeKey);
    NSNumber *heightEdge = objc_getAssociatedObject(self, &heightEdgeKey);
    NSNumber *widthEdge = objc_getAssociatedObject(self, &widthEdgeKey);
    if (topEdge && leftEdge && heightEdge && widthEdge) {
        CGRect enlargedRect = CGRectMake(self.bounds.origin.x - leftEdge.floatValue, self.bounds.origin.y - topEdge.floatValue, self.bounds.size.width+widthEdge.floatValue,self.bounds.size.height + heightEdge.floatValue);
        return enlargedRect;
    }
    else{
        return self.bounds;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.alpha <= 0.01 || !self.userInteractionEnabled || self.hidden) {
        return nil;
    }
    CGRect enlargedRect = [self enlargeRect];
    return CGRectContainsPoint(enlargedRect, point) ? self : nil;
}

@end
