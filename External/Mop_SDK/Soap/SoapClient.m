//
//  SoapClient.m
//  SWMOP
//
//  Created by guoziyi on 14-2-25.
//  Copyright (c) 2014年 husl. All rights reserved.
//
#import "SoapClient.h"
#import "Parameter.h"
#import "XmlDataParser.h"
#import "MopLog.h"
#import "Tools.h"

// 请求方法定义
static NSString *METHOD_LOGIN = @"/ois/user/login";  // 登录
static NSString *METHOD_LOGOUT = @"/ois/user/logout";  // 登录
static NSString *METHOD_ENABLE = @"/ois/stb/enable"; // 机顶盒激活
static NSString *METHOD_REGISTER = @"/ois/user/register"; // 注册
static NSString *METHOD_MODIFYPASS = @"/ois/user/setpassword"; // 改密
static NSString *METHOD_AUTHEN = @"/ois/play/authen"; // 鉴权
static NSString *METHOD_SUBSCRIBE = @"/ois/user/subscribe"; // 订购
static NSString *METHOD_UNSUBSCRIBE = @"/ois/user/unsubscribe"; // 取消订购
static NSString *METHOD_GETSUBSCRIBELIST = @"/ois/subscribe/list"; //订购列表
static NSString *METHOD_WAPTENPAY_BUY = @"/ois/waptenpay/buy" ;  // 获取财付通手机购买支付url
static NSString *METHOD_PCTENPAY_BUY = @"/ois/pctenpay/buy" ;  // 获取财付通PC购买支付url
static NSString *METHOD_WAPTENPAY_RECHARGE = @"/ois/waptenpay/recharge" ;  // 获取财付通手机购买支付url
static NSString *METHOD_PCTENPAY_RECHARGE = @"/ois/pctenpay/recharge" ;  // 获取财付通PC购买支付url
static NSString *METHOD_PAYPAL_BUY = @"/ois/paypal/buy";  // 获取 PayPal 第三方支付系统 购买支付 url
static NSString *METHOD_PAYPAL_RECHARGE = @"/ois/paypal/recharge";  // 获取 PayPal 第三方支付系统  充值支付 url
static NSString *METHOD_RECHARGE = @"/ois/user/recharge"; // 充值
static NSString *METHOD_VIDEOCARD_RECHARGE = @"/ois/videocard/recharge"; //充值卡充值
static NSString *METHOD_VIDEOCARD_INFO = @"/ois/videocard/info";//充值卡查询
static NSString *METHOD_GET_ASSETLIST = @"/ois/asset/list"; //获取消费记录
static NSString *METHOD_SENDLOG = @"/ois/log";  // 发送日志
static NSString *METHOD_PARAM = @"/ois/terminal/param_ret";// 提交指定参数
static NSString *METHOD_ALLPARAM = @"/ois/terminal/allparam_ret";// 提交所有参数
static NSString *METHOD_GET_USERINFO = @"/ois/user/info";//获取用户信息
static NSString *METHOD_SET_USERINFO = @"/ois/user/modify";//更改用户信息
static NSString *METHOD_SENLOG = @"/ois/log";//发送log

// soap 消息头尾定义
static const NSString *SOAP_HEAD = @"<?xml version='1.0' encoding='GB2312'?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"default\" SOAP-ENV:encodingStyle=\"default\">\r\n\t<SOAP-ENV:Body>\r\n";
static const NSString *SOAP_TAIL = @"\r\n\t</SOAP-ENV:Body>\r\n</SOAP-ENV:Envelope>\r\n";

static NSTimeInterval timeoutInterval = 10.f;

static SoapClient *sharedInstance = nil;

@implementation SoapClient
{
    NSString *_mOisListString;
    NSArray *_mOisList;
    NSInteger _mOisIndex;
    NSTimer *_mTimer;
    BOOL _autoProcess;
    NSInteger _mLoginFailedCount;
}

@synthesize mOisAddr = _mOisAddr;
@synthesize mEpgsAddr = _mEpgsAddr;
@synthesize mOisToken = _mOisToken;
@synthesize mEpgsToken = _mEpgsToken;

+ (SoapClient*) sharedInstance
{
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[SoapClient alloc] init];
    });
    return sharedInstance;
}

// 初始化单例
- (id) init
{
    self = [super init];
    if (self) {
        [self setOis:[[Parameter sharedInstance] getValueOfKey:ParamOis]];
        _autoProcess = NO;
        _mTimer = [NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)handleTimer:(NSTimer *)timer
{
    if(_autoProcess)
    {
        [self login:nil];
    }
}

- (void)setOis:(NSString *)oisStr
{
    _mOisListString = oisStr;
    _mOisList = [_mOisListString componentsSeparatedByString:@"|"];
    _mOisIndex = 0;
    _mOisAddr = [_mOisList objectAtIndex:_mOisIndex];
}

- (void)changeOis
{
    _mOisIndex = (_mOisIndex + 1) % [_mOisList count];
}

- (void)dealloc
{
    if (_mTimer) {
        [_mTimer invalidate];
        _mTimer = nil;
    }
}

- (BOOL)isStringEmpty:(NSString *)str
{
    if (str) {
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (str.length > 0) {
            return NO;
        }
    }
    return YES;
}

- (void)setAutoProcess:(BOOL)autoProcess
{
    //heartbeat switch
    _autoProcess = autoProcess;
}

- (void)login:(HttpResponseCompletion)completion
{
    NSString *path = [NSString stringWithFormat:@"https://%@%@", _mOisAddr, METHOD_LOGIN];
    NSString *content = [NSString stringWithFormat:@"%@ <login user=\"%@\" password=\"%@\" terminal_id=\"%@\" terminal_type=\"%@\" mac=\"%@\" netmode=\"%@\" soft_ver=\"%@\" hard_ver=\"%@\" epg=\"%@\" token=\"%@\" />%@", SOAP_HEAD, [[Parameter sharedInstance] getValueOfKey:ParamUser], [[Parameter sharedInstance] getValueOfKey:ParamPassword], [[Parameter sharedInstance] getValueOfKey:ParamTerminalId], [[Parameter sharedInstance] getValueOfKey:ParamTerminalType], [[Parameter sharedInstance] getValueOfKey:ParamMac], [[Parameter sharedInstance] getValueOfKey:ParamNetMode], [[Parameter sharedInstance] getValueOfKey:ParamSoftVersion], [[Parameter sharedInstance] getValueOfKey:ParamHardVersion], [[Parameter sharedInstance] getValueOfKey:ParamEpg], _mOisToken, SOAP_TAIL];
    [NSHttpRequest POST:path content:content timeout:timeoutInterval completion:^(HttpResponse *response) {
        if(response&& response.mStatusCode == 200)
        {
            MopLogD(@"Soap heartbeat, user: %@",[[Parameter sharedInstance] getValueOfKey:ParamUser]);
            BOOL paramChange = NO;
            _mLoginFailedCount = 0;
            _mOisToken = response.mOisToken;
            _mEpgsToken = response.mEpgsToken;
            if(![self isStringEmpty:response.mOisIp] && ![response.mOisIp isEqualToString:_mOisListString])
            {
                [self setOis:response.mOisIp];
                [[Parameter sharedInstance] setValue:response.mOisIp forKey:ParamOis];
                paramChange = YES;
            }
            if(![self isStringEmpty:response.mEpgsIp] && ![response.mEpgsIp isEqualToString:_mEpgsAddr])
            {
                _mEpgsAddr = response.mEpgsIp;
                [[Parameter sharedInstance] setValue:_mEpgsAddr forKey:ParamEpgs];
                paramChange = YES;
            }
            if(![self isStringEmpty:response.mSoapBody])
            {
                [self parseNmpBody:response.mSoapBody
                        TerminalId:[[Parameter sharedInstance] getValueOfKey:ParamTerminalId]
                              User:[[Parameter sharedInstance] getValueOfKey:ParamUser]];
                [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(handleTimer:) userInfo:nil repeats:NO];
            }
            if (paramChange) {
                [[Parameter sharedInstance] save];
            }
        }else{
            _mLoginFailedCount++;
            if(_mLoginFailedCount >= 3) {
                MopLogE(@"连续登录失败3次, 换一个ois 登陆");
                _mLoginFailedCount = 0;
                [self changeOis];
            }
        }
        if (completion) {
            completion(response);
        }
    }];
}

/**
 * 解析网管指令，并根据响应网管指令调用OnNmpListener回调
 * @param body - ois 下发的网管指令消息体，参看4.0接口规范文档
 */
- (void)parseNmpBody:(NSString *)body TerminalId:(NSString *)terminalId User:(NSString*)user
{
    if(body == nil || [body isEqualToString:@""])
    {
        return;
    }
    if(_nmpDelegate != nil)
    {
        XmlDataParser *parser = [[XmlDataParser alloc]init];
        [parser startParse:body completion:^(NSArray *list) {
            for (xmlElement *elem in list) {
                NSString *cmd = elem.NodeName;
                if ([cmd isEqualToString:@"user"]) { //P2P专用的历史遗留指令，略过
                    continue;
                }
                
                if ([cmd isEqualToString:@"message"]) {
                    // 留言消息
                    // 校验一把user, 看消息是不是发给自己的，防止OIS发错消息
                    NSString *userid = [elem.NodeAttrs objectForKey:@"user"];
                    if (userid&& !([userid caseInsensitiveCompare:user] == NSOrderedSame) && ![userid isEqualToString:@"*"]) {
                        MopLogE(@"user not match, nmp command unvalid!");
                        continue;
                    }
                    NSString *title = [elem.NodeAttrs objectForKey:@"title"];
                    NSString *content = [elem.NodeAttrs objectForKey:@"content"];
                    [_nmpDelegate onMessage:title Content:content];
                    continue;
                }
                
                NSString *peerId = [elem.NodeAttrs objectForKey:@"peer_id"];
                if (peerId&& ![peerId isEqualToString:terminalId] && ![peerId isEqualToString:@"*"]) {
                    MopLogE(@"peerId not match, nmp command unvalid!");
                    continue;
                }
                
                MopLogD(@"===========================> receive nmp command: %@",cmd);
                if ([cmd isEqualToString:@"getparam"]) {
                    // 获取参数
                    NSString *name = [elem.NodeAttrs objectForKey:@"name"];
                    if (![Tools isEmptyString:name]) {
                        [_nmpDelegate onGetParam:name];
                    }
                } else if ([cmd isEqualToString:@"getallparam"]) {
                    // 获取所有参数
                    [_nmpDelegate onGetAllParam];
                } else if ([cmd isEqualToString:@"setparam"]) {
                    // 设置参数
                    NSString *name = [elem.NodeAttrs objectForKey:@"name"];
                    NSString *value = [elem.NodeAttrs objectForKey:@"value"];
                    if (![Tools isEmptyString:name] && ![Tools isEmptyString:value]) {
                        [_nmpDelegate onSetParam:name Value:value];
                    }
                } else if ([cmd isEqualToString:@"saveparam"]) {
                    // 保存参数
                    [_nmpDelegate onSaveParam];
                } else if ([cmd isEqualToString:@"openurl"]) {
                    // 打开url
                    NSString *url = [elem.NodeAttrs objectForKey:@"url"];
                    if(![Tools isEmptyString:url]) {
                        [_nmpDelegate onOpenUrl:url];
                    }
                } else if ([cmd isEqualToString:@"marquee"]) {
                    // 跑马灯消息
                    NSString *type = [elem.NodeAttrs objectForKey:@"type"];
                    NSString *title = [elem.NodeAttrs objectForKey:@"title"];
                    NSString *content = [elem.NodeAttrs objectForKey:@"content"];
                    NSInteger fontSize = [[elem.NodeAttrs objectForKey:@"fontSize"] integerValue];
                    NSString *fontColor = [elem.NodeAttrs objectForKey:@"fontColor"];
                    NSString *bgColor = [elem.NodeAttrs objectForKey:@"bgColor"];
                    NSInteger transparent = [[elem.NodeAttrs objectForKey:@"transparent"] integerValue];
                    NSInteger speed = [[elem.NodeAttrs objectForKey:@"speed"] integerValue];
                    NSInteger loop = [[elem.NodeAttrs objectForKey:@"loop"] integerValue];
                    NSInteger duration = [[elem.NodeAttrs objectForKey:@"duration"] integerValue];
                    NSInteger priority = [[elem.NodeAttrs objectForKey:@"priority"] integerValue];
                    
                    [_nmpDelegate onMarquee:type Title:title Content:content FontSize:fontSize FontColor:fontColor BgColor:bgColor Transparent:transparent Speed:speed Loop:loop Duration:duration Priority:priority];
                } else if ([cmd isEqualToString:@"alertmsg"]) {
                    // 弹框消息
                    NSString *title = [elem.NodeAttrs objectForKey:@"title"];
                    NSString *content = [elem.NodeAttrs objectForKey:@"content"];
                    [_nmpDelegate onAlertmsg:title Content:content];
                } else if ([cmd isEqualToString:@"assignuser"]) {
                    //指定用户名密码
                    NSString *userid = [elem.NodeAttrs objectForKey:@"user"];
                    NSString *password = [elem.NodeAttrs objectForKey:@"password"];
                    [_nmpDelegate onAssignUser:userid Password:password];
                }  else if ([cmd isEqualToString:@"mediaplay"]) {
                    // 播放媒体
                    NSString *url = [elem.NodeAttrs objectForKey:@"url"];
                    [_nmpDelegate onMediaPlay:url];
                }  else if ([cmd isEqualToString:@"mediastop"]) {
                    // 停止播放
                    [_nmpDelegate onMediaStop];
                }  else if ([cmd isEqualToString:@"upgrade"]) {
                    // 升级
                    NSString *url = [elem.NodeAttrs objectForKey:@"url"];
                    [_nmpDelegate onUpgrade:url];
                }  else if ([cmd isEqualToString:@"restart"]) { // 重启
                    [_nmpDelegate onRestart];
                }
            }
        }];
    }
}

- (void)logout:(HttpResponseCompletion)completion
{
    //登出关闭心跳
    [self setAutoProcess:NO];
    
    NSString *path = [NSString stringWithFormat:@"https://%@%@", _mOisAddr, METHOD_LOGOUT];
    NSString *content = [NSString stringWithFormat:@"%@ <logout user=\"%@\" terminal_id=\"%@\" />%@", SOAP_HEAD, [[Parameter sharedInstance] getValueOfKey:ParamUser], [[Parameter sharedInstance] getValueOfKey:ParamTerminalId], SOAP_TAIL];
    [NSHttpRequest POST:path content:content timeout:timeoutInterval
             completion:^(HttpResponse *response) {
                 if (completion) {
                     completion(response);
                 }
             }];
}

- (void)authen:(NSString *)mediaId completion:(HttpResponseCompletion)completion
{
    NSString *path = [NSString stringWithFormat:@"https://%@%@", _mOisAddr, METHOD_AUTHEN];
    NSString *content = [NSString stringWithFormat:@"%@ <authen user=\"%@\" terminal_id=\"%@\" media_id=\"%@\" token=\"%@\" /> %@", SOAP_HEAD, [[Parameter sharedInstance] getValueOfKey:ParamUser], [[Parameter sharedInstance] getValueOfKey:ParamTerminalId], mediaId, _mOisToken, SOAP_TAIL];
    [NSHttpRequest POST:path content:content timeout:timeoutInterval
             completion:^(HttpResponse *response) {
                 if (![self isStringEmpty:response.mSoapBody]) {
                     AuthItem *item = [[AuthItem alloc] initWithXml:response.mSoapBody];
                     response.mExtend = item;
                 }
                 if (completion) {
                     completion(response);
                 }
             }];
}

- (void)registerWithUser:(NSString *)user password:(NSString *)password realname:(NSString *)realName country:(NSString *)country postcode:(NSString *)postcode email:(NSString *)email addr:(NSString *)addr phone:(NSString *)phone mobile:(NSString *)mobile birthday:(NSString *)birthday channel:(NSString *)channel enable:(NSString *)enable completion:(HttpResponseCompletion)completion
{
    NSString *path = [NSString stringWithFormat:@"https://%@%@", _mOisAddr, METHOD_REGISTER];
    NSString *content = [NSString stringWithFormat:@"%@ <register user=\"%@\" password=\"%@\" realname=\"%@\" email=\"%@\" country=\"%@\" postcode=\"%@\" addr=\"%@\" phone=\"%@\" mobile=\"%@\" birthday=\"%@\" channel=\"%@\" enable=\"%@\"/> %@", SOAP_HEAD, user, password, realName, email, country, postcode ,addr ,phone ,mobile ,birthday , channel, enable , SOAP_TAIL];
    [NSHttpRequest POST:path content:content timeout:timeoutInterval completion:^(HttpResponse *response) {
        if (completion) {
            completion(response);
        }
    }];
}

- (void)changePassword:(NSString *)user oldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword completion:(HttpResponseCompletion)completion
{
    NSString *path = [NSString stringWithFormat:@"https://%@%@", _mOisAddr, METHOD_MODIFYPASS];
    NSString *content = [NSString stringWithFormat:@"%@ <setpassword user=\"%@\" password_old=\"%@\" password_new=\"%@\" password_confirm=\"%@\" />%@",SOAP_HEAD, user, oldPassword, newPassword, newPassword, SOAP_TAIL];
    [NSHttpRequest POST:path content:content timeout:timeoutInterval completion:^(HttpResponse *response) {
        if (completion) {
            completion(response);
        }
    }];
}

- (void)subscribe:(NSString *)user sid:(NSString *)sid completion:(HttpResponseCompletion)completion
{
    NSString *path = [NSString stringWithFormat:@"https://%@%@", _mOisAddr, METHOD_SUBSCRIBE];
    NSString *content = [NSString stringWithFormat:@"%@ <subscribe user=\"%@\" sid=\"%@\" token=\"%@\" /> %@", SOAP_HEAD, user, sid, _mOisToken, SOAP_TAIL];
    [NSHttpRequest POST:path content:content timeout:timeoutInterval completion:^(HttpResponse *response) {
        if (completion) {
            completion(response);
        }
    }];
}

- (void)unSubscribe:(NSString *)user sid:(NSString *)sid completion:(HttpResponseCompletion)completion
{
    NSString *path = [NSString stringWithFormat:@"https://%@%@", _mOisAddr, METHOD_UNSUBSCRIBE];
    NSString *content = [NSString stringWithFormat:@"%@ <unsubscribe user=\"%@\" service_id=\"%@\" token=\"%@\" /> %@", SOAP_HEAD, user, sid, _mOisToken, SOAP_TAIL];
    [NSHttpRequest POST:path content:content timeout:timeoutInterval completion:^(HttpResponse *response) {
        if (completion) {
            completion(response);
        }
    }];
}

- (void)getSubscribeList:(NSString *)user Type:(SoapSubscribeType)type completion:(HttpResponseCompletion)completion
{
    NSString *path = [NSString stringWithFormat:@"https://%@%@", _mOisAddr, METHOD_GETSUBSCRIBELIST];
    NSString *content = [NSString stringWithFormat:@"%@ <subscribelist user=\"%@\" type=\"%ld\" token=\"%@\" /> %@", SOAP_HEAD, user, (long)type, _mOisToken, SOAP_TAIL];
    [NSHttpRequest POST:path content:content timeout:timeoutInterval completion:^(HttpResponse *response) {
        if (response && response.mStatusCode == 200) {
            if ([self isStringEmpty:response.mSoapBody]) {
                SubscribeCollect *collection = [[SubscribeCollect alloc] initWithXml:response.mSoapBody andUser:user];
                response.mExtend = collection;
            }
        }
        if (completion) {
            completion(response);
        }
    }];
}

- (void)getWAPTenPayBuyUrl:(NSString *)user sid:(NSString *)sid desc:(NSString *)desc completion:(HttpResponseCompletion)completion
{
    NSString *path = [NSString stringWithFormat:@"https://%@%@", _mOisAddr, METHOD_WAPTENPAY_BUY];
    NSString *content = [NSString stringWithFormat:@"%@ <waptenpay user=\"%@\" sid=\"%@\" desc=\"%@\" token=\"%@\" />%@", SOAP_HEAD, user, sid, desc , _mOisToken, SOAP_TAIL];
    [NSHttpRequest POST:path content:content timeout:timeoutInterval completion:^(HttpResponse *response) {
        if (completion) {
            completion(response);
        }
    }];
}

- (void)getWAPTenPayRechargeUrl:(NSString *)user amount:(NSInteger)amount desc:(NSString *)desc completion:(HttpResponseCompletion)completion
{
    NSString *path = [NSString stringWithFormat:@"https://%@%@", _mOisAddr, METHOD_WAPTENPAY_RECHARGE];
    NSString *content = [NSString stringWithFormat:@"%@ <waptenpay user=\"%@\" amount=\"%ld\" desc=\"%@\" token=\"%@\" />%@", SOAP_HEAD, user, (long)amount, desc, _mOisToken, SOAP_TAIL];
    [NSHttpRequest POST:path content:content timeout:timeoutInterval completion:^(HttpResponse *response) {
        if (completion) {
            completion(response);
        }
    }];
}

- (void)getPayPalBuyUrl:(NSString *)user sid:(NSString *)sid desc:(NSString *)desc completion:(HttpResponseCompletion)completion
{
    NSString *path = [NSString stringWithFormat:@"https://%@%@", _mOisAddr, METHOD_PAYPAL_BUY];
    NSString *content = [NSString stringWithFormat:@"%@ <paypal user=\"%@\" sid=\"%@\" desc=\"%@\" token=\"%@\" />%@", SOAP_HEAD, user, sid, desc , _mOisToken, SOAP_TAIL];
    [NSHttpRequest POST:path content:content timeout:timeoutInterval completion:^(HttpResponse *response) {
        if (completion) {
            completion(response);
        }
    }];
}

- (void)getPayPalReChargeUrl:(NSString *)user amount:(NSInteger)amount desc:(NSString *)desc completion:(HttpResponseCompletion)completion
{
    NSString *path = [NSString stringWithFormat:@"https://%@%@", _mOisAddr, METHOD_PAYPAL_RECHARGE];
    NSString *content = [NSString stringWithFormat:@"%@ <paypal user=\"%@\" amount=\"%ld\" desc=\"%@\" token=\"%@\" />%@", SOAP_HEAD, user, (long)amount, desc, _mOisToken, SOAP_TAIL];
    [NSHttpRequest POST:path content:content timeout:timeoutInterval completion:^(HttpResponse *response) {
        if (completion) {
            completion(response);
        }
    }];
}

- (void)recharge:(NSString *)user amount:(NSInteger)amount completion:(HttpResponseCompletion)completion
{
    NSString *path = [NSString stringWithFormat:@"https://%@%@", _mOisAddr, METHOD_RECHARGE];
    NSString *content = [NSString stringWithFormat:@"%@ <recharge user=\"%@\" amount=\"%ld\" token=\"%@\" /> %@", SOAP_HEAD, user, (long)amount, _mOisToken, SOAP_TAIL];
    [NSHttpRequest POST:path content:content timeout:timeoutInterval completion:^(HttpResponse *response) {
        if (completion) {
            completion(response);
        }
    }];
}

- (void)videoCardRecharge:(NSString *)user cardno:(NSString *)cardno completion:(HttpResponseCompletion)completion
{
    NSString *path = [NSString stringWithFormat:@"https://%@%@", _mOisAddr, METHOD_VIDEOCARD_RECHARGE];
    NSString *content = [NSString stringWithFormat:@"%@ <recharge user=\"%@\" card_id=\"%@\" token=\"%@\" /> %@", SOAP_HEAD, user, cardno, _mOisToken, SOAP_TAIL];
    [NSHttpRequest POST:path content:content timeout:timeoutInterval completion:^(HttpResponse *response) {
        if (completion) {
            completion(response);
        }
    }];
}

- (void)videoCardInfo:(NSString *)user CardNo:(NSString *)cardno completion:(HttpResponseCompletion)completion
{
    NSString *path = [NSString stringWithFormat:@"https://%@%@", _mOisAddr, METHOD_VIDEOCARD_INFO];
    NSString *content = [NSString stringWithFormat:@"%@ <info user=\"%@\" card_id=\"%@\" token=\"%@\" /> %@", SOAP_HEAD, user, cardno, _mOisToken, SOAP_TAIL];
    [NSHttpRequest POST:path content:content timeout:timeoutInterval completion:^(HttpResponse *response) {
        if (response && response.mStatusCode == 200) {
            if ([self isStringEmpty:response.mSoapBody]) {
                VideoCardItem *item = [[VideoCardItem alloc] initWithXml:response.mSoapBody];
                response.mExtend = item;
            }
        }
        if (completion) {
            completion(response);
        }
    }];
}

- (void)getAssetList:(NSString *)user startUtc:(NSTimeInterval)start_utc endUtc:(NSTimeInterval)end_utc pageNo:(NSInteger)pageno pageSize:(NSInteger)pagesize completion:(HttpResponseCompletion)completion
{
    NSString *path = [NSString stringWithFormat:@"https://%@%@", _mOisAddr, METHOD_GET_ASSETLIST];
    NSString *content = [NSString stringWithFormat:@"%@ <assetlist user=\"%@\" start_utc=\"%.0f\" end_utc=\"%.0f\" page_no=\"%d\" page_size=\"%ld\" token=\"%@\" /> %@", SOAP_HEAD, user, start_utc, end_utc, pageno, (long)pagesize, _mOisToken, SOAP_TAIL];
    [NSHttpRequest POST:path content:content timeout:timeoutInterval completion:^(HttpResponse *response) {
        if (response&& response.mStatusCode == 200) {
            if (![self isStringEmpty:response.mSoapBody]) {
                AssetCollect *collection = [[AssetCollect alloc] initWithXml:response.mSoapBody andUser:user];
                response.mExtend = collection;
            }
        }
        if (completion) {
            completion(response);
        }
    }];
}

- (void)getUserInfo:(NSString *)user completion:(HttpResponseCompletion)completion
{
    NSString *path = [NSString stringWithFormat:@"https://%@%@", _mOisAddr, METHOD_GET_USERINFO];
    NSString *content = [NSString stringWithFormat:@"%@<info user=\"%@\" token=\"%@\" />%@", SOAP_HEAD, user, _mOisToken, SOAP_TAIL];
    [NSHttpRequest POST:path content:content timeout:timeoutInterval completion:^(HttpResponse *response) {
        if (response&& response.mStatusCode == 200) {
            if (![self isStringEmpty:response.mSoapBody]) {
                UserItem *item = [[UserItem alloc] initWithXml:response.mSoapBody andUser:user];
                response.mExtend = item;
            }
        }
        if (completion) {
            completion(response);
        }
    }];
}

- (void)setUserInfo:(NSString *)user realname:(NSString *)realname country:(NSString *)country email:(NSString *)email addr:(NSString *)addr phone:(NSString *)phone mobile:(NSString *)mobile postcode:(NSString *)postcode birthday:(NSString *)birthday completion:(HttpResponseCompletion)completion
{
    
}

- (void)sendlog:(NSString *)body
{
    NSString *path = [NSString stringWithFormat:@"https://%@%@", _mOisAddr, METHOD_SENLOG];
    NSString *content = [NSString stringWithFormat:@"%@%@%@", SOAP_HEAD, body, SOAP_TAIL];
    [NSHttpRequest POST:path content:content timeout:timeoutInterval completion:nil];
}

- (void)postParam:(NSString *)paramName Value:(NSString *)paramValue
{
    NSString *path = [NSString stringWithFormat:@"https://%@%@", _mOisAddr, METHOD_PARAM];
    NSString *content = [NSString stringWithFormat:@"%@ <param terminal_id=\"%@\" name=\"%@\" value=\"%@\" /> %@", SOAP_HEAD, [[Parameter sharedInstance] getValueOfKey:ParamTerminalId], paramName, paramValue, SOAP_TAIL];
    [NSHttpRequest POST:path content:content timeout:timeoutInterval completion:nil];
}

- (void)postAllParam:(NSString *)allParam
{
    NSString *path = [NSString stringWithFormat:@"https://%@%@", _mOisAddr, METHOD_ALLPARAM];
    NSString *content = [NSString stringWithFormat:@"%@ <allparam  terminal_id=\"%@\" value=\"%@\" /> %@", SOAP_HEAD, [[Parameter sharedInstance] getValueOfKey:ParamTerminalId], allParam, SOAP_TAIL];
    [NSHttpRequest POST:path content:content timeout:timeoutInterval completion:nil];
}

@end
