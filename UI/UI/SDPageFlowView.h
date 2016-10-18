//
//  SDPageFlowView.h
//  NewPagedFlowViewDemo
//
//  Created by Phil Xhc on 8/12/16.
//  Copyright © 2016 robertcell.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDPageFlowView : UIView

//+ (void)setCellClass:(Class )cellClass;

@property (nonatomic, strong) UIImage *placeHolderImg;

@property (nonatomic, assign) CGSize itemSize;

- (id)initWithFrame:(CGRect)frame itemSize:(CGSize)itemSize;

- (void)setAdsWithImages:(NSArray *)imageArray;

@end
