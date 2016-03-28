//
//  LoadItem.h
//  HuaXia
//
//  Created by Lee, Bo on 15/3/31.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadItem : NSObject<NSCoding>

@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) BOOL isComplete;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

