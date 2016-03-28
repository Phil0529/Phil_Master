//
//  Parameter.m
//  SWMOP
//
//  Created by guoziyi on 14-2-25.
//  Copyright (c) 2014年 husl. All rights reserved.
//
#import "TMCache.h"
#import "MopLog.h"
#import "Parameter.h"

static NSString *gParameterKey = @"Parameter7s.key";
static NSString *gParameterFileName = @"Parameter71.data";

@implementation Parameter
{
    NSMutableDictionary *mDictionary;
}

// 单例模式
+ (Parameter *)sharedInstance
{
    static dispatch_once_t once;
    static Parameter *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[Parameter alloc] init];
    });
    
    return sharedInstance;
}

- (id) init
{
    self = [super init];
    if(self)
    {
        mDictionary = [[TMCache sharedCache] objectForKey:gParameterKey];
        if(mDictionary == nil)
        {
            mDictionary = [[NSMutableDictionary alloc] init];

//          //手机别名： 用户定义的名称
//          NSString* userPhoneName = [[UIDevice currentDevice] name];
//          //MopLogV(@"手机别名: %@", userPhoneName);
//          //设备名称
//          NSString* deviceName = [[UIDevice currentDevice] systemName];
//          //MopLogV(@"设备名称: %@",deviceName );
//          //手机系统版本
//          NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
//          //MopLogV(@"手机系统版本: %@", phoneVersion);
//          //手机型号
//          NSString* phoneModel = [[UIDevice currentDevice] model];
//          //MopLogV(@"手机型号: %@",phoneModel );
//          //地方型号  （国际化区域名称）
//          NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel];
//          //MopLogV(@"国际化区域名称: %@",localPhoneModel );
//
//          NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//          // 当前应用名称
//          NSString *appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
//          //MopLogV(@"当前应用名称：%@",appCurName);
//          // 当前应用软件版本  比如：1.0.1
//          NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//          //MopLogV(@"当前应用软件版本:%@",appCurVersion);
//          // 当前应用版本号码   int类型
//          NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
//          //MopLogV(@"当前应用版本号码：%@",appCurVersionNum);

            [mDictionary setObject:@"swmop" forKey:ParamProjectId];

            //终端类型 1-STB， 2-PC， 3-Android-Phone， 4-Android-Pad， 5-iOS-Phone， 6-iOS-Pad
            NSString *terminalType = @"5";
            [mDictionary setObject:terminalType forKey:ParamTerminalType];
            
            //手机序列号
            NSString* terminalId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
            [mDictionary setObject:terminalId forKey:ParamTerminalId];
            
            [mDictionary setObject:@"sunniwell" forKey:ParamUser];
            [mDictionary setObject:@"888888" forKey:ParamPassword];
            [mDictionary setObject:@"true" forKey:ParamAuthenEnable];
            [mDictionary setObject:@"true" forKey:ParamAdEnable];
            
            [mDictionary setObject:@"08-ED-23-4R-WE-3R" forKey:ParamMac];
            [mDictionary setObject:@"4" forKey:ParamNetMode];
//            [mDictionary setObject:@"false" forKey:ParamAutoLogin];
//            [mDictionary setObject:@"false" forKey:ParamRememberPassword];
            [mDictionary setObject:@"http://apk.directepg.info/tv/sunniwell_8940/config.ini" forKey:ParamUpgradeUrl];
            
            [self loadDefaultServerSetting];

            [mDictionary setObject:@"p2p_proxy_hls" forKey:ParamProtocol];
            
            // 默认为系统语言
            NSString *language = @"zh";
            NSArray *languages = [NSLocale preferredLanguages];
            NSString *currentLanguage = [languages objectAtIndex:0];
            // 中文简体  zh_Hans  中文繁体 zh_Hant 英文 en
            if([currentLanguage isEqualToString:@"zh-Hans"])
            {
                language = @"zh";
            }
            [mDictionary setObject:language forKey:ParamLanguage];
        }


        
        //收费体验观看4分钟
        [mDictionary setObject:@"240" forKey:ParamPreview];
        //更新硬件以及系统版本
        NSString *hardVersion = [NSString stringWithFormat:@"%@ %@ %@",
                                 [[DeviceGlobal sharedDevice] hardVersion],
                                 [[UIDevice currentDevice] systemName],
                                 [[UIDevice currentDevice] systemVersion]];
        [mDictionary setObject:hardVersion forKey:ParamHardVersion];
    
        //更新安装软件的版本
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSString *appBuild = [infoDictionary objectForKey:@"CFBundleVersion"];
        NSString *softVersion = [NSString stringWithFormat:@"%@ %@(%@)", appName, appVersion, appBuild];
        [mDictionary setObject:softVersion forKey:ParamSoftVersion];
        
        [self save];
        MopLogD(@"Parameter initialized: %@", mDictionary);
    }
    return self;
}

// 获取参数

- (NSString *)getValueOfKey:(NSString *)key
{
    if(mDictionary)
    {
        return [mDictionary objectForKey:key];
    }
    return nil;
}

// 设置参数
- (void)setValue:(NSString *)value forKey:(NSString *)key
{
    if(mDictionary)
    {
        [mDictionary setObject:value forKey:key];
    }
}

- (BOOL)loadDefaultServerSetting
{
    NSString *paramOis = [mDictionary objectForKey:ParamOis];
    NSString *paramEpg = [mDictionary objectForKey:ParamEpg];
    if ([paramOis rangeOfString:@"ois.joygo.com:5001"].length == 0 || ![paramEpg isEqualToString:@"appfuzhou"])
    {
        [mDictionary setObject:@"ois.joygo.com:5001" forKey:ParamOis];
        [mDictionary setObject:@"epgs.joygo.com:8080" forKey:ParamEpgs];
        [mDictionary setObject:@"appfuzhou" forKey:ParamEpg];
        return YES;
    }
    return NO;
}

// 清除参数缓存
- (void)clearCache
{
    [mDictionary setObject:@"SWMOP" forKey:ParamProjectId];
    [mDictionary setObject:@"sunniwell" forKey:ParamUser];
    [mDictionary setObject:@"888888" forKey:ParamPassword];
    [mDictionary setObject:@"zh" forKey:ParamLanguage];
    [self save];
}

// 保存参数
- (void)save
{
    if(mDictionary != nil)
    {
        [[TMCache sharedCache] setObject:mDictionary forKey:gParameterKey];
    }
}

@end
