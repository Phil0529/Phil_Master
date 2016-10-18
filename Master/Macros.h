//
//  CommenHeader.h
//  OSLive
//
//  Created by zhangzq on 16/7/27.
//  Copyright © 2016年 zhangzq. All rights reserved.
//

//#define ZZQ

#define Phil

#ifndef CommenHeader_h
#define CommenHeader_h
#define APP_BUILDVER [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define APP_VERSION  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define IOS_VERSION [NSString stringWithFormat:@"iOS %.2f",[[[UIDevice currentDevice] systemVersion] floatValue]]
//屏幕分辨率 例640*960
#define Screen_Resolution [NSString stringWithFormat:@"%.0f*%.0f",[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height]
//设备操作系统型号和版本
#define OSTYPE [NSString  stringWithFormat:@"IOS%@",[UIDevice currentDevice].systemVersion]
//应用程序审核版本号
#define CVER_D     @"IOS_I01_01_01_001"
#define CHANNEL_D  @"00000000"
#define DEVICETOKEN @"deviceToken"
#define CID @"CID"
#define SID @"SID"
#define LOGINSTATUS @"LOGINSTATUS"
//上传图片的临时key
#define ALI_ACCESS_KEY @"AccessKeyId"
#define ALI_ACCESS_SECRET @"AccessKeySecret"
#define ALI_SECURITYTOKEN @"SecurityToken"
#define ALI_BUCKETNAME @"c"
//极光推送
#define JPush_Key @"381a66dfde712a8595723fbb"
#define Jpush_Secret @"2537c7335813ecf2b8259032"

//MOB短信验证码key与secret
#define MOB_SMS_KEY @"1228ecb6be5bc"
#define MOB_SMS_SECRET @"f314b851906be072d692ea91342ecd32"

//Mob 三方登录分享
#define MOB_Key @"1228f22c4be4d"
#define MOB_Secret @"54f5253e90e0cc374143b7a7c2ef7d77"

//QQ
#define QQ_KEY @"1104740207"
#define QQ_SECRET @"rpBzdBX7KLpvWuYf"
//WX
#define WeiXin_KEY @"wxee9c402442cf7884"
#define WeiXin_SECRET @"97babf6dbc5fcc14135c2efdeb73d461"
//WB
#define WeiBo_KEY @"783455158"
#define WeiBo_SECRET @"59338035859459e2607133420564cede"

#define baseTag 1000

#define Decode_Type @"software"
#define Media_Type @"livestream"

#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

//判断系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

//语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//判断设备
#define IS_SCREEN_55_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_47_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_4_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_35_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

//转换成浮点数
#define OBJ2FLOAT(v, s)  (s = (v == nil || v == [NSNull null]) ? 0.0 : [v doubleValue])
//转换成整型
#define OBJ2INT(v, s)  (s = (v == nil || v == [NSNull null]) ? 0 : [v integerValue])
//转换成字符串
#define OBJ2STR(v, s)  (s = (v == nil || v == [NSNull null]) ? @"" :v)
//消除nil字符串
#define NONNILSTR(v)    (v = (v == nil || v == [NSNull null]) ? @"" : v)
//消除nil的Nsnumber
#define NONNILNSNUMBER(v)   (v = (v == nil || v == [NSNull null]) ? [NSNumber numberWithInt:0] : v)

#define INT2STR(t,s) (s = [NSString stringWithFormat:@"%ld",t])
//测试数组
#define OBJArray(v,s) (s = (v == nil || v == [NSNull null]) ? @[] :v)

//测试字典
#define OBJDictionary(v,s) (s = (v == nil || v == [NSNull null]) ? @{} :v)

//判断是否为空字符串
#define ISEMPTYSTR(str)   (str == nil || [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])

#define ErrorReport(code,error) if(error){NSLog(@"Elf Trip ErrorCode %ld %@",(long)code,error)}

#define _WEAK_SELF __weak __typeof(self) wself = self;
#define _STRONG_SELF __strong __typeof(wself) strongSelf = wself;


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define MinX(v) CGRectGetMinX([v frame])
#define MinY(v) CGRectGetMinY([v frame])
#define MaxX(v) CGRectGetMaxX([v frame])
#define MaxY(v) CGRectGetMaxY([v frame])
#define MidX(v) CGRectGetMidX([v frame])
#define MidY(v) CGRectGetMidY([v frame])
#define Width(v) CGRectGetWidth([v frame])
#define Height(v) CGRectGetHeight([v frame])

//将size放大/缩小n倍
#define SIZE_SCALE(size,n) (CGSizeMake(size.width*n, size.height*n))

#define SAFE_RELEASE(x) [x release];x=nil  //release

//数组越界判定
#define ISINDEXINRANGE(idx,arr)\
(idx >=0 && idx < arr.count)

//字号
#define ODFontSize (IS_SCREEN_55_INCH?15.0:14.0)
//随屏幕大小改变字号
#define FontNumber(font) (SCREEN_WIDTH!=375?floor((font)*SCREEN_WIDTH/375):(font))

#define DSScale(value) ((value)*SCREEN_WIDTH/640)
//默认字体字号
#define FONT_DEFAULT(size) [UIFont systemFontOfSize:SCALING_FONT(size)]
#define FONT_BOLD(size) [UIFont boldSystemFontOfSize:SCALING_FONT(size)]

//字体---黑体
#define FONTHT_M(sizeF) [UIFont fontWithName:@"STHeitiSC-Medium" size:sizeF]
#define FONTHT_L(sizeF) [UIFont fontWithName:@"STHeitiSC-Light" size:sizeF]
//字体---
#define FONTHN_H(sizeF) [UIFont fontWithName:@"HelveticaNeue" size:sizeF]
#define FONTHN_HB(sizeF) [UIFont fontWithName:@"HelveticaNeue-Bold" size:sizeF]
//宋体
#define FONTST_B(sizeF) [UIFont fontWithName:@"STSongti-SC-Black" size:sizeF]
#define FONTST_R(sizeF) [UIFont fontWithName:@"STSongti-SC-Regular" size:sizeF]


//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

#define USER_DEFAULT [NSUserDefaults standardUserDefaults] //user Default

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]
//例如 imageView.image =  LOADIMAGE(@"文件名",@"png");

//定义UIImage对象
#define IMAGE(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

// degrees/radian functions
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

//viewWithTag
#define VIEWWITHTAG(_OBJECT, _TAG) [_OBJECT viewWithTag:_TAG]

#define SCALING_FACTOR_W(value) (!IS_SCREEN_47_INCH?(value)*SCREEN_WIDTH/375:(value))

#define SCALING_FACTOR_H(value) (!IS_SCREEN_47_INCH?(value)*SCREEN_HEIGHT/667:(value))

#define SCALING_FONT(value) (!IS_SCREEN_47_INCH?(value)*SCREEN_HEIGHT/667:(value))


//颜色
#define RGBACOLOR(aRed,aGreen,aBlue,aAlpha) [UIColor colorWithRed:(aRed)/255.0 green:(aGreen)/255.0 blue:(aBlue)/255.0 alpha:(aAlpha)]
#define RGBCOLOR(r,g,b) \
[UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0]

#define COLORFORRGBA(rgbValue, alpa) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:alpa]

#define COLORFORRGBa(rgbaValue) \
[UIColor colorWithRed:((float)((rgbaValue & 0xFF000000) >> 24))/255.0 \
green:((float)((rgbaValue & 0xFF0000) >> 16))/255.0 \
blue:((float)((rgbaValue & 0xFF00) >> 8))/255.0 \
alpha:((float)(rgbaValue & 0xFF))/255.0]
//颜色
#define COLORFORRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0f]
//默认颜色
#define MAINCOLOR [UIColor colorWithRed:251/255.0 green:191/255.0 blue:85/255.0 alpha:1]
#define GRAYDEFAULTCOLOR [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1]
#define MAINSECONDCOLOR [UIColor colorWithRed:74/255.0 green:192/255.0 blue:199/255.0 alpha:1]

//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

//防止block循环引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
//****做成单例****
#define ZZQSingleInstanceH  +(instancetype)shareInstance;

#define ZZQSingleInstanceM \
static id _singleinstance;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_singleinstance = [super allocWithZone:zone];\
});\
return _singleinstance;\
}\
+ (instancetype)shareInstance{\
\
static dispatch_once_t onceToken;\
\
dispatch_once(&onceToken, ^{\
\
_singleinstance = [[self alloc]init];\
\
});\
\
return _singleinstance;\
}\
-(id)copyWithZone:(NSZone *)zone{\
return _singleinstance;\
}

#define BeautifulScale 0.618

#endif /* CommenHeader_h */
