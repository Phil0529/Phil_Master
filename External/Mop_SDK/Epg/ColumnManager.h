//
//  ColumnManager.h
//  SWMOP
//
//  Created by Lee, Bo on 14-10-11.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ColumnItem.h"

@interface ColumnManager : NSObject

+ (id)sharedInstance;

- (void)getSubColumns:(NSInteger)pid completion:(void(^)(NSArray *list, NSError *error))completion;

- (ColumnItem*)getColumnItem:(NSInteger)columnId;

- (NSInteger)getColumnItemPid:(NSInteger)columnId;

- (void)queryColumnItem:(NSInteger)columnId pid:(NSInteger)pid title:(NSString *)title completion:(void(^)(ColumnItem *item, NSError *error))completion;

- (void)clearCache;

@end
