
//
//  EZBroadcastManager.m
//  EZTV
//
//  Created by 肖翰程 on 9/23/15.
//  Copyright © 2015 Joygo. All rights reserved.
//

#import "EZBroadcastManager.h"
#import "UserCenter.h"
#import "AFCMSClient.h"
#import "NSDate+Helper.h"


@implementation EZBroadcastManager

+(instancetype)shareInstance{
    static EZBroadcastManager *broadcastManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        broadcastManager = [[EZBroadcastManager alloc] init];
        broadcastManager.isDisplayRadioStatusBar = YES;
    });
    return broadcastManager;
}


- (void)getDataArr:(NSArray *)array
{
    self.dataArray = [[NSArray alloc]initWithArray:array];
}

+ (void)getMyUploadArraybyMpnoPhil:(NSString *)broadid completion:(void (^)(NSArray *))completion{
    NSDictionary *params = @{@"broadid":broadid,
                             OS_KEY:OS_VERSION,
                             PROJECT_KEY:PROJECT_ID,
                             VER_KEY:REVIEW_VER};
    AFCMSClient *cmsClient = [[AFCMSClient alloc] init];
    [cmsClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    [cmsClient GET:ACTION_GET_BROADCAST_DETAIL parameters:params success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
             NSArray *list = [(NSDictionary *)responseObject objectForKey:@"list"];
             if (list) {
                 NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[list count]];
                 for (NSDictionary *jsonItem in list) {
                     EZRadioItem *item = [[EZRadioItem alloc] initWithJsonData:jsonItem];
                     [result addObject:item];
                 }
                 if (completion) {
                     completion(result);
                 }
                 return;
             }
         }
         if (completion) {
             completion(nil);
         }
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         if (completion) {
             completion(nil);
         }
     }];
}


+ (void)getBroadcastList:(void(^)(NSArray *))completion{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY,
                            REVIEW_VER,VER_KEY, nil];
    AFCMSClient *cmsClient = [[AFCMSClient alloc] init];
    [cmsClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    
    [cmsClient GET:ACTION_GET_BROADCASTLIST parameters:params success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
             NSArray *list = [(NSDictionary *)responseObject objectForKey:@"list"];
             if (list) {
                 NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[list count]];
                 for (NSDictionary *jsonItem in list) {
                     EZChannelItem *item = [[EZChannelItem alloc] initWithJsonData:jsonItem];
                     [result addObject:item];
                 }
                 if (completion) {
                     completion(result);
                 }
                 return;
             }
         }          if (completion) {
             completion(nil);
         }
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         if (completion) {
             completion(nil);
         }
     }];
    
}

+ (void)getBroadcastListDetail:(NSString *)broadid startTime:(NSString *)startTime endTime:(NSString *)endTime completion:(void (^)(NSArray *))completion{
    NSDictionary *params = @{@"broadid":broadid,
                             @"stime":startTime,
                             @"etime":endTime,
                             OS_KEY:OS_VERSION,
                             PROJECT_KEY:PROJECT_ID};

    
    AFCMSClient *cmsClient = [[AFCMSClient alloc] init];
    [cmsClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    
    [cmsClient GET:ACTION_GET_BROADCAST_DETAIL parameters:params success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
             NSArray *list = [(NSDictionary *)responseObject objectForKey:@"list"];
             if (list) {
                 NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[list count]];
                 for (NSDictionary *jsonItem in list) {
                     EZShowItem *item = [[EZShowItem alloc]initWithJsonData:jsonItem];
                     [result addObject:item];
                 }
                 if (completion) {
                     completion(result);
                 }
                 return;
             }
         }
         if (completion) {
             completion(nil);
         }
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         SWLogD(@"error = %@",error.description);
         if (completion) {
             completion(nil);
         }
     }];
    
}

+ (void)getUTCTime:(void (^)(NSArray *))completion
{
    AFCMSClient *cmsClient = [[AFCMSClient alloc] init];
    [cmsClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    [cmsClient GET:ACTION_GET_UTC_TIME parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
             NSDictionary *list = [(NSDictionary *)responseObject objectForKey:@"data"];
             if (list) {
                 NSArray *utc = [[NSArray alloc]initWithObjects:[list objectForKey:@"utc"], nil];
                 if (completion) {
                     completion(utc);
                 }
                 return;
             }
         }
         if (completion) {
             completion(nil);
         }
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         SWLogD(@"error = %@",error.description);
         if (completion) {
             completion(nil);
         }
     }];
}
+ (void)clickPraise:(NSString *)cId and:(NSInteger)praiseCount completion:(void(^)(NSInteger count))completion
{
    NSDictionary *params = @{@"_id":cId,
                             @"assistcount":@(praiseCount),
                             OS_KEY:OS_VERSION,
                             PROJECT_KEY:PROJECT_ID,
                             VER_KEY:REVIEW_VER};
    AFCMSClient *cmsClient = [[AFCMSClient alloc] init];
    [cmsClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    [cmsClient POST:ACTION_PRAISE_POST
                          parameters:params
                             success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *data =  [responseObject objectForKey:@"data"];
         if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
             
             id code = [(NSDictionary *)responseObject objectForKey:@"code"];
             if (code && [code integerValue] == 1) {
                 if (completion) {
                     completion([[data objectForKey:@"assistcount"] integerValue]);
                 }
                 return;
             }
         }
//         if (completion) {
//             completion([[data objectForKey:@"assistcount"] integerValue]);
//         }
     }
                             failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         if (completion) {
             completion(0);
         }
     }];
    
}

- (NSTimeInterval )returnTodayStartTime:(NSTimeInterval )serVerTime locaTime:(NSTimeInterval )locaTime{
    NSTimeZone    *timeZone   = [NSTimeZone timeZoneWithName:@"CCT"];
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"HH:mm:ss.SS"];
    NSDate *serverDate = [NSDate dateWithTimeIntervalSince1970:serVerTime];
    
    NSDate *date = [serverDate beginningOfDay];
    NSTimeInterval beginDayTimeInterval = [date timeIntervalSince1970];
    return beginDayTimeInterval;
}


+ (NSArray *)getTodayList:(NSArray *)dataArray andServerTime:(NSTimeInterval )serverTime{
    
    NSMutableArray *arr = [NSMutableArray array];
    NSTimeInterval theDayBefore = serverTime - [NSDate getTodayFormer:serverTime] - 24*3600.f ;
    NSTimeInterval theDayBehind = [NSDate getTodayBehind:serverTime] + 24*3600.f + serverTime -1.f;
    
    for (EZShowItem *item in dataArray) {
        
        if (item.startTime >= theDayBefore + 24*3600.f && item.startTime <theDayBehind - 24* 3600.f) {
            //回放的条目
            if (item.startTime < serverTime) {
                item.playStatus = 0;
            }
            //直播的条目
            if (item.startTime < serverTime && item.endTime > serverTime) {
                item.playStatus = 1;
            }
            //将要播放的条目
            if (item.startTime > serverTime) {
                item.playStatus = 2;
            }
            [arr addObject:item];
        }
    }
    
    
    return arr;
}





+ (NSArray *)getYersterdayList:(NSArray *)dataArray andServerTime:(NSTimeInterval)serverTime{
    NSMutableArray *arr = [NSMutableArray array];
    NSTimeInterval theDayBefore = serverTime - [NSDate getTodayFormer:serverTime] - 24*3600.f ;
    
    for (EZShowItem *item in dataArray) {
        
        if (item.startTime >= theDayBefore && item.startTime < serverTime - [NSDate getTodayFormer:serverTime]) {
            //回放的条目
            if (item.startTime < serverTime) {
                item.playStatus = 0;
            }
            //直播的条目
            if (item.startTime < serverTime && item.endTime > serverTime) {
                item.playStatus = 1;
            }
            //将要播放的条目
            if (item.startTime > serverTime) {
                item.playStatus = 2;
            }
            [arr addObject:item];
        }
    }
    
    
    return arr;
    
}
+ (NSArray *)getTomorrowList:(NSArray *)dataArray andServerTime:(NSTimeInterval)serverTime{
    NSMutableArray *arr = [NSMutableArray array];
    NSTimeInterval theDayBehind = [NSDate getTodayBehind:serverTime] + 24*3600.f + serverTime -1.f;
    
    for (EZShowItem *item in dataArray) {
        if (item.startTime >= [NSDate getTodayBehind:serverTime]
            + serverTime -1.f && item.startTime <= theDayBehind) {
            //回放的条目
            if (item.startTime < serverTime) {
                item.playStatus = 0;
            }
            //直播的条目
            if (item.startTime < serverTime && item.endTime > serverTime) {
                item.playStatus = 1;
            }
            //将要播放的条目
            if (item.startTime > serverTime) {
                item.playStatus = 2;
            }
            [arr addObject:item];
        }
    }
    return arr;
}



+ (EZShowItem *)getLiveItem:(NSArray *)dataArr andServerTime:(NSTimeInterval)serverTime{
    for (EZShowItem *item in dataArr) {
        if (item.playStatus == 1) {
            //            SWLogD(@"测试---->");
            //            SWLogD(@"start %f",item.startTime);
            //            SWLogD(@"end %f",item.endTime);
            //            SWLogD(@"server %f",serverTime);
            return item;
            break;
        }
    }
    return nil;
}

+ (NSArray *)getNewDataArray:(NSArray *)dataArr andServerTime:(NSTimeInterval)serverTime{
    
    NSTimeInterval theDayBefore = serverTime - [NSDate getTodayFormer:serverTime] - 24*3600.f ;
    NSTimeInterval theDayBehind = [NSDate getTodayBehind:serverTime] + 24*3600.f + serverTime -1.f;
    NSMutableArray *newDataArray = [NSMutableArray array];
    
    for (EZShowItem *item in dataArr) {
        if (item.startTime >= theDayBefore && item.startTime <theDayBefore + 24* 3600.f) {
            item.playStatus = 0;
            [newDataArray addObject:item];
        }
        if (item.startTime >= theDayBefore + 24*3600.f && item.startTime <theDayBehind - 24* 3600.f) {
            if (item.startTime < serverTime) {
                item.playStatus = 0;
            }
            if (item.startTime < serverTime && item.endTime > serverTime) {
                item.playStatus = 1;
                //                item.isPlay = 1;
                
            }
            if (item.startTime > serverTime) {
                item.playStatus = 2;
            }
            [newDataArray addObject:item];
        }
        if (item.startTime >= theDayBehind - 24*3600.f && item.startTime <theDayBehind) {
            item.playStatus = 2;
            [newDataArray addObject:item];
        }
    }
    return newDataArray;
    
}

+ (NSArray *)getAvailableListArray:(NSArray *)dataArr andServerTime:(NSTimeInterval )serverTime{
    NSMutableArray *availabelArr = [NSMutableArray array];
    //    for (EZRadioItem *item in dataArr) {
    //        if (item.playStatus == 0 || item.playStatus == 1) {
    //            [availabelArr addObject:item];
    //        }
    //    }
    for (EZShowItem *item in dataArr) {
        if (item.isPlay == 1) {
            [availabelArr addObject:item];
        }
    }
    return (NSArray *)availabelArr;
    
}

+ (NSArray *)getLookbackArray:(NSArray *)dataArr andServerTime:(NSTimeInterval )serverTime{
    NSMutableArray *lookbackArr = [NSMutableArray array];
    for (EZRadioItem *item in dataArr) {
        if (item.playStatus == 0) {
            [lookbackArr addObject:item];
        }
    }
    return lookbackArr;
}

+ (NSArray *)getLookBackURLArray:(NSArray *)dataArr andServerTime:(NSTimeInterval )serverTime{
    NSMutableArray *lookbackArr = [NSMutableArray array];
    for (EZRadioItem *item in dataArr) {
        if (item.playStatus == 0) {
            [lookbackArr addObject:item.url];
        }
    }
    return lookbackArr;
}

+ (void)getRadioChannelDetail:(NSString *)broadid completion:(void (^)(EZChannelItem *))completion{
    NSDictionary *params = @{@"_id":broadid,
                             OS_KEY:OS_VERSION,
                             PROJECT_KEY:PROJECT_ID,
                             VER_KEY:REVIEW_VER};
    AFCMSClient *cmsClient = [[AFCMSClient alloc] init];
    [cmsClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    [cmsClient GET:ACTION_GET_BROADCAS_CHANNEL_DETAIL parameters:params success:^(NSURLSessionDataTask *task, id responseObject)
     {
         id code = [(NSDictionary *)responseObject objectForKey:@"code"];
         if (code && [code integerValue] == 1) {
             
             EZChannelItem *item = [[EZChannelItem alloc]initWithJsonData:[responseObject objectForKey:@"data"]];
             if (completion) {
                 completion(item);
             }
         }
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         SWLogD(@"error = %@",error.description);
         if (completion) {
             completion(nil);
         }
     }];
}


- (UILabel *)statusTitleLabel{
    if (!_statusTitleLabel) {
        _statusTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.f, 0.f, SCREEN_WIDTH-40.f, 20.f)];
        [_statusTitleLabel setFont:[UIFont systemFontOfSize:11.f]];
        [_statusTitleLabel setTextColor:[UIColor whiteColor]];
    }
    return _statusTitleLabel;
    
}

//close->YES open-->no

- (void)tapToPlayRadio:(UITapGestureRecognizer *)tap{
    if(self.delegate && [self.delegate respondsToSelector:@selector(tapToPlayRadioViewController)]){
        [self.delegate tapToPlayRadioViewController];
    }
    else{
//        UIViewController *currentViewController = [self getCurrentVC];
//        [currentViewController.navigationController pushViewController:[EZBroadcastManager shareInstance].playRadioController animated:YES];
    }
}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

- (StatusBarNotificationPhil *)statusBarNotification{
    if (!_statusBarNotification) {
        _statusBarNotification = [[StatusBarNotificationPhil alloc] init];
        [_statusBarNotification setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAllButUpsideDown];
        [_statusBarNotification setNotificationAnimationInStyle: PhilNotificationAnimationStyleTop];
        [_statusBarNotification setNotificationAnimationOutStyle: PhilNotificationAnimationStyleTop];
        [_statusBarNotification setNotificationStyle:PhilNotificationStyleStatusBarNotification];
        [_statusBarNotification setNotificationAnimationType:PhilNotificationAnimationTypeOverlay];
    }
    return _statusBarNotification;
}

- (UIView *)statusBarView{
    if (!_statusBarView) {
        _statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, 20.f)];
        
        UIImageView *playImgBtn = [[UIImageView alloc] initWithImage:IMAGE(@"ic_guangbo_play_top")];
        [playImgBtn setCenter:CGPointMake(10.f, 10.f)];
        [playImgBtn setClipsToBounds:YES];
        [_statusBarView addSubview:playImgBtn];
        
        [_statusBarView addSubview:[EZBroadcastManager shareInstance].statusTitleLabel];
        [_statusBarView setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToPlayRadio:)];
        [_statusBarView addGestureRecognizer:tap];
        
    }
    
    
    return _statusBarView;
}

- (void)displayRadioStatusBar{
    [self.statusBarView setBackgroundColor:RADIO_STATUS_COLOR];
    NSString *string = @"";
    if([EZBroadcastManager shareInstance].presentChannelItem.mainTitle.length > 0 && [EZBroadcastManager shareInstance].presentChannelItem.subTitle.length > 0){
        string = [NSString stringWithFormat:@"%@: %@(%@)",LBLocalized(@"Now playing"),[EZBroadcastManager shareInstance].presentChannelItem.mainTitle,[EZBroadcastManager shareInstance].presentChannelItem.subTitle];
    }
    if ([EZBroadcastManager shareInstance].presentChannelItem.mainTitle.length > 0 && [EZBroadcastManager shareInstance].presentChannelItem.subTitle.length == 0) {
        string = [NSString stringWithFormat:@"%@: %@",LBLocalized(@"Now playing"),[EZBroadcastManager shareInstance].presentChannelItem.mainTitle];
    }
    if ([EZBroadcastManager shareInstance].presentChannelItem.mainTitle.length == 0 && [EZBroadcastManager shareInstance].presentChannelItem.subTitle.length > 0) {
        string = [NSString stringWithFormat:@"%@: %@",LBLocalized(@"Now playing"),[EZBroadcastManager shareInstance].presentChannelItem.mainTitle];
    }
    
    [self.statusTitleLabel setText:string];
//    if (self.playRadioController.canPlayRadio && self.isDisplayRadioStatusBar) {
//        [self.statusBarNotification displayNotificationWithViewPhil:self.statusBarView completion:nil];
//    }
}
- (void)hiddenRadioStatusBar{
    [self.statusBarNotification dismissNotificationWithCompletion:nil];
}
- (void)deprecatManager{
    EZBroadcastManager *manager = [EZBroadcastManager shareInstance];
    manager = nil;
}
@end
