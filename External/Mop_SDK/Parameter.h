//
//  Parameter.h
//  SWMOP
//
//  Created by guoziyi on 14-2-25.
//  Copyright (c) 2014年 husl. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString* const ParamLanguage = @"ParameterLanguage"; // 当前语言
static NSString* const ParamProjectId = @"ParameterProjectId"; // 项目号
static NSString* const ParamTerminalId = @"ParameterTerminalId"; // STB就是serial序列号 移动终端就是 MAC 地址
static NSString* const ParamTerminalType = @"ParameterTerminalType";// 终端类型 1-STB， 2-PC， 3-Android-Phone， 4-Android-Pad， 5-iOS-Phone， 6-iOS-Pad
static NSString* const ParamUser = @"ParameterUser"; // 默认用户名
static NSString* const ParamPassword = @"ParameterPassword"; // 默认密码
static NSString* const ParamAuthenEnable = @"ParameterAuthenEnable"; // 是否需要鉴权
static NSString* const ParamAdEnable = @"ParameterAdEnable"; // 是否需要广告
static NSString* const ParamMac = @"ParameterMac"; // mac 地址
static NSString* const ParamNetMode = @"ParameterNetMode"; // 网络模式
static NSString* const ParamSoftVersion = @"ParameterSoftVersion"; // 软件版本
static NSString* const ParamHardVersion = @"ParameterHardVersion"; // 硬件版本
//static NSString* const ParamAutoLogin = @"ParameterAutoLogin"; // 是否自动登录
//static NSString* const ParamRememberPassword = @"ParameterRememberPassword"; // 是否记住密码
static NSString* const ParamUpgradeUrl = @"ParameterUpgradeUrl";  // 默认升级地址
static NSString* const ParamOis = @"ParameterOis";  // ois 地址
static NSString* const ParamEpgs = @"ParameterEpgs"; // epgs 地址
static NSString* const ParamProtocol = @"ParameterProtocol"; // 播放协议，p2p 或 hls
static NSString* const ParamEpg = @"ParameterEpg"; // 默认EPG模版
static NSString* const ParamPreview = @"ParameterPreview"; // 默认预览时间 单位 S

@interface Parameter : NSObject

// 单例模式
+ (Parameter *)sharedInstance;

// 获取参数值
- (NSString *)getValueOfKey:(NSString*)key;

// 设置参数
- (void)setValue:(NSString *)value forKey:(NSString *)key;

// 清除参数缓存
- (void)clearCache;

// 保存参数到文件
- (void)save;

//载入默认服务器设置
- (BOOL)loadDefaultServerSetting;

@end
