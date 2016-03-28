//
//  ColumnItem.m
//  SWMOP
//
//  Created by Lee, Bo on 11/4/14.
//  Copyright (c) 2014 Sunniwell. All rights reserved.
//

#import "ColumnItem.h"

@implementation ColumnItem

- (id) initWithJosnObject:(NSDictionary *)jsonItem
{
    if(jsonItem&& jsonItem != (id)[NSNull null])
    {
        self = [super init];
        if(self)
        {
            id tmp = [jsonItem objectForKey:@"id"];
            if(tmp && tmp != [NSNull null])
            {
                self.mId = [tmp integerValue];
            }
            else
            {
                self.mId = 0;
            }
            
            tmp = [jsonItem objectForKey:@"pid"];
            if(tmp && tmp != [NSNull null])
            {
                self.mPid = [tmp integerValue];
            }
            else
            {
                self.mPid = -1;
            }
            
            tmp = [jsonItem objectForKey:@"title"];
            if(tmp && tmp != [NSNull null])
            {
                self.mTitle = tmp;
            }
            else
            {
                self.mTitle = @"";
            }
            
            tmp = [jsonItem objectForKey:@"type"];
            if(tmp && tmp != [NSNull null])
            {
                self.mType = tmp;
            }
            else
            {
                self.mType = @"";
            }
            
            tmp = [jsonItem objectForKey:@"leaf"];
            if(tmp && tmp != [NSNull null])
            {
                self.mLeaf = [tmp integerValue];
            }
            else
            {
                self.mLeaf = NO;
            }
        }
        
        return self;
    }
    
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:self.mId forKey:@"ColumnItemId"];
    [aCoder encodeInteger:self.mPid forKey:@"ColumnItemPid"];
    [aCoder encodeObject:self.mTitle forKey:@"ColumnItemTitle"];
    [aCoder encodeObject:self.mType forKey:@"ColumnItemType"];
    [aCoder encodeInteger:self.mLeaf forKey:@"ColumnItemLeaf"];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.mId = [aDecoder decodeIntegerForKey:@"ColumnItemId"];
        self.mPid = [aDecoder decodeIntegerForKey:@"ColumnItemPid"];
        self.mTitle = [aDecoder decodeObjectForKey:@"ColumnItemTitle"];
        self.mType = [aDecoder decodeObjectForKey:@"ColumnItemType"];
        self.mLeaf = [aDecoder decodeIntegerForKey:@"ColumnItemLeaf"];
    }
    
    return self;
}

- (id) copyWithZone:(NSZone *)zone
{
    ColumnItem *newItem = [[[self class] allocWithZone:zone]init];
    newItem.mId = self.mId;
    newItem.mPid = self.mPid;
    newItem.mTitle = self.mTitle;
    newItem.mType = self.mType;
    newItem.mLeaf = self.mLeaf;
    
    return newItem;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"ColumnItem id=%ld pid=%ld title=%@ type=%@ leaf=%d", (long)self.mId, (long)self.mPid, self.mTitle, self.mType, self.mLeaf];
}

@end