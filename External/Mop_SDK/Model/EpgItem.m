//
//  EpgItem.m
//  SWMOP
//
//  Created by Lee, Bo on 11/4/14.
//  Copyright (c) 2014 Sunniwell. All rights reserved.
//

#import "EpgItem.h"

@implementation EpgItem

@synthesize mTitle;
@synthesize mStartUtc;
@synthesize mEndUtc;

- (id) initWithJsonObject:(NSDictionary *)jsonItem
{
    if(jsonItem&&jsonItem != (id)[NSNull null])
    {
        self = [super init];
        if(self)
        {
            id tmp = [jsonItem objectForKey:@"title"];
            if(tmp && tmp != [NSNull null])
            {
                self.mTitle = tmp;
            } else {
                self.mTitle = @"";
            }
            
            tmp = [jsonItem objectForKey:@"utc"];
            if(tmp && tmp != [NSNull null])
            {
                self.mStartUtc = [tmp doubleValue] / 1000;
            }else{
                self.mStartUtc = 0.0;
            }
            
            tmp = [jsonItem objectForKey:@"endUtc"];
            if(tmp && tmp != [NSNull null])
            {
                self.mEndUtc = [tmp doubleValue] / 1000;
            }else{
                self.mEndUtc = 0.0;
            }
        }
        return self;
    }
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.mTitle forKey:@"EpgItemTitle"];
    [aCoder encodeInteger:self.mStartUtc forKey:@"EpgItemUtc"];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.mTitle = [aDecoder decodeObjectForKey:@"EpgItemTitle"];
        self.mStartUtc = [aDecoder decodeIntegerForKey:@"EpgItemUtc"];
    }
    
    return self;
}

- (id) copyWithZone:(NSZone *)zone
{
    EpgItem *item = [[[self class] allocWithZone:zone] init];
    item.mTitle = self.mTitle;
    item.mStartUtc = self.mStartUtc;
    item.mEndUtc = self.mEndUtc;
    return item;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"EpgItem title=%@ StartUtc=%0.f EndUtc=%0.f", self.mTitle, self.mStartUtc, self.mEndUtc];
}

@end
