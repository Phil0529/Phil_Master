//
//  UserCenter.h
//  EZTV
//
//  Created by Sunni on 15/7/9.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

extern NSString* const cookieKey;

extern NSString* const keyHeadImg;  //头像
extern NSString* const keyNick;     //昵称
extern NSString* const keyGender;   //性别
extern NSString* const keyPhone;    //联系电话
extern NSString* const keyBirthday; //出生年月



@interface UserCenter : NSObject

@property (nonatomic, strong) UserInfo* currentUser;

/**
 *  单例模式
 *
 *  @return 返回单例实例
 */
+ (UserCenter *)defaultCenter;

/**
 *  根据图像Id获取
 *
 *  @param imgId 图像Id
 *
 *  @return 图像的完整Url
 */
+ (NSString *)getImgUrlByID:(NSString *)imgId;

/**
 *  获取活动图标
 *
 *  @param imgId 图像Id
 *
 *  @return 图像的完整Url
 */
+ (NSString *)getActivityImgUrlById:(NSInteger)activityId;

- (void)pullInfoWhenAPPLaunch;

/**
 *  判断当前是否有用户登录了
 *
 *  @return YES/NO
 */
- (BOOL)isLogined;

/**
 *  清理当前用户登录信息
 */
- (void)logoutCurrentUser;

/**
 *  获取跟用户中心通信的Cookie信息
 *
 *  @return Cookie 字符串
 */
- (NSString *)userCookie;

/**
 *  存储用户信息
 */
- (void)saveUserInfo;

@end
