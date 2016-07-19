//
//  UITabBar+CenterBtnExtension.m
//  Master
//
//  Created by Phil Xhc on 5/12/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "UITabBar+CenterBtnExtension.h"
#import <objc/runtime.h>
#import "UITools.h"

static void *Show_CenterButton = &Show_CenterButton;

static void *badgeViewKey = &badgeViewKey;

@implementation UITabBar (CenterBtnExtension)

static NSString *AssociatedButtonKey;

- (void)setShowCenterButton:(NSString *)showCenterButton{
    objc_setAssociatedObject(self, Show_CenterButton, showCenterButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)showCenterButton{
    return objc_getAssociatedObject(self, Show_CenterButton);
}

- (void)setBadgeView:(UIView *)badgeView
{
    objc_setAssociatedObject(self, badgeViewKey, badgeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)badgeView
{
    return objc_getAssociatedObject(self, badgeViewKey);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod([self class], @selector(layoutSubviews));
        Method newMethod = class_getInstanceMethod([self class], @selector(extension_layoutSubviews));
        method_exchangeImplementations(originalMethod, newMethod);
    });
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIButton  *centerButton = objc_getAssociatedObject(self, &AssociatedButtonKey);
        if (!centerButton) {
            centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
            objc_setAssociatedObject(self, &AssociatedButtonKey, centerButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        [centerButton setHidden:YES];
        [self addSubview:centerButton];
    }
    
    return self;
}

- (void)extension_layoutSubviews{
    [self extension_layoutSubviews];
    
    BOOL centerButtonnHidden = YES;
    if ([self.showCenterButton boolValue]) {
        for (UIView *childView in self.subviews) {
            if ([childView isMemberOfClass:[UIButton class]]) {
                centerButtonnHidden = childView.hidden?YES:NO;
                [childView setHidden:NO];
                break;
            }
        }
        for (UIView *chidView in self.subviews) {
            if ([chidView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                if (chidView.frame.origin.x < SCREEN_WIDTH/4 - SCREEN_WIDTH/8) {
                    [chidView setFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH/5, 49.f)];
                }else if(chidView.frame.origin.x <SCREEN_WIDTH/4 + SCREEN_WIDTH/8 && chidView.frame.origin.x > SCREEN_WIDTH/4 - SCREEN_WIDTH/8){
                    [chidView setFrame:CGRectMake(SCREEN_WIDTH/5, 0.f, SCREEN_WIDTH/5, 49.f)];
                }else if(chidView.frame.origin.x <SCREEN_WIDTH*2/4 + SCREEN_WIDTH/8 && chidView.frame.origin.x > SCREEN_WIDTH*2/4 - SCREEN_WIDTH/8){
                    [chidView setFrame:CGRectMake(SCREEN_WIDTH*3/5, 0.f, SCREEN_WIDTH/5, 49.f)];
                }
                else if(chidView.frame.origin.x <SCREEN_WIDTH*3/4 + SCREEN_WIDTH/8 && chidView.frame.origin.x > SCREEN_WIDTH*3/4 - SCREEN_WIDTH/8){
                    [chidView setFrame:CGRectMake(SCREEN_WIDTH*4/5, 0.f, SCREEN_WIDTH/5, 49.f)];
                }
            }
        }
    }
    else{
        for (UIView *childView in self.subviews) {
            if ([childView isMemberOfClass:[UIButton class]]) {
                centerButtonnHidden = childView.hidden?YES:NO;
                [childView setHidden:YES];
                break;
            }
        }
        if (!centerButtonnHidden) {
            for (UIView *chidView in self.subviews) {
                if ([chidView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                    if (chidView.frame.origin.x <= SCREEN_WIDTH/5 - SCREEN_WIDTH/10) {
                        [chidView setFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH/4, 49.f)];
                    }else if(chidView.frame.origin.x <SCREEN_WIDTH/5 + SCREEN_WIDTH/10 && chidView.frame.origin.x > SCREEN_WIDTH/5 - SCREEN_WIDTH/10){
                        [chidView setFrame:CGRectMake(SCREEN_WIDTH/4, 0.f, SCREEN_WIDTH/4, 49.f)];
                    }else if(chidView.frame.origin.x <SCREEN_WIDTH*3/5 + SCREEN_WIDTH/10 && chidView.frame.origin.x > SCREEN_WIDTH*2/5 - SCREEN_WIDTH/10){
                        [chidView setFrame:CGRectMake(SCREEN_WIDTH*2/4, 0.f, SCREEN_WIDTH/4, 49.f)];
                    }
                    else if(chidView.frame.origin.x <SCREEN_WIDTH*4/5 + SCREEN_WIDTH/10 && chidView.frame.origin.x > SCREEN_WIDTH*4/5 - SCREEN_WIDTH/10){
                        [chidView setFrame:CGRectMake(SCREEN_WIDTH*3/4, 0.f, SCREEN_WIDTH/4, 49.f)];
                    }
                    
                }
            }
            
        }
        
    }
    
}

- (void)reloadTabbarWithShowCenterButton:(BOOL)showCenterButton{
    if (self.showCenterButton.integerValue == 1 && showCenterButton) {
        return;
    }
    [self setValue:[NSValue valueWithCGRect:self.bounds] forKeyPath:@"_backgroundView.frame"];
    UIButton *centerButton = objc_getAssociatedObject(self, &AssociatedButtonKey);
    centerButton.bounds = CGRectMake(0, 0, centerButton.currentBackgroundImage.size.width, centerButton.currentBackgroundImage.size.height);
    centerButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    self.showCenterButton = showCenterButton? @"1" : @"0";
    [self setNeedsLayout];
    
}

- (void)setTabBarCenterButton:(void ( ^ _Nullable )(UIButton * _Nullable centerButton ))centerButtonBlock
{
    centerButtonBlock(objc_getAssociatedObject(self, &AssociatedButtonKey));
}

- (void)layoutSublayersOfLayer:(CALayer *)layer{
    [super layoutSublayersOfLayer:layer];
    BOOL centerButtonnHidden = YES;
    if ([self.showCenterButton boolValue]) {
        for (UIView *childView in self.subviews) {
            if ([childView isMemberOfClass:[UIButton class]]) {
                centerButtonnHidden = childView.hidden?YES:NO;
                [childView setHidden:NO];
                break;
            }
        }
        if (!centerButtonnHidden && SCREEN_WIDTH > SCREEN_HEIGHT) {
            //当前是横屏
            CGFloat viewWidth = SCREEN_HEIGHT/5;
            int i = 0;
            for (UIView *view in self.subviews) {
                if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")])
                {
                    CGFloat x = 0.f;
                    if (i < 2) {
                        x = i * viewWidth;
                    } else {
                        x = (i + 1) * viewWidth;
                    }
                    [view setFrame:CGRectMake(x, 0.f, viewWidth, 49.f)];
                    i++;
                }
            }
        }
    }
}

- (void)setBadgeOfThirdButton:(BOOL)show
{
    if (show) {
        if (![self badgeView]) {
            UIView *badge = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 10.f, 10.f)];
            [UITools addMaskLayerToView:badge withRadius:5.f];
            [badge setBackgroundColor:FOREGROUND_COLOR];
            [self setBadgeView:badge];
        }
        
        if ([[self badgeView] superview]) {
            return;
        } else {
            int i = 0;
            UIView *thirdBtn;
            for (UIView *view in self.subviews) {
                if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")])
                {
                    if (i == 2) {
                        thirdBtn = view;
                        break;
                    }
                    i++;
                }
            }
            UIView *badge = [self badgeView];
            [badge setCenter:CGPointMake(Width(thirdBtn)/2 + 13.f, 13.f)];
            [thirdBtn addSubview:badge];
        }
    } else {
        if ([[self badgeView] superview]) {
            [[self badgeView] removeFromSuperview];
        }
    }
}

@end
