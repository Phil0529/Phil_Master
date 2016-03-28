//
//  LoadItem.m
//  HuaXia
//
//  Created by Lee, Bo on 15/3/31.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "LoadItem.h"

@implementation LoadItem

@synthesize isLoading = _isLoading;
@synthesize isComplete = _isComplete;
@synthesize pageIndex = _pageIndex;
@synthesize pageSize = _pageSize;
@synthesize dataArray = _dataArray;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pageIndex = 0;
        _isLoading = YES;
        _isComplete = NO;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:_pageIndex forKey:@"loaditempageindex"];
    [aCoder encodeInteger:_pageSize forKey:@"loaditempagesize"];
    [aCoder encodeObject:_dataArray forKey:@"loaditemarray"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _isLoading = NO;
        _isComplete = NO;
        _pageIndex = [aDecoder decodeIntegerForKey:@"loaditempageindex"];
        _pageSize = [aDecoder decodeIntegerForKey:@"loaditempagesize"];
        _dataArray = [aDecoder decodeObjectForKey:@"loaditemarray"];
    }
    return self;
}

@end
