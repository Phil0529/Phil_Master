//
//  CategoryItem.m
//  SWMOP
//
//  Created by Lee, Bo on 11/6/14.
//  Copyright (c) 2014 Sunniwell. All rights reserved.
//

#import "CategoryItem.h"

@implementation CategoryItem

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:self.mId forKey:@"CategoryItemId"];
    [aCoder encodeObject:self.mTitle forKey:@"CategoryItemTitle"];
    [aCoder encodeInteger:self.mTotal forKey:@"CategoryItemTotal"];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.mId = [aDecoder decodeIntegerForKey:@"CategoryItemId"];
        self.mTitle = [aDecoder decodeObjectForKey:@"CategoryItemTitle"];
        self.mTotal = [aDecoder decodeIntegerForKey:@"CategoryItemTotal"];
    }
    
    return self;
}

- (id) initWithJsonObject:(NSDictionary *)jsonItem
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
            
            tmp = [jsonItem objectForKey:@"title"];
            if(tmp && tmp != [NSNull null])
            {
                self.mTitle = tmp;
            }
            else
            {
                self.mTitle = @"";
            }
            
            tmp = [jsonItem objectForKey:@"total"];
            if(tmp && tmp != [NSNull null])
            {
                self.mTotal = [tmp integerValue];
            }
            else
            {
                self.mTotal = 0;
            }
        }
        
        return self;
    }
    
    return nil;
}

- (id) copyWithZone:(NSZone *)zone
{
    CategoryItem *item = [[[self class] allocWithZone:zone] init];
    item.mId = self.mId;
    item.mTitle = self.mTitle;
    item.mTotal = self.mTotal;
    
    return item;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"CategoryItem id=%ld title=%@ total=%ld", (long)self.mId, self.mTitle, (long)self.mTotal];
}

@end
