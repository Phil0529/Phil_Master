//
//  SyncItem.m
//  SWMOP
//
//  Created by Lee, Bo on 11/4/14.
//  Copyright (c) 2014 Sunniwell. All rights reserved.
//

#import "SyncItem.h"

@implementation SyncItem

- (id) initWithJsonObject:(NSDictionary *)jsonItem
{
    if(jsonItem&&jsonItem != (id)[NSNull null])
    {
        self = [super init];
        if(self)
        {
            id tmp = [jsonItem objectForKey:@"id"];
            if(tmp && tmp != [NSNull null])
            {
                self.mColumnId = [tmp integerValue];
            }
            else
            {
                self.mColumnId = -1;
            }
            
            tmp = [jsonItem objectForKey:@"sync"];
            if(tmp && tmp != [NSNull null])
            {
                self.mSyncNum = [tmp integerValue];
            }
            else
            {
                self.mColumnId = -1;
                self.mSyncNum = 0;
            }
            
            tmp = [jsonItem objectForKey:@"lastSync"];
            if (tmp && tmp != [NSNull null]) {
                self.mLastSyncNum = [tmp integerValue];
            }
            else
            {
                self.mLastSyncNum = 0;
            }
        }
        return self;
    }
    return nil;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:self.mColumnId forKey:@"SyncItemColumnId"];
    [aCoder encodeInteger:self.mSyncNum forKey:@"SyncItemSyncNumber"];
    [aCoder encodeInteger:self.mLastSyncNum forKey:@"lastsyncnumber"];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.mColumnId = [aDecoder decodeIntegerForKey:@"SyncItemColumnId"];
        self.mSyncNum = [aDecoder decodeIntegerForKey:@"SyncItemSyncNumber"];
        self.mLastSyncNum = [aDecoder decodeIntegerForKey:@"lastsyncnumber"];
    }
    return self;
}

- (id) copyWithZone:(NSZone *)zone
{
    SyncItem *newItem = [[[self class] allocWithZone:zone]init];
    newItem.mColumnId = self.mColumnId;
    newItem.mSyncNum = self.mSyncNum;
    newItem.mLastSyncNum = self.mLastSyncNum;
    return newItem;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"SyncItem columnId=%ld syncNumber=%ld", (long)self.mColumnId, (long)self.mSyncNum];
}

@end

