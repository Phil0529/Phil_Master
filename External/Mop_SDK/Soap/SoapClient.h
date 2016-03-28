//
//  SoapClient.h
//  SWMOP
//
//  Created by guoziyi on 14-2-25.
//  Copyright (c) 2014年 husl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSHttpRequest.h"
#import "AuthItem.h"
#import "UserItem.h"
#import "AssetItem.h"
#import "SubscribeItem.h"
#import "VideoCardItem.h"

//0-- 表示获取所有的订购记录, 1-- 表示获取有效未过期的订购记录, 2-- 表示获取过期失效的订购记录
typedef NS_ENUM(NSInteger, SoapSubscribeType)
{
    SubscribeAll = 0,
    SubscribeActive = 1,
    SubscribeDeactive = 2
};

@protocol SoapNmpDelegate <NSObject>

/**
 * OIS Soap 登录成功回调
 */
- (void)onLoginSuccess;

/**
 * OIS Soap 登录失败回调
 * @param code -登录失败错误码
 */
- (void)onLoginFailed:(NSInteger)code;

/**
 * 网管指令————获取某个参数
 * @param key - 参数名
 */
- (void)onGetParam:(NSString*)key;

/**
 * 网管指令————获取所有参数回调
 */
- (void)onGetAllParam;

/**
 * 网管指令————设置参数回调
 * @param key - 参数名
 * @param value - 参数值
 */
- (void)onSetParam:(NSString*)key Value:(NSString*)value;

/**
 * 网管指令————保存参数回调
 */
- (void)onSaveParam;


/**
 * 网管指令————打开url回调
 * @param url
 */
- (void)onOpenUrl:(NSString*)url;

/**
 * 网管指令————跑马灯消息
 * @param type - 跑马灯消息类型，page-页面跑马灯, video-视频跑马灯
 * @param title - 标题
 * @param content - 内容
 * @param fontSize - 字号
 * @param fontColor - 字体颜色 表达方式：#RRGGBB， 为空表示没有颜色
 * @param bgColor - 背景颜色 表达方式：#RRGGBB， 为空表示没有颜色
 * @param transparent - 背景颜色 表达方式：#RRGGBB， 为空表示没有颜色
 * @param speed - 滚动速度（0-10之间，速度递增）
 * @param loop - 循环次数(-1表示无限循环滚动下去，这个时候决定什么时候终止滚动取决于时长)
 * @param duration - 时长，消息显示的时长，超过时长则不再显示，单位s（注意时长跟循环次数的配合，默认以循环次数为准，假设循环次数为-1则时长发挥作用
 * @param priority - 优先级，值越大优先级越高
 */
- (void)onMarquee:(NSString*)type Title:(NSString*)title Content:(NSString*)content
          FontSize:(NSInteger)fontSize FontColor:(NSString*)fontColor BgColor:(NSString*)bgColor
       Transparent:(NSInteger)transparent Speed:(NSInteger)speed Loop:(NSInteger)loop
          Duration:(NSInteger)duration Priority:(NSInteger)priority;

/**
 * 网管指令————弹框消息
 * @param title - 标题
 * @param content - 内容
 */
- (void)onAlertmsg:(NSString*)title Content:(NSString*)content;

/**
 * 网管指令——留言消息
 * @param title - 标题
 * @param content - 留言内容
 */
- (void)onMessage:(NSString*)title Content:(NSString*)content;

/**
 * 网管指令——指派用户名密码
 * @param user
 * @param password
 */
- (void)onAssignUser:(NSString*)user Password:(NSString*)password;

/**
 * 网管指令————播放媒体
 * @param url - 播放url
 */
- (void)onMediaPlay:(NSString*)url;

/**
 * 网管指令————停止播放
 */
- (void)onMediaStop;

/**
 * 网管指令————升级
 * @param url ———— 升级url
 */
- (void)onUpgrade:(NSString*)url;

/**
 * 网管指令————重启
 */
- (void)onRestart;

/**
 * 网管指令————删除参数
 * @param paramName,指定删除的参数名称
 */
- (void)onDelParam:(NSString*)paramName;

/**
 * 网管指令————睡眠
 */
- (void)onStandby;

/**
 * 网管指令————唤醒
 */
- (void)onWakeup;

/**
 * 网管指令————关机
 */
- (void)onShutDown;


@end

@interface SoapClient : NSObject

// 返回当前连接的ois地址， 格式： ip:port
@property (nonatomic, strong, readonly) NSString *mOisAddr;
// 获取epgs地址，
// 从此处获得的epgs是ois下发的, 格式形如: 172.16.36.188:8080
@property (nonatomic, strong, readonly) NSString *mEpgsAddr;
// 获得与ois通讯的token
@property (nonatomic, strong, readonly) NSString *mOisToken;
// 获得与epgs通讯的token
@property (nonatomic, strong, readonly) NSString *mEpgsToken;
// 设置网管NMP回调监听
@property (assign, nonatomic) id<SoapNmpDelegate> nmpDelegate;

// 单例模式
+ (SoapClient*) sharedInstance;

/**
 * 设置soapclient工作模式
 * soapclient 有两种工作模式，手动和自动，自动模式将自动定期登录ois，获取token等信息，
 * 手动模式则需要用户自己控制登录，默认soapclient工作在手动模式
 * @param auto 为true表示自动工作模式， 为false表示手动工作模式
 */
- (void)setAutoProcess:(BOOL)autoProcess;

/**
 * 登录
 * 登录OIS将需要带上user, password, terminal_id, terminal_type, mac, netmode, soft_ver, hard_ver
 * 这些参数将从Parameter模块获取，请确保Parameter模块相关参数已初始化
 * @param user 用户id
 * @param password 密码
 * @param terminal_id 终端ID
 * @param terminal_type 终端类型
 * @param mac mac地址
 * @param netmode 网络连接方式：1: lan-dhcp, 2: lan-static, 3: lan-pppoe, 4: wifi-dhcp, 5: wifi-static, 6: wifi-pppoe, 7: 3G
 * @param soft_ver 软件版本号
 * @param hard_ver 硬件版本号
 * @param epg EPG模版
 * @return 返回null表示异常出错，正常返回SoapResponse,
 * 其中的SoapResponse.statusCode是OIS服务器响应状态码，意义如下：
 * 			HTTP 200 登录成功
 * 			HTTP 400 非法请求
 * 			HTTP 401 用户不存在
 * 			HTTP 402 用户未开通
 * 			HTTP 403 用户已过期
 * 			HTTP 404 用户密码错误
 * 			HTTP 405 终端ID不存在
 * 			HTTP 406 终端未开通
 * 			HTTP 407 超出了软终端在线连接数限制
 *			HTTP 408 机顶盒已过期
 *			HTTP 409 无效的EPG模版
 *			HTTP 410 超过OIS负载，需要切换OIS
 */
- (void)login:(HttpResponseCompletion)completion;

/**
 * 登出
 * @param user 用户id
 * @param terminal_id 终端id
 * @return 返回-1表示异常出错，正常返回服务器响应状态码，意义如下：
 * 			HTTP 200 登出成功
 *			HTTP 400 非法请求
 *			HTTP 401 用户不存在
 *		    HTTP 402 终端不存在
 *			HTTP 403 终端未登录（已离线）
 */
- (void)logout:(HttpResponseCompletion)completion;

/**
 * 鉴权
 * @param user 用户名
 * @param terminal_id 终端ID
 * @param mediaId 要鉴权的媒资id
 * @return 正常返回AuthenResponse, 返回null表示异常出错，服务器响应状态码意义如下：
 * 			HTTP 200 鉴权成功
 *			HTTP 400 鉴权失败，非法请求
 *			HTTP 401 鉴权失败，非法用户
 *		    HTTP 402 鉴权失败，用户被禁用
 *			HTTP 403 鉴权失败，无效token
 *			HTTP 404 鉴权失败，无效的media_id
 *			HTTP 405 鉴权失败，service未包含media
 *			HTTP 406 鉴权失败，用户未订购
 *		    HTTP 409 鉴权失败，无效终端
 *		    HTTP 410 鉴权失败，终端已禁用
 */
- (void)authen:(NSString *)mediaId completion:(HttpResponseCompletion)completion;

/**
 * 注册用户
 * @param user 用户名
 * @param password 密码
 * @param realname 昵称
 * @param country 国家
 * @param postcode 邮编
 * @param email 邮箱
 * @param addr 住址
 * @param phone 电话
 * @param mobile 手机号
 * @param birthday 生日
 * @param channel 渠道
 * @param enable 是否启用，根据业务需要置true或false，
 * 		如果需要后台管理员审核启用之后才能生效，那么就置false, 意味着注册之后用户仍然还不能登录成功，OIS将返回402用户未开通的错误
 * 		如果不需要后台管理员审核，注册之后就直接启用生效，那么就置true
 * @return 返回-1表示异常出错，正常返回服务器响应状态码，意义如下：
 * 			HTTP 200 注册成功
 * 			HTTP 400 非法请求
 * 			HTTP 401 用户名已经存在
 * 			HTTP 402 服务器添加失败
 * 			HTTP 403 表示字段不合法，一般指用户名ID不合法，ID规范：只能是数字字母下划线小短杠的组合，不能含有空格，不能有中文。客户端和服务器都应该对相关字段进行校验。
 */
- (void)registerWithUser:(NSString *)user password:(NSString *)password realname:(NSString *)realName country:(NSString *)country postcode:(NSString *)postcode email:(NSString *)email addr:(NSString *)addr phone:(NSString *)phone mobile:(NSString *)mobile birthday:(NSString *)birthday channel:(NSString *)channel enable:(NSString *)enable completion:(HttpResponseCompletion)completion;

/**
 * 修改密码
 * @param user 用户id
 * @param oldPassword 旧密码
 * @param newPassword 新密码
 * @param timeout 超时失败时间，单位ms
 * @return 返回-1表示异常出错，正常返回服务器响应状态码，意义如下：
 * 			HTTP 400 非法请求
 *			HTTP 401 用户不存在
 *			HTTP 402 原密码有误
 *			HTTP 403新密码不一致
 */
-(void) changePassword:(NSString *)user oldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword completion:(HttpResponseCompletion)completion;

/**
 * 订购业务
 * @param user 用户id
 * @param sid 媒资ID或业务包ID
 * @return 返回-1表示异常出错，正常返回服务器响应状态码，意义如下：
 *			HTTP 200 订购成功
 * 			HTTP 400 非法请求
 * 			HTTP 401 非法用户
 * 			HTTP 402 业务包不存在
 * 			HTTP 403 无效token
 *  		HTTP 404 已经订购过,无需再订购
 *          HTTP 405 余额不足
 */
- (void)subscribe:(NSString *)user sid:(NSString *)sid completion:(HttpResponseCompletion)completion;

/**
 * 退订业务
 * @param user 用户id
 * @param sid 媒资ID或业务包ID
 * @return 返回-1表示异常出错，正常返回服务器响应状态码，意义如下：
 * 			HTTP 200 退订成功
 * 			HTTP 400 非法请求
 * 			HTTP 401 非法用户
 *			HTTP 402 业务包不存在, 或者之前就没有订购过该产品包
 * 			HTTP 403 无效token
 *          HTTP 404 业务包已经生效, 不能退订
 */
- (void)unSubscribe:(NSString *)user sid:(NSString *)sid completion:(HttpResponseCompletion)completion;

/**
 * 获取某用户 的订购列表
 * @param user 用户id
 * @param type : 0-- 表示获取所有的订购记录, 1-- 表示获取有效未过期的订购记录, 2-- 表示获取过期失效的订购记录
 * @return 返回SubscribeBean列表， 返回null表示异常出错，服务器响应状态码意义如下：
 * 			HTTP 200 获取订购的产品包列表成功, 数据存于 body 中
 * 			HTTP 400 非法请求
 *			HTTP 401 非法用户
 * 			HTTP 403 无效token
 */
- (void)getSubscribeList:(NSString *)user Type:(SoapSubscribeType)type completion:(HttpResponseCompletion)completion;

/**
 * 财付通手机购买支付url
 * @param  user: 用户id
 * @param  serviceId: 业务包ID
 * @param  fee: 支付金额，单位分
 * @param  hours: 订购时长，单位小时
 * @param  desc：描述，一般用于财付通页面的产品名称显示，UTF8编码，必要时候需要URLEncode
 * @return 返回-1表示异常出错，正常返回服务器响应状态码，意义如下：
 * 			HTTP 200 返回  成功
 * 			HTTP 400 非法请求
 * 			HTTP 401 非法用户
 * 			HTTP 402 无效service_id
 * 			HTTP 403 无效token
 * 			HTTP 409 已经订购
 *  		HTTP 500 服务器内部错
 **/
- (void)getWAPTenPayBuyUrl:(NSString *)user sid:(NSString *)sid desc:(NSString *)desc completion:(HttpResponseCompletion)completion;

/**
 * 财付通手机充值支付url
 * @param  user: 用户id
 * @param  fee: 支付金额，单位分
 * @param  desc：描述，一般用于财付通页面的产品名称显示，UTF8编码，必要时候需要URLEncode
 * @return 返回-1表示异常出错，正常返回服务器响应状态码，意义如下：
 * 			HTTP 200 返回 url 成功
 * 			HTTP 400 非法请求
 * 			HTTP 401 非法用户
 * 			HTTP 403 无效token
 *  		HTTP 500 服务器内部错
 **/
- (void)getWAPTenPayRechargeUrl:(NSString *)user amount:(NSInteger)amount desc:(NSString *)desc completion:(HttpResponseCompletion)completion;

/**
 * 获取 Paypal 购买支付 url
 * @param  user: 用户id
 * @param  sid: 业务包ID
 * @param  desc：描述，一般用于财付通页面的产品名称显示，UTF8编码，必要时候需要URLEncode
 * @return 返回null表示异常出错，正常返回支付url， 服务器响应状态码意义如下：
 * 			HTTP 200 返回 url 成功
 * 			HTTP 400 非法请求
 * 			HTTP 401 非法用户
 * 			HTTP 402 无效service_id
 * 			HTTP 403 无效token
 * 			HTTP 409 已经订购
 *  		HTTP 500 服务器内部错
 **/
- (void)getPayPalBuyUrl:(NSString *)user sid:(NSString *)sid desc:(NSString *)desc completion:(HttpResponseCompletion)completion;

/**
 * paypal充值url
 * @param  user: 用户id
 * @param  fee: 支付金额，单位分
 * @param  desc：描述，一般用于财付通页面的产品名称显示，UTF8编码，必要时候需要URLEncode
 * @return 返回-1表示异常出错，正常返回服务器响应状态码，意义如下：
 * 			HTTP 200 返回 url 成功
 * 			HTTP 400 非法请求
 * 			HTTP 401 非法用户
 * 			HTTP 403 无效token
 *  		HTTP 500 服务器内部错
 **/
- (void)getPayPalReChargeUrl:(NSString *)user amount:(NSInteger)amount desc:(NSString *)desc completion:(HttpResponseCompletion)completion;

/**
 * 账户充值
 * @param user 用户id
 * @param amount 充值金额, 单位美分
 * @param timeout 超时失败时间，单位ms
 * @return 返回-1表示异常出错，正常返回服务器响应状态码，意义如下：
 * 			HTTP 200 充值成功
 * 			HTTP 400 非法请求
 *			HTTP 401 非法用户
 * 			HTTP 403 无效token
 */
- (void)recharge:(NSString *)user amount:(NSInteger)amount completion:(HttpResponseCompletion)completion;

/**
 * 账户充值 --- 采用视频充值卡方式
 * @param user 用户id
 * @param cardId 充值卡 id 号
 * @return 返回-1表示异常出错，正常返回服务器响应状态码，意义如下：
 * 			HTTP 200 充值成功
 * 			HTTP 400 非法请求
 *			HTTP 401 非法用户
 * 			HTTP 403 无效token
 *          HTTP 404 无效充值卡 id 号
 *          HTTP 405 该充值卡已经使用过
 */
- (void)videoCardRecharge:(NSString *)user cardno:(NSString *)cardno completion:(HttpResponseCompletion)completion;

/**
 * 获取充值卡信息
 * @param user 用户id
 * @param cardId 充值卡 id 号
 * @return 正常返回VideoCarBean, 返回null表示异常出错，服务器响应状态码意义如下：
 * 			HTTP 200 获取充值卡信息成功
 * 			HTTP 400 非法请求
 *			HTTP 401 非法用户
 * 			HTTP 403 无效token
 *          HTTP 404 无效充值卡 id 号
 */
- (void)videoCardInfo:(NSString *)user CardNo:(NSString *)cardno completion:(HttpResponseCompletion)completion;

/**
 * 获取某用户账单（消费记录）
 * @param user 用户id
 * @param start_utc：起始时间utc（单位s）
 * @param end_utc:  结束时间utc（单位s）
 * @param page_no:  页码，起始从1开始
 * @param page_size: 页大小
 * @return 返回-1表示异常出错，正常返回服务器响应状态码，意义如下：
 * 			HTTP 200 获取消费记录列表成功, 数据存于 body 中
 * 			HTTP 400 非法请求
 *			HTTP 401 非法用户
 */
- (void)getAssetList:(NSString *)user startUtc:(NSTimeInterval)start_utc endUtc:(NSTimeInterval)end_utc pageNo:(NSInteger)pageno pageSize:(NSInteger)pagesize completion:(HttpResponseCompletion)completion;

/**
 * 获取用户资料
 * @param user 用户id
 * @return 正常返回UserBean， 异常返回null, 服务器返回状态码意义如下：
 * 			HTTP 200 成功
 * 			HTTP 400 非法请求
 *			HTTP 401 非法用户
 * 			HTTP 403 无效token
 */
- (void)getUserInfo:(NSString *)user completion:(HttpResponseCompletion)completion;

/**
 * 修改用户信息
 * @param user 用户ID 必带参数
 * @param realname 昵称 ，如果不修改则置为null
 * @param country 国家 ，如果不修改则置为null
 * @param email 邮箱 ，如果不修改则置为null
 * @param addr 地址 ，如果不修改则置为null
 * @param phone 电话 ，如果不修改则置为null
 * @param mobile 手机 ，如果不修改则置为null
 * @param postcode 邮编 ，如果不修改则置为null
 * @param birthday 生日 ，如果不修改则置为null
 * @return 返回-1表示异常出错，服务器响应状态码，意义如下：
 * 			HTTP 200 修改成功
 * 			HTTP 400 非法请求
 *			HTTP 401 非法用户
 * 			HTTP 403 无效token
 */
- (void)setUserInfo:(NSString *)user realname:(NSString *)realname country:(NSString *)country email:(NSString *)email addr:(NSString *)addr phone:(NSString *)phone mobile:(NSString *)mobile postcode:(NSString *)postcode birthday:(NSString *)birthday completion:(HttpResponseCompletion)completion;

/**
 * 发送日志
 * @param body - 日志体
 * @return
 */
- (void)sendlog:(NSString *)body;
    
/**
 * 向OIS提交某个参数
 * 一般是响应网管NMP获取参数指令后调用
 * @param terminalId 终端id
 * @param paramName 参数名
 * @param paramValue 参数值
 * @param timeout 超时失败时间，单位ms
 * @return 返回-1表示异常出错，正常返回服务器响应状态码，意义如下：
 * 			HTTP 200 鉴权成功
 * 			HTTP 400 非法请求
 */
- (void)postParam:(NSString *)paramName Value:(NSString *)paramValue;

/**
 * 向OIS提交所有参数
 * 一般是响应网管NMP获取所有参数指令后调用
 * @param terminalId 终端id
 * @param allParams 所有参数字符串， 格式：key=value\nkey=value\nkey=value, 即每行一个键值对
 * @param timeout 超时失败时间，单位ms
 * @return 返回-1表示异常出错，正常返回服务器响应状态码，意义如下：
 * 			HTTP 200 鉴权成功
 * 			HTTP 400 非法请求
 */
- (void)postAllParam:(NSString *)allParam;

@end
