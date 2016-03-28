//
//  EZBroadcastManager.h
//  EZTV
//
//  Created by 肖翰程 on 9/23/15.
//  Copyright © 2015 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EZRadioItem.h"
//#import "EZPlayRadioViewController.h"
#import "StatusBarNotificationPhil.h"
#import "EZRadioItem.h"
//#import "EZPlayManager.h"

@protocol EZBroadcastManagerDelegate <NSObject>

- (void)tapToPlayRadioViewController;

@end

@interface EZBroadcastManager : NSObject

@property (nonatomic, strong) NSDictionary *dataDict;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSString *serverTimeUTC;
@property (nonatomic, strong) NSString *differseverTimeIphoneTime;
//@property (nonatomic, strong) EZRadioItem *liveItem;
@property (nonatomic, retain) EZRadioItem *playItem;
@property (nonatomic, assign) NSInteger selectColumn;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, retain) EZRadioItem *firstItem;


@property (nonatomic, strong) NSMutableArray *containURLArray;
@property (nonatomic, retain) EZChannelItem *presentChannelItem;
@property (nonatomic, retain) EZShowItem *presentShowItem;
@property (nonatomic, strong) NSArray *channelListArray;
@property (nonatomic, strong) NSArray *showListArray;

@property (nonatomic, retain) EZChannelItem *modifyChannelItem;
@property (nonatomic, retain) EZShowItem *modifyShowItem;
@property (nonatomic, strong) NSArray *modifychannelListArray;
@property (nonatomic, strong) NSArray *modifyShowListArray;
@property (nonatomic, assign) NSInteger selectChannel;

//@property (nonatomic, weak) EZPlayRadioViewController *playRadioController;
@property (nonatomic, strong) UIView *statusBarView;

@property (nonatomic, assign) id<EZBroadcastManagerDelegate> delegate;
//@property (nonatomic, strong) StatusBarNotificationPhil *statusBarNotification;
@property (nonatomic, strong) StatusBarNotificationPhil *statusBarNotification;
@property (nonatomic, strong) UILabel *statusTitleLabel;
@property (nonatomic, assign) BOOL isDisplayRadioStatusBar;
@property (nonatomic, assign) BOOL isNotPlayRadioVC;
@property (nonatomic, assign) BOOL removePlayRadioObserve;
@property (nonatomic, assign) BOOL playFail;

@property (nonatomic, assign) float changeTime;
@property (nonatomic, assign) float timeAfterSecond;


+(instancetype)shareInstance;

- (void)getDataArr:(NSArray *)array;

+ (void)getMyUploadArraybyMpnoPhil:(NSString *)broadid completion:(void (^)(NSArray *))completion;

+ (void)getBroadcastListDetail:(NSString *)broadid startTime:(NSString *)startTime endTime:(NSString *)endTime completion:(void (^)(NSArray *))completion;



+ (void)getBroadcastList:(void(^)(NSArray *))completion;

+ (void)getUTCTime:(void(^)(NSArray *))completion;

+ (void)clickPraise:(NSString *)cId and:(NSInteger)praiseCount completion:(void(^)(NSInteger count))completion;

+ (void)getRadioChannelDetail:(NSString *)broadid completion:(void (^)(EZChannelItem *))completion;


+ (EZShowItem *)getLiveItem:(NSArray *)dataArr andServerTime:(NSTimeInterval )serverTime;


- (NSTimeInterval )returnTodayStartTime:(NSTimeInterval )serVerTime locaTime:(NSTimeInterval )locaTime;

+ (NSArray *)getTodayList:(NSArray *)dataArray andServerTime:(NSTimeInterval )serverTime;
+ (NSArray *)getYersterdayList:(NSArray *)dataArray andServerTime:(NSTimeInterval )serverTime;
+ (NSArray *)getTomorrowList:(NSArray *)dataArray andServerTime:(NSTimeInterval )serverTime;

+ (NSArray *)getNewDataArray:(NSArray *)dataArr andServerTime:(NSTimeInterval )serverTime;
+ (NSArray *)getLookbackArray:(NSArray *)dataArr andServerTime:(NSTimeInterval )serverTime;
+ (NSArray *)getLookBackURLArray:(NSArray *)dataArr andServerTime:(NSTimeInterval )serverTime;

+ (NSArray *)getAvailableListArray:(NSArray *)dataArr andServerTime:(NSTimeInterval )serverTime;

- (void)displayRadioStatusBar;
- (void)hiddenRadioStatusBar;

- (void)deprecatManager;

@end
