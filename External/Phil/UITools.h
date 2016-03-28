//
//  UITools.h
//  EZTV
//
//  Created by Phil Xhc on 16/1/18.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UITools : NSObject

+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font;

+ (NSArray *)locationOfLabel:(UILabel *)firstLabel secondLabel:(UILabel *)secondLabel string:(NSString *)string;

+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font height:(CGFloat)height width:(CGFloat)width;

+ (UIViewController *)getCurrentVC;

@end
