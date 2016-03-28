//
//  EZColumnManager.h
//  HuaXia
//
//  Created by Lee, Bo on 15/3/31.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EZColumnItem.h"
#import "RefreshDelegate.h"

#define COLUMN_ROOT 0

@interface EZColumnManager : NSObject

@property (nonatomic, assign) id<RefreshDelegate> delegate;

+ (EZColumnManager *)sharedManager;

- (void)getColumnArrayByPid:(NSInteger)pid completion:(void(^)(NSArray *result))completion;

- (NSArray *)getColumnArrayByPid:(NSInteger)pid;

- (void)getColumnMapFromNetByPid:(NSInteger)pid completion:(void (^)(NSArray *))completion;

- (void)saveDataToCache;

- (void)changeItemValue:(EZColumnItem *)item;

- (void)refreshColumnMap;

@end
