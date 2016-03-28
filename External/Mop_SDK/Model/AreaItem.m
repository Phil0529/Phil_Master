//
//  AreaItem.m
//  SWMOP
//
//  Created by Lee, Bo on 11/4/14.
//  Copyright (c) 2014 Sunniwell. All rights reserved.
//

#import "AreaItem.h"

@implementation AreaItem

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:self.mId forKey:@"AreaItemId"];
    [aCoder encodeObject:self.mTitle forKey:@"AreaItemTitle"];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.mId = [aDecoder decodeIntegerForKey:@"AreaItemId"];
        self.mTitle = [aDecoder decodeObjectForKey:@"AreaItemTitle"];
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
        }
        
        return self;
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    AreaItem *item = [[[self class] allocWithZone:zone] init];
    item.mId = _mId;
    item.mTitle = _mTitle;
    return item;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"AreaItem id=%d title=%@", self.mId, self.mTitle];
}

@end
