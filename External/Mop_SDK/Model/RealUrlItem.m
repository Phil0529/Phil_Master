//
//  RealUrlItem.m
//  SWMOP
//
//  Created by Lee, Bo on 11/4/14.
//  Copyright (c) 2014 Sunniwell. All rights reserved.
//

#import "RealUrlItem.h"

@implementation RealUrlItem

- (id) initWithJsonObject:(NSDictionary *)jsonItem
{
    if(jsonItem != nil && jsonItem != (id)[NSNull null])
    {
        self = [super init];
        if(self)
        {
            id tmp = [jsonItem objectForKey:@"url"];
            if(tmp != nil && tmp != [NSNull null])
            {
                self.mUrl = tmp;
            }
            else
            {
                self.mUrl = @"";
            }
            
            tmp = [jsonItem objectForKey:@"title"];
            if(tmp != nil && tmp != [NSNull null])
            {
                self.mTitle = tmp;
            }
            else
            {
                self.mTitle = @"";
            }
            
            tmp = [jsonItem objectForKey:@"qualitys"];
            if(tmp != nil && tmp != [NSNull null])
            {
                self.mQualitys = tmp;
            }
            else
            {
                self.mQualitys = @"";
            }
            
            tmp = [jsonItem objectForKey:@"quality"];
            if(tmp != nil && tmp != [NSNull null])
            {
                self.mQuality = [tmp integerValue];
            }
            else
            {
                self.mQuality = QUALITY_UNKNOWN;
            }
        }
        
        return self;
    }
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.mUrl forKey:@"RealUrlUrl"];
    [aCoder encodeObject:self.mTitle forKey:@"RealUrlTitle"];
    [aCoder encodeObject:self.mQualitys forKey:@"RealUrlQualitys"];
    [aCoder encodeInteger:self.mQuality forKey:@"RealUrlQuality"];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.mUrl = [aDecoder decodeObjectForKey:@"RealUrlUrl"];
        self.mTitle = [aDecoder decodeObjectForKey:@"RealUrlTitle"];
        self.mQualitys = [aDecoder decodeObjectForKey:@"RealUrlQualitys"];
        self.mQuality = [aDecoder decodeIntegerForKey:@"RealUrlQuality"];
    }
    
    return self;
}

- (id) copyWithZone:(NSZone *)zone
{
    RealUrlItem *item = [[RealUrlItem alloc] init];
    if(item)
    {
        item.mUrl = self.mUrl;
        item.mTitle = self.mTitle;
        item.mQualitys = self.mQualitys;
        item.mQuality = self.mQuality;
    }
    
    return item;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"RealUrlItem url=%@ title=%@ qualitys=%@ quality=%ld", self.mUrl, self.mTitle, self.mQualitys, (long)self.mQuality];
}

@end
