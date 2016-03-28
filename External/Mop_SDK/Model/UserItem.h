//
//  UserItem.h
//  SWMOP
//
//  Created by Lee, Bo on 14/12/11.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserItem : NSObject

@property (nonatomic, strong) NSString *mUserId;   // 用户id
@property (nonatomic, strong) NSString *mPassword; // 密码
@property (nonatomic, strong) NSString *mRealname;  // 昵称
@property (nonatomic, strong) NSString *mBirthday; // 生日
@property (nonatomic, strong) NSString *mCountry; // 国家
@property (nonatomic, strong) NSString *mPostcode; // 邮编
@property (nonatomic, strong) NSString *mAddr; // 地址
@property (nonatomic, strong) NSString *mPhone; // 电话
@property (nonatomic, strong) NSString *mMobile; // 手机
@property (nonatomic, strong) NSString *mEmail; // e-mail
@property (nonatomic, assign) NSInteger mTermcnt; // 名下终端数
@property (nonatomic, assign) NSInteger mAllowst; // 允许同时连接的软终端数
@property (nonatomic, assign) NSInteger mEnableUtc; // 激活时间utc， 单位ms
@property (nonatomic, assign) NSInteger mValidtoUtc; // 到期时间utc， 单位ms， 0表示永久有效
@property (nonatomic, assign) NSInteger mBalances; // 账户余额

- (id)initWithXml:(NSString*)xmlStr andUser:(NSString*)user;

@end
