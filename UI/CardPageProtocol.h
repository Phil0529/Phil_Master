//
//  CardPageProtocol.h
//  NewPagedFlowViewDemo
//
//  Created by xhc on 10/17/16.
//  Copyright © 2016 robertcell.net. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CardPageView;

@protocol CardPageViewProtocol <NSObject>

@required

- (NSInteger)numberOfRowsInCardPageView:(CardPageView *)cardPageView;

- (UIView *)cellViewInCardPageView:(CardPageView *)cardPageView index:(NSInteger)index;

@optional

- (void)cardPageView:(CardPageView *)cardPageView didSelectRowAtIndex:(NSInteger)index;

@end

