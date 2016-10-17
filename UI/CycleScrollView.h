//
//  CycleScrollView.h
//  NewPagedFlowViewDemo
//
//  Created by Phil Xhc on 8/10/16.
//  Copyright © 2016 robertcell.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CycleScrollViewDelegate;



@interface CycleScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, weak) id<CycleScrollViewDelegate> delegate;

@end


@protocol CycleScrollViewDelegate <NSObject>

- (void)cycleScrollView:(CycleScrollView *)cycleScrollView didSelectImageView:(NSInteger)index;

@end
