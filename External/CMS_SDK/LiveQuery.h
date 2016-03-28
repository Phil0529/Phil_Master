//
//  LiveQuery.h
//  EZTV
//
//  Created by Lee, Bo on 15/8/11.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OVCCMSClient.h"
#import "LiveHomeItem.h"
#import "LiveResponseModel.h"
#import "CertificationItem.h"
#import "LiveAuthItem.h"
#import "CountItem.h"

@interface LiveQuery : NSObject

/**
 *  获取直播标签列表
 *
 *  @param completion 数据返回block
 *X
 *  @return AFHTTPRequestOperation
 */
+ (AFHTTPRequestOperation *)getTagList:(void(^)(NSArray *result))completion;

/**
 *  获取微直播首页列表数据
 *
 *  @param completion 数据返回block
 *
 *  @return AFHTTPRequestOperation
 */
+ (AFHTTPRequestOperation *)getLiveHomeDataArray:(void(^)(NSArray *result))completion;

/**
 *  获取微直播视频列表
 *
 *  @param tagName    标签名称 可以为空
 *  @param tagType    标签类型 可以传多个值: 0|1
 *  @param liveType   视频类型 可以传多个只: 0|1
 *  @param pageIndex  页码
 *  @param pageSize   页大小
 *  @param completion 数据返回block
 *
 *  @return AFHTTPRequestOperation
 */
+ (AFHTTPRequestOperation *)getLiveListWithTagName:(NSString *)tagName tagType:(NSString *)tagType liveType:(NSString *)liveType liveId:(NSString *)liveId pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize completion:(void(^)(NSArray *result))completion;

/**
 *  获取微直播详细信息
 *
 *  @param lid        微直播id
 *  @param completion 数据返回block
 *
 *  @return AFHTTPRequestOperation
 */
+ (AFHTTPRequestOperation *)getLiveDetailWithLiveId:(NSString *)lid completion:(void(^)(LiveItem *detail))completion;

/**
 *  获取最近预告列表
 *
 *  @param mpno       用户ID
 *  @param pageIndex  分页 页码
 *  @param pageSize   分页 每页尺寸
 *  @param completion 数据返回block
 *
 *  @return AFHTTPRequestOperation
 */


+ (AFHTTPRequestOperation *)getTrailerListWithMpno:(NSString *)mpno pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize completion:(void(^)(NSArray *result))completion;

/**
 *  获取实名认证信息
 *
 *  @param completion 数据返回block
 *
 *  @return AFHTTPRequestOperation
 */
+ (AFHTTPRequestOperation *)getCertificateInfo:(void (^)(CertificationInfo *info))completion;


/**
 *  实名认证推送
 *
 *  @param nickName    昵称
 *  @param occupation  occupation
 *  @param NativePlace 出生地
 *  @param IDNum       身份证号
 *  @param photoStr  照片信息
 *  @param phoneNo     手机号
 *  @param reasons     原由
 *  @param completion  数据完成回调
 *
 *  @return AFHTTPRequestOperation
 */
+ (AFHTTPRequestOperation *)postCertificateInfoWithNickName:(NSString *)nickName occupation:(NSString *)occupation place:(NSString *)NativePlace IDNumber:(NSString *)IDNum photo:(NSString *)photoStr phoneNo:(NSString *)phoneNo applyReasons:(NSString *)reasons completion:(void (^)(CertificationItem *certificate))completion;

/**
 *  发起直播请求
 *
 *  @param liveType  请求类型/ 直播, 上传录播, 预告
 *  @param lid       直播id (选择预告方式发起直播,上传视频时需要传的值)
 *  @param startTime 开始时间 (发起预告)
 *  @param mpno      用户id
 *  @param headImg   用户头像
 *  @param title     标题
 *  @param desc      描述
 *  @param uid       ois相关
 *  @param cid       ois相关
 *  @param tid       ois相关
 *  @param url       直播URL
 lon=xxx, <string>//经度
 lat=xxx, <string>//纬度
 address=xxx, <string>//地理位置
 city=xxx,<string>城市
 *  @param tagName   标签
 *  @param tagType   标签类型
 *  @param completion  数据完成回调
 *
 *  @return AFHTTPRequestOperation
 */
+ (AFHTTPRequestOperation *)sendLiveRequestWithType:(LiveType)liveType lid:(NSString *)lid startTime:(NSTimeInterval)startTime title:(NSString *)title desc:(NSString *)desc uid:(NSString *)uid cid:(NSString *)cid tid:(NSString *)tid cdsid:(NSString *)cdsid tagName:(NSString *)tagName tagType:(TagType)tagType cover:(NSString *)cover lon:(NSString *)lon lat:(NSString *)lat address:(NSString *)address city:(NSString *)city showLocation:(NSString *)show completion:(void (^)(LiveResponseModel *liveResponse))completion;

/**
 *  销毁微直播,并转录播
 *
 *  @param lid        直播Id
 *  @param completion 数据完成回调
 *
 *  @return AFHTTPRequestOperation
 */
+ (AFHTTPRequestOperation *)stopLiveStreamWithLiveId:(NSString *)lid completion:(void (^)(LiveResponseModel *liveResponse))completion;

/**
 *  开始推微直播流
 *
 *  @param lid        直播Id
 *  @param completion 数据完成回调
 *
 *  @return AFHTTPRequestOperation
 */
+ (AFHTTPRequestOperation *)startPushLiveStreamWithLiveId:(NSString *)lid completion:(void (^)(LiveResponseModel *liveResponse))completion;

/**
 *  意见反馈,视频举报接口
 *
 *  @param content    反馈内容
 *  @param contact    联系方式
 *  @param type       类型
 *  @param from       渠道, -1 个人中心, 0= 新闻 1 = 微直播
 *  @param mid        资源id
 *  @param completion 数据完成回调
 *
 *  @return AFHTTPRequestOperation
 */
+ (AFHTTPRequestOperation *)feedbackWithContent:(NSString *)content contact:(NSString *)contact type:(NSString *)type from:(NSInteger)from mid:(NSString *)mid completion:(void (^)(LiveResponseModel *liveResponse))completion;

/**
 *  微直播视频点赞
 *
 *  @param count      点赞数
 *  @param lid        视频id
 *  @param completion 数据完成回调
 *
 *  @return AFHTTPRequestOperation
 */
+ (AFHTTPRequestOperation *)assitLiveWithCount:(NSInteger)count lid:(NSString *)lid completion:(void (^)(LiveResponseModel *liveResponse))completion;

/**
 *  写入浏览记录接口
 *
 *  @param lid        微直播id
 *  @param completion 数据完成回调
 *
 *  @return AFHTTPRequestOperation
 */
+ (AFHTTPRequestOperation *)saveLiveHistoryWithLiveID:(NSString *)lid completion:(void (^)(LiveResponseModel *liveResponse))completion;

/**
 *  微直播签到接口
 *
 *  @param adress     签到地址
 *  @param lon        经度
 *  @param lat        纬度
 *  @param city       城市
 *  @param completion 数据完成回调
 *
 *  @return AFHTTPRequestOperation
 */
+ (AFHTTPRequestOperation *)liveSignWithAddress:(NSString *)address lon:(NSString *)lon lat:(NSString *)lat city:(NSString *)city completion:(void (^)(LiveResponseModel *liveResponse))completion;

/**
 *  获取直播权限接口
 *
 *  @param completion 数据完成回调
 *
 *  @return AFHTTPRequestOperation
 */
+ (AFHTTPRequestOperation *)checkLiveAuthentication:(void (^)(LiveAuthItem *liveAuth))completion;

+ (AFHTTPRequestOperation *)getViewCountWithLiveID:(NSString *)lid completion:(void (^)(CountItem* item))completion;

@end
