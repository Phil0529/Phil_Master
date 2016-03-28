//
//  NewsManager.h
//  HuaXia
//
//  Created by Lee, Bo on 15/3/31.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EZMediaItem.h"

@interface EZMediaManager: NSObject

+ (EZMediaManager *)sharedManager;

- (NSArray *)getMediaListWithCid:(NSInteger)cid area:(NSInteger)area hangye:(NSInteger)hangye title:(NSString *)title tag:(NSString *)tag type:(NSInteger)type pageSize:(NSInteger)pageSize;

- (void)loadMediaListWithCid:(NSInteger)cid area:(NSInteger)area hangye:(NSInteger)hangye title:(NSString *)title tag:(NSString *)tag type:(NSInteger)type pageSize:(NSInteger)pageSize completion:(void(^)(NSArray *result ,BOOL changed, BOOL complete))completion;

- (BOOL)refreshMediaWithCid:(NSInteger)cid area:(NSInteger)area hangye:(NSInteger)hangye title:(NSString *)title tag:(NSString *)tag type:(NSInteger)type pageSize:(NSInteger)pageSize;

@end
