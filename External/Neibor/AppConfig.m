//
//  AppConfig.m
//  EZTV
//
//  Created by Lee, Bo on 16/2/22.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import "AppConfig.h"
#import "ConfigManger.h"
#import "EZColumnManager.h"

@interface AppConfig ()<RefreshDelegate>

@property (nonatomic,copy) void(^refrehsDone)();

@end

@implementation AppConfig
{
    NSInteger _refreshCount;
}

+ (AppConfig *)sharedConfig
{
    static AppConfig *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AppConfig alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self loadDefaultConfig];
    }
    return self;
}

- (BOOL)isDefault
{
    if ([_cmsPath isEqualToString:CMSBasePath]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)loadDefaultConfig
{
    _cmsPath = CMSBasePath;
    _appsPath = APPSBasePath;
    _userPath = UserBasePath;
    _oisPath = OISBasePath;
    _appName = LBLocalized(@"appname");
    _appColor = FOREGROUND_COLOR;
    _appCoin = LBLocalized(@"coin");
    _appCoinUnit = LBLocalized(@"mei");
    _appLogo = nil;
}

- (void)jumpToNeighbor:(NeighborItem *)item completion:(void (^)())completion
{
    _travelFrom = PROJECT_ID;
    self.refrehsDone = completion;
    if (item) {
        _cmsPath = item.cmsPath;
        _appsPath = item.appsPath;
        _userPath = item.userPath;
        _oisPath = item.oisPath;
        _appName = item.appName;
        _appLogo = item.appLogo;
        _appCoin = item.appCoin;
        _appCoinUnit = item.appCoinUnit;
        _appColor = [self colorWithHexString:item.appColor];
    } else {
        [self loadDefaultConfig];
    }
    
    _refreshCount = 3;
    [EZColumnManager sharedManager].delegate = self;
    [[EZColumnManager sharedManager] refreshColumnMap];
    [ConfigManger sharedManager].delegate = self;
    [[ConfigManger sharedManager] refreshTabMenuArray];
    [[ConfigManger sharedManager] refreshConfigMap];
    [[ConfigManger sharedManager] refreshTagArray];
}

- (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return FOREGROUND_COLOR;
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

- (void)managerDidFinishRefresh
{
    _refreshCount --;
    if (_refreshCount == 0) {
        _refreshCount = 3;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationAppDidTraveled object:nil];
        if (self.refrehsDone) {
            self.refrehsDone();
        }
    }
}

@end
