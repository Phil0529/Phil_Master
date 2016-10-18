//
//  NonWindowAnimationTool.m
//  OSLive
//
//  Created by xhc on 9/26/16.
//  Copyright © 2016 gltrip. All rights reserved.
//

#import "NonWindowAnimationTool.h"

@interface NonWindowAnimationTool()<CAAnimationDelegate>

@property (nonatomic,retain)      UIView *view;                  //需要弹出的视图

@property (nonatomic,retain)      NSString *key;                 //key

@property (nonatomic,strong)      UIView *transparentView;       //添加的透明视图

@property (nonatomic,assign)      float animationTime;           //动画时间

@property (nonatomic,assign)      ViewStatus status;             //动画运行的状态

@property (nonatomic,assign)      AnimationOrientation orientation;   //动画方向

@end


@implementation NonWindowAnimationTool

- (instancetype)init{
    if (self = [super init]) {
        _disappeared = YES;
        _appeared = NO;
    }
    return self;
}

- (void)addAnimationPopView:(UIView *)view targetSuperView:(UIView *)targetSuperView duration:(float)time orientation:(AnimationOrientation)orientation{
    _disappeared = NO;
    [targetSuperView addSubview:view];
    //其实设置初始状态.
    self.status = ViewStatus_WillPop;
    self.animationTime = time;
    self.view = view;
    self.orientation = orientation;
    
    CGPoint toLocation;
    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"position"];
    NSString *key = [NSStringFromClass([view class]) stringByAppendingString:CurrentTimeStamp];
    self.key = key;
    
    
    switch (self.orientation) {
        case AnimationOrientation_Top:{
            [view setCenter:CGPointMake(view.frame.origin.x + view.frame.size.width/2, -view.frame.size.height/2)];
            toLocation = CGPointMake(view.frame.origin.x + view.frame.size.width/2, view.frame.size.height/2);
        }
            break;
        case AnimationOrientation_Left:{
            [view setCenter:CGPointMake(-view.frame.size.width/2, view.frame.origin.y + view.frame.size.height/2)];
            toLocation = CGPointMake(view.frame.size.width/2,view.frame.origin.y + view.frame.size.height/2);
        }
            break;
        case AnimationOrientation_Right:{
            [view setCenter:CGPointMake(SCREEN_WIDTH + view.frame.size.width/2,view.frame.origin.y + view.frame.size.height/2)];
            toLocation = CGPointMake(SCREEN_WIDTH - view.frame.size.width/2,view.frame.origin.y + view.frame.size.height/2);
        }
            break;
        case AnimationOrientation_Bottom:
        default:{
            [view setCenter:CGPointMake(view.frame.origin.x + view.frame.size.width/2,SCREEN_HEIGHT + view.frame.size.height/2)];
            toLocation = CGPointMake(view.frame.origin.x + view.frame.size.width/2, SCREEN_HEIGHT - view.frame.size.height/2);
        }
            break;
    }
    
    switch ([UIDevice currentDevice].orientation) {
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationPortrait:{
            [self.transparentView setFrame:CGRectMake(0.f,0.f, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }
            break;
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:{
            [self.transparentView setFrame:CGRectMake(view.frame.size.height/2,0, SCREEN_WIDTH,SCREEN_HEIGHT)];
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

- (void)addAnimationDismissView:(UIView *)view duration:(float)time orientation:(AnimationOrientation)orientation{
    _appeared = NO;
    self.status = ViewStatus_WillDismiss;
    self.orientation = orientation;
    self.animationTime = time;
    NSString *key = [NSStringFromClass([view class]) stringByAppendingString:CurrentTimeStamp];
    self.key = key;
    CGPoint toLocation;
    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"position"];
    
    switch (self.orientation) {
        case AnimationOrientation_Top:{
            toLocation = CGPointMake(view.frame.origin.x + view.frame.size.width/2, -view.frame.size.height/2);
        }
            break;
        case AnimationOrientation_Left:{
            toLocation = CGPointMake(-view.frame.size.width/2,view.frame.origin.y + view.frame.size.height/2);
        }
            break;
        case AnimationOrientation_Right:{
            toLocation = CGPointMake(SCREEN_WIDTH + view.frame.size.width/2,view.frame.origin.y + view.frame.size.height/2);
        }
            break;
        case AnimationOrientation_Bottom:
        default:{
            toLocation = CGPointMake(view.frame.origin.x + view.frame.size.width/2, SCREEN_HEIGHT + view.frame.size.height/2);
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
    self.view.userInteractionEnabled = NO;
    //动画开始,若是弹出
    if (self.status == ViewStatus_WillPop) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        tap.enabled = NO;
        
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            [self addAnimationDismissView:self.view duration:self.animationTime orientation:self.orientation];
        }];
        [self.transparentView addGestureRecognizer:tap];
        if(self.delegate && [self.delegate respondsToSelector:@selector(viewWillPop:)]){
            [self.delegate viewWillPop:self.view];
        }
    }
    //动画开始,若是消失
    else if(self.status == ViewStatus_WillDismiss){
        UITapGestureRecognizer *tap = [self.transparentView.gestureRecognizers firstObject];
        tap.enabled = NO;
        if (self.delegate && [self.delegate respondsToSelector:@selector(viewWillDismiss:)]) {
            [self.delegate viewWillDismiss:self.view];
        }
    }
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.view.userInteractionEnabled = YES;
    [CATransaction begin];                      //开启事务
    [CATransaction setDisableActions:YES];      //禁用隐式动画
    self.view.layer.position = [[anim valueForKey:self.key] CGPointValue];      //固定position
    [CATransaction commit];                                                     //提交事务
    [self.view.layer removeAnimationForKey:self.key];
    
    if (self.status == ViewStatus_WillPop) {
        self.status = ViewStatus_CompletePop;
        _appeared = YES;
        if(self.delegate && [self.delegate respondsToSelector:@selector(viewDidPop:)]){
            [self.delegate viewDidPop:self.view];
        }
    }
    else if(self.status == ViewStatus_WillDismiss){
        _disappeared = YES;
        self.status = ViewStatus_CompleteDismiss;
        [self.transparentView removeFromSuperview];
        self.transparentView = nil;
        [self.view removeFromSuperview];
        if(self.delegate && [self.delegate respondsToSelector:@selector(viewDidDismiss:)]){
            [self.delegate viewDidDismiss:self.view];
        }
        self.view = nil;
    }
    UITapGestureRecognizer *tap = [self.transparentView.gestureRecognizers firstObject];
    tap.enabled = YES;
}


@end
