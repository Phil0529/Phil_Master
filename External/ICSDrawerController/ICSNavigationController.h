//
//  ICSNavigationController.h
//  ICSCustomize
//
//  Created by Lee, Bo on 15/3/18.
//  Copyright (c) 2015年 Sunniwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"

@interface ICSNavigationController : UINavigationController<ICSDrawerControllerChild, ICSDrawerControllerPresenting>

@property(nonatomic, weak) ICSDrawerController *drawer;

@end
