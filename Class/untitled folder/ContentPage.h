//
//  ContentPage.h
//  EZTV
//
//  Created by Lee, Bo on 15/10/19.
//  Copyright © 2015年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentPageProtocol.h"
#import "EZColumnItem.h"

@interface ContentPage: NSObject

+ (UIView<ContentPageProtocol> *)contentPageWithFrame:(CGRect)frame columnItem:(EZColumnItem *)item delegate:(id<ContentPageDelegate>)delegate;

@end
