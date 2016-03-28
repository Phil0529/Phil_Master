//
//  EpgManager.h
//  SWMOP
//
//  Created by Lee, Bo on 14-10-11.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EpgItem.h"

@interface EpgManager : NSObject

typedef void(^epgLoadCompletion)(NSArray *list, NSString *channelId, BOOL isloading);

+ (EpgManager*)sharedInstance;

- (void)loadEpgByChannel:(NSString *)channelId andUTC:(NSTimeInterval)utc completion:(epgLoadCompletion)completion;

- (NSArray *)epgListOfChannel:(NSString *)channelId andUTC:(NSTimeInterval)utc;

- (void)clean;

@end
