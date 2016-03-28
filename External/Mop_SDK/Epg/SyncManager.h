//
//  SyncManager.h
//  SWMOP
//
//  Created by Lee, Bo on 14-10-11.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SyncItem.h"

@protocol SyncListener <NSObject>
@required
/**
 * 同步码变更回调
 * @param columnId 同步码有变动的栏目id
 */
- (void)onSyncChange:(NSInteger)columnId;

@end

@interface SyncManager : NSObject

// 单例模式
+ (id) sharedInstance;

- (void)addSyncListener:(id<SyncListener>)syncListener;

- (void)removeSyncListener:(id<SyncListener>)syncListener;

- (void)startUpdate:(NSTimeInterval)interval;

@end
