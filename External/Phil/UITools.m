//
//  UITools.m
//  EZTV
//
//  Created by Phil Xhc on 16/1/18.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import "UITools.h"

@implementation UITools

+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 136.f, SCREEN_HEIGHT)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传入的字体字典,
                                       context:nil];
    return rect.size;
}

+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font height:(CGFloat)height width:(CGFloat)width
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, height)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传入的字体字典,
                                       context:nil];
    return rect.size;

}

+ (NSArray *)locationOfLabel:(UILabel *)firstLabel secondLabel:(UILabel *)secondLabel string:(NSString *)string{
    CGRect firstRect = firstLabel.frame;
    CGRect secondRect = secondLabel.frame;
    NSMutableArray *locaArr = [[NSMutableArray alloc] initWithCapacity:2];
    
    UIFont *font = firstLabel.font;
    CGFloat fontHeight = font.pointSize;
    
    CGSize size = [UITools sizeWithString:string font:font height:fontHeight width:1000.f];
    
    if (size.width > firstRect.size.width) {
        NSInteger loca = 1;
        NSString *firstSubString = [string substringToIndex:loca];
        CGSize firstSize = [UITools sizeWithString:firstSubString font:font height:fontHeight width:1000.f];
        
        for (;firstRect.size.width - firstSize.width >= (fontHeight+1.f) && loca <= string.length - 1;loca++) {
            NSString *subString = [string substringToIndex:loca];
            
            firstSize = [UITools sizeWithString:subString font:font height:fontHeight width:1000.f];
        }
        NSNumber *firstLoca = [NSNumber numberWithInteger:loca-1];
        [locaArr addObject:firstLoca];
        
        NSString *secondString = [string substringFromIndex:[firstLoca integerValue]];
        loca = 1;
        NSString *secondSubString = [secondString substringToIndex:loca];
        CGSize secondSize = [UITools sizeWithString:secondSubString font:font height:fontHeight width:1000.f];
        for (; secondRect.size.width - secondSize.width >= (fontHeight+1.f) && loca <= secondString.length - 1; loca ++) {
            NSString *subString = [secondString substringToIndex:loca];
            secondSize = [UITools sizeWithString:subString font:font height:fontHeight width:1000.f];
        }
        NSNumber *secondLoca = [NSNumber numberWithInteger:loca-1];
        [locaArr addObject:secondLoca];
        
    }
    return locaArr;
}

+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}




@end
