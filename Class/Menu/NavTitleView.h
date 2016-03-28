//
//  NavTitleView.h
//  Master
//
//  Created by Phil Xhc on 3/24/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavTitleView : UIView

@property (nonatomic, strong) UILabel *titleLbl;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;

@end
