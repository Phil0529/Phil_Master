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

+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font height:(CGFloat)height width:(CGFloat)width{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, height)//限制最大的宽度和高度
                                       options:
                   NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
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

+ (NSMutableAttributedString *)injForecastfirString:(NSString *)firString
                                           firColor:(UIColor *)firColor
                                            firBold:(BOOL)firBold
                                          secString:(NSString *)secString
                                           secColor:(UIColor *)secColor
                                            secBold:(BOOL)secBold
                                               font:(CGFloat)font{
    NSMutableString *str = [[NSMutableString alloc] init];
    if(firString.length > 0){
        [str appendString:firString];
    }
    NSRange range1 = NSMakeRange(0, str.length);
    [str appendString:secString];
    NSRange range2;
    if (secString.length > 0) {
        range2 = NSMakeRange(range1.length, str.length - range1.length);
    }
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];

//    
    [attrStr addAttribute:NSForegroundColorAttributeName value:firColor range:range1];
    if (range2.length > 0) {
        [attrStr addAttribute:NSForegroundColorAttributeName value:secColor range:range2];
    }
    
    if (firBold) {
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:font] range:range1];
    }
    else if(secString.length > 0){
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:range1];
    }
    if (secBold) {
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:font] range:range2];
    }
    else if(secString.length > 0){
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:range2];
    }

    return attrStr;
}

+ (UIBarButtonItem *)addSaveBtn:(UIViewController *)viewController selector:(SEL)btnClick{
    UIBarButtonItem *navSave = [[UIBarButtonItem alloc] initWithTitle:@"save" style:UIBarButtonItemStylePlain target:viewController action:btnClick];
    [navSave setTintColor:[UIColor whiteColor]];
    [viewController.navigationItem setRightBarButtonItem:navSave];
    [navSave setEnabled:NO];
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightBtn setFrame:CGRectMake(0.f, 0.f, 32.f, 16.f)];
//    [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.f, 0.f, 0.f, -10.f)];
//    [rightBtn setTitleColor:COLORFORRGB(0xffffff) forState:UIControlStateNormal];
//    [rightBtn setTitleColor:COLORFORRGB(0x999999) forState:UIControlStateDisabled];
//    [rightBtn setTitle:LBLocalized(@"save") forState:UIControlStateNormal];
//    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:16.f]];
//    [rightBtn addTarget:viewController action:btnClick forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//    viewController.navigationItem.rightBarButtonItem = rightBarButton;
//    [rightBarButton setEnabled:NO];
    return navSave;
}

+ (void)addMaskLayerToView:(UIView *)view withRadius:(CGFloat)radius
{
    UIBezierPath *maskPath =
    [UIBezierPath bezierPathWithRoundedRect:view.bounds
                               cornerRadius:radius];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

+ (UIView *)lineView{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, 0.5f)];
    [lineView setBackgroundColor:LINE_COLOR];
    return lineView;
}

@end
