//
//  CardPageProtocol.h
//  NewPagedFlowViewDemo
//
//  Created by xhc on 10/17/16.
//  Copyright © 2016 robertcell.net. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CardPageView;

@protocol CardPageViewDataSource <NSObject>

@required

- (NSInteger)numberOfRowsInCardPageView:(CardPageView *)cardPageView;

- (UIView *)cellViewInCardPageView:(CardPageView *)cardPageView indexPath:(NSIndexPath *)indexPath;

@end

@protocol CardPageViewDelegate <NSObject>

@optional

- (void)cardPageView:(CardPageView *)cardPageView didSelectRowAtIndex:(NSIndexPath *)indexPath;

@end

