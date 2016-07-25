//
//  AnimtationTools.m
//  Master
//
//  Created by Phil Xhc on 7/18/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "AnimtationTools.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

typedef NS_ENUM(NSInteger, ViewStatus){
    ViewStatus_WillPop = 1,
    ViewStatus_Poping  = 2,
    ViewStatus_CompletePop = 3,
    ViewStatus_WillDismiss = 4,
    ViewStatus_Dismissing  = 5,
    ViewStatus_CompleteDismiss = 6,
};

#define CurrentTimeStamp [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSinceReferenceDate]]

@interface AnimtationTools()

@property (nonatomic,retain)      UIView *view;                  //需要弹出的视图

@property (nonatomic,retain)      NSString *key;                 //key

@property (nonatomic,strong)      UIView *transparentView;       //添加的透明视图

@property (nonatomic,assign)      float animationTime;           //动画时间

@property (nonatomic,assign)      ViewStatus status;             //动画运行的状态



@end

@implementation AnimtationTools

- (instancetype)init{
    if(self = [super init]){
        self.transparentView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH > SCREEN_HEIGHT ? SCREEN_WIDTH:SCREEN_HEIGHT, SCREEN_WIDTH > SCREEN_HEIGHT ? SCREEN_WIDTH:SCREEN_HEIGHT)];
        [self.transparentView setBackgroundColor:[UIColor greenColor]];
        [[UIApplication sharedApplication].keyWindow addSubview:self.transparentView];
    }
    return self;
}

- (void)addAnimationPopView:(UIView *)view duration:(float)time{
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    //其实设置初始状态.
    self.status = ViewStatus_WillPop;
    self.animationTime = time;
    self.view = view;
    
    CGPoint toLocation;
    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"position"];
    NSString *key = [NSStringFromClass([view class]) stringByAppendingString:CurrentTimeStamp];
    self.key = key;
    
    switch ([UIDevice currentDevice].orientation) {
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationPortrait:{
            toLocation = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT - view.frame.size.height/2);
            [self.transparentView setFrame:CGRectMake(0.f,0.f, SCREEN_WIDTH, SCREEN_HEIGHT-view.frame.size.height)];
        }
            break;
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:{
            toLocation = CGPointMake(SCREEN_WIDTH-view.frame.size.width/2, view.frame.size.height/2);
            [self.transparentView setFrame:CGRectMake(view.frame.size.height/2,0, SCREEN_WIDTH-view.frame.size.height,SCREEN_HEIGHT)];
        }
            break;
        default:{
            return;
        }
            break;
    }
    
    basicAnimation.toValue = [NSValue valueWithCGPoint:toLocation];
    //设置其他动画属性
    basicAnimation.duration = time > 0 ? time : 0.3f;
    //运行一次是否移除动画
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.delegate = self;
    basicAnimation.fillMode = kCAFillModeForwards;
    //存储当前位置在动画结束后使用
    [basicAnimation setValue:[NSValue valueWithCGPoint:toLocation] forKey:key];
    
    [view.layer addAnimation:basicAnimation forKey:key];
}

- (void)addAnimationDismissView:(UIView *)view duration:(float)time{
    self.status = ViewStatus_WillDismiss;
    self.animationTime = time;
    NSString *key = [NSStringFromClass([view class]) stringByAppendingString:CurrentTimeStamp];
    self.key = key;
    CGPoint toLocation;
    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"position"];
    
    switch ([UIDevice currentDevice].orientation) {
        case UIDeviceOrientationPortrait:{
            toLocation = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT + view.frame.size.height/2);
        }
            break;
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:{
            toLocation = CGPointMake(SCREEN_WIDTH+view.frame.size.width/2, view.frame.size.height/2);
        }
            break;
        default:{
            return;
        }
            break;
    }
    basicAnimation.toValue = [NSValue valueWithCGPoint:toLocation];
    basicAnimation.duration = time > 0 ? time : 0.3f;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.delegate= self;
    [basicAnimation setValue:[NSValue valueWithCGPoint:toLocation] forKey:key];
    basicAnimation.fillMode = kCAFillModeForwards;
    
    [view.layer addAnimation:basicAnimation forKey:key];
}

#pragma mark -
#pragma mark CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim{
    //动画开始,若是弹出
    if (self.status == ViewStatus_WillPop) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        tap.enabled = NO;
        
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            [self addAnimationDismissView:self.view duration:self.animationTime];
        }];
        [self.transparentView addGestureRecognizer:tap];
        if([self.delegate respondsToSelector:@selector(viewWillPop)]){
            [self.delegate viewWillPop];
        }
    }
    //动画开始,若是消失
    else if(self.status == ViewStatus_WillDismiss){
        UITapGestureRecognizer *tap = [self.transparentView.gestureRecognizers firstObject];
        tap.enabled = NO;
        if ([self.delegate respondsToSelector:@selector(viewWillDismiss)]) {
            [self.delegate viewWillDismiss];
        }
    }
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [CATransaction begin];                      //开启事务
    [CATransaction setDisableActions:YES];      //禁用隐式动画
    self.view.layer.position = [[anim valueForKey:self.key] CGPointValue];      //固定position
    [CATransaction commit];                                                     //提交事务
    [self.view.layer removeAnimationForKey:self.key];
    
    if (self.status == ViewStatus_WillPop) {
        self.status = ViewStatus_CompletePop;
        if([self.delegate respondsToSelector:@selector(viewDidPop)]){
            [self.delegate viewDidPop];
        }
    }
    else if(self.status == ViewStatus_WillDismiss){
        self.status = ViewStatus_CompleteDismiss;
        [self.transparentView removeFromSuperview];
        self.transparentView = nil;
        if([self.delegate respondsToSelector:@selector(viewDidDismiss)]){
            [self.delegate viewDidDismiss];
        }
    }
    UITapGestureRecognizer *tap = [self.transparentView.gestureRecognizers firstObject];
    tap.enabled = YES;
}
@end
