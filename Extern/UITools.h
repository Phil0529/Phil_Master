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

+ (NSMutableAttributedString *)injForecastfirString:(NSString *)firString
                                           firColor:(UIColor *)firColor
                                            firBold:(BOOL)firBold
                                          secString:(NSString *)secString
                                           secColor:(UIColor *)secColor
                                            secBold:(BOOL)secBold
                                               font:(CGFloat)font;

+ (UIBarButtonItem *)addSaveBtn:(UIViewController *)viewController selector:(SEL)btnClick;

+ (void)addMaskLayerToView:(UIView *)view withRadius:(CGFloat)radius;

+ (UIView *)lineView;

@end
