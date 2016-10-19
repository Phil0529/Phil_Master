//
//  CardPageView.h
//  NewPagedFlowViewDemo
//
//  Created by Phil Xhc on 8/15/16.
//  Copyright © 2016 robertcell.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardPageProtocol.h"
#import "CardPageCell.h"

@interface CardPageView : UIView

@property (nonatomic,assign) CGFloat scaleWidth;  //default 0.2f 大图和小图宽度比例
//
@property (nonatomic,assign) CGFloat scaleHeight; //default 0.2f 大图和小图高度比例
//
@property (nonatomic,assign) CGFloat cellSpace;   //default 20.f  大图和小图间距
//
@property (nonatomic,assign) CGSize itemSize;
//
@property (nonatomic, weak) id<CardPageViewDelegate> delegate;
//
@property (nonatomic,weak) id<CardPageViewDataSource> dataSource;


//
//- (id)initWithFrame:(CGRect)frame;
//
//- (void)setAdsWithImages:(NSArray *)imageArray;

- (CardPageCell *)dequeueReusableCellWithIndex:(NSIndexPath *)indexPath;
//
//- (void)reloadData;

@end

