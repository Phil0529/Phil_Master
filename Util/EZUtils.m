//
//  EZUtils.m
//  EZTV
//
//  Created by Sunni on 15/6/24.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "EZUtils.h"
#import <CVKHierarchySearcher/CVKHierarchySearcher.h>
#import <MBProgressHUD.h>
#import "CoinQuery.h"

@implementation EZUtils

+ (void)presentSnsIconSheetView:(NSString *)title content:(NSString *)content link:(NSString *)link image:(UIImage *)image imageUrl:(NSString *)imageUrl controller:(UIViewController *)controller delegate:(id <UMSocialUIDelegate>)delegate
{
    if (!controller) {
        return;
    }
    
    NSString *shareTitle = ISEMPTYSTR(title) ? @"name" : title;
    NSString *shareContent = ISEMPTYSTR(content) ? shareTitle : content;
    
    if (!ISEMPTYSTR(imageUrl)) {
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:imageUrl];
    }
    
    //微信好友
    [[UMSocialData defaultData].extConfig.wechatSessionData setTitle:shareTitle];
    [[UMSocialData defaultData].extConfig.wechatSessionData setUrl:link];
    [[UMSocialData defaultData].extConfig.wechatSessionData setShareText:shareContent];
    
    //微信朋友圈
    [[UMSocialData defaultData].extConfig.wechatTimelineData setTitle:shareTitle];
    [[UMSocialData defaultData].extConfig.wechatTimelineData setUrl:link];
    [[UMSocialData defaultData].extConfig.wechatTimelineData setShareText:shareContent];
    
    //QQ好友
    [[UMSocialData defaultData].extConfig.qqData setTitle:shareTitle];
    [[UMSocialData defaultData].extConfig.qqData setUrl:link];
    [[UMSocialData defaultData].extConfig.qqData setShareText:shareContent];
    
    //QQ空间
    [[UMSocialData defaultData].extConfig.qzoneData setTitle:shareTitle];
    [[UMSocialData defaultData].extConfig.qzoneData setUrl:link];
    [[UMSocialData defaultData].extConfig.qzoneData setShareText:shareContent];
    
#ifdef SINA_WB
    //微博
    [[UMSocialData defaultData].extConfig.sinaData setShareText:[shareTitle stringByAppendingString:link]];
    NSArray *shareSns = @[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline, UMShareToSina];
#else
    NSArray *shareSns = @[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline];
#endif
    
    [UMSocialSnsService presentSnsIconSheetView:controller
                                         appKey:UMENG_APPKEY
                                      shareText:nil
                                     shareImage:image
                                shareToSnsNames:shareSns
                                       delegate:delegate];
}

+ (CAGradientLayer *)gradientLayerWithFrame:(CGRect)frame initColor:(UIColor *)iColor finalColor:(UIColor *)fColor
{
    // Create gradient
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    // Set colors
    gradient.colors = [NSArray arrayWithObjects:
                       (id)iColor.CGColor,
                       (id)fColor.CGColor,
                       nil];
    
    [gradient setFrame:frame];
    
    return gradient;
}

+ (CAGradientLayer*)lightToDarkLayerWithFrame:(CGRect)frame
{
    // Create colors
    UIColor *darkOp = [UIColor colorWithWhite:0.f alpha:0.9];
    UIColor *lightOp = [UIColor colorWithWhite:0.f alpha:0.0];
    
    // Create gradient
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    // Set colors
    gradient.colors = [NSArray arrayWithObjects:
                       (id)lightOp.CGColor,
                       (id)darkOp.CGColor,
                       nil];
    
    [gradient setFrame:frame];
    
    // Shadow
//    gradient.shadowOffset = CGSizeMake(0.0f, 1.0f);
//    gradient.shadowColor = [UIColor blackColor].CGColor;
//    gradient.shadowOpacity = 0.4;
//    gradient.shadowRadius = 2;
    
    //    // Other options
    //    gradient.borderWidth = 0.5f;
    //    gradient.borderColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0].CGColor;
    //    gradient.cornerRadius = 10;
    
    return gradient;
}

+ (CAGradientLayer*)darkToLightLayerWithFrame:(CGRect)frame
{
    // Create colors
    UIColor *darkOp = [UIColor colorWithWhite:0.f alpha:0.9];
    UIColor *lightOp = [UIColor colorWithWhite:0.f alpha:0.0];
    
    // Create gradient
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    // Set colors
    gradient.colors = [NSArray arrayWithObjects:
                       (id)darkOp.CGColor,
                       (id)lightOp.CGColor,
                       nil];
    [gradient setFrame:frame];
    
    // Shadow
//    gradient.shadowOffset = CGSizeMake(0.0f, -2.0f);
//    gradient.shadowColor = [UIColor blackColor].CGColor;
//    gradient.shadowOpacity = 0.4;
//    gradient.shadowRadius = 2;
    
    //    // Other options
    //    gradient.borderWidth = 0.5f;
    //    gradient.borderColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0].CGColor;
    //    gradient.cornerRadius = 10;
    
    return gradient;
}

+ (NSString *)combineUrl:(NSString *)url params:(NSDictionary *)params
{
    NSRange queryRange = [url rangeOfString:@"?"];
    if (queryRange.length > 0) {
        NSMutableString *result = [[NSMutableString alloc] initWithString:url];
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [result appendFormat:@"&%@=%@", (NSString *)key, (NSString *)obj];
        }];
        return result;
    } else {
        NSMutableString *result = [[NSMutableString alloc] initWithFormat:@"%@?",url];
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [result appendFormat:@"%@=%@&", (NSString *)key, (NSString *)obj];
        }];
        return [result substringToIndex:result.length - 1];
    }
}

+ (void)showNotifyMsg:(NSString *)msg inView:(UIView *)view dismissed:(void (^)(void))dismissed
{
    CVKHierarchySearcher *searcher = [[CVKHierarchySearcher alloc] init];
    UIView *displayView = view;
    if (searcher.topmostViewController.view) {
        displayView = searcher.topmostViewController.view;
    }
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:displayView animated:YES];
    [HUD setMode:MBProgressHUDModeText];
    [HUD setDimBackground:YES];
    [HUD setDetailsLabelFont:[UIFont boldSystemFontOfSize:14.f]];
    [HUD setDetailsLabelText:msg];
    [HUD setCompletionBlock:dismissed];
    [HUD hide:YES afterDelay:1.2f];
}

@end
