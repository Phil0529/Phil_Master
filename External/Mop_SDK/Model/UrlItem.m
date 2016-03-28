//
//  UrlItem.m
//  SWMOP
//
//  Created by Lee, Bo on 11/4/14.
//  Copyright (c) 2014 Sunniwell. All rights reserved.
//

#import "UrlItem.h"

@implementation UrlItem

@synthesize mUrl = _mUrl;
@synthesize mSerial = _mSerial;
@synthesize mIsFinal = _mIsFinal;
@synthesize mProvider = _mProvider;
@synthesize mQuality = _mQuality;
@synthesize mTitle = _mTitle;
@synthesize mDescription = _mDescription;
@synthesize mImage = _mImage;
@synthesize mThumbnail = _mThumbnail;

- (id)initWithJsonObject:(NSDictionary *)jsonItem
{
    if(jsonItem&& jsonItem != (id)[NSNull null])
    {
        self = [super init];
        if(self)
        {
            id tmp = [jsonItem objectForKey:@"url"];
            _mUrl = tmp && tmp != [NSNull null] ? tmp : @"";
            
            tmp = [jsonItem objectForKey:@"serial"];
            _mSerial = tmp && tmp != [NSNull null] ? [tmp integerValue] : 1;
            
            tmp = [jsonItem objectForKey:@"isfinal"];
            _mIsFinal = tmp && tmp != [NSNull null] ? [tmp integerValue] : YES;
            
            tmp = [jsonItem objectForKey:@"provider"];
            _mProvider = tmp && tmp != [NSNull null] ? tmp : @"";
            
            tmp = [jsonItem objectForKey:@"quality"];
            _mQuality  = tmp && tmp != [NSNull null] ? [tmp integerValue] : QUALITY_UNKNOWN;
            
            tmp = [jsonItem objectForKey:@"title"];
            _mTitle = tmp && tmp != [NSNull null] ? tmp : @"";
            
            tmp = [jsonItem objectForKey:@"image"];
            _mImage = tmp && tmp != [NSNull null] ? tmp : @"";
            
            tmp = [jsonItem objectForKey:@"thumbnail"];
            _mThumbnail = tmp && tmp != [NSNull null] ? tmp : @"";
            
            tmp = [jsonItem objectForKey:@"description"];
            _mDescription = tmp && tmp != [NSNull null] ? tmp : @"";
        }
        
        return self;
    }
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_mUrl forKey:@"UrlItemUrl"];
    [aCoder encodeInteger:_mSerial forKey:@"UrlItemSerial"];
    [aCoder encodeInteger:_mIsFinal forKey:@"UrlItemIsFinal"];
    [aCoder encodeObject:_mProvider forKey:@"UrlItemProvider"];
    [aCoder encodeInteger:_mQuality forKey:@"UrlItemQuality"];
    [aCoder encodeObject:_mTitle forKey:@"UrlItemTitle"];
    [aCoder encodeObject:_mDescription forKey:@"UrlItemDescription"];
    [aCoder encodeObject:_mThumbnail forKey:@"UrlItemThumbnail"];
    [aCoder encodeObject:_mImage forKey:@"UrlItemImage"];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        _mUrl = [aDecoder decodeObjectForKey:@"UrlItemUrl"];
        _mSerial = [aDecoder decodeIntegerForKey:@"UrlItemSerial"];
        _mIsFinal = [aDecoder decodeIntegerForKey:@"UrlItemIsFinal"];
        _mProvider = [aDecoder decodeObjectForKey:@"UrlItemProvider"];
        _mQuality = [aDecoder decodeIntegerForKey:@"UrlItemQuality"];
        _mTitle = [aDecoder decodeObjectForKey:@"UrlItemTitle"];
        _mDescription = [aDecoder decodeObjectForKey:@"UrlItemDescription"];
        _mThumbnail = [aDecoder decodeObjectForKey:@"UrlItemThumbnail"];
        _mImage = [aDecoder decodeObjectForKey:@"UrlItemImage"];

    }
    
    return self;
}

- (id) copyWithZone:(NSZone *)zone
{
    UrlItem *item = [[[self class] allocWithZone:zone] init];
    item.mUrl = _mUrl;
    item.mSerial = _mSerial;
    item.mIsFinal = _mIsFinal;
    item.mProvider = _mProvider;
    item.mQuality = _mQuality;
    item.mTitle = _mTitle;
    item.mImage = _mImage;
    item.mThumbnail = _mThumbnail;
    item.mDescription = _mDescription;
    return item;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"UrlItem url=%@ serial=%ld isfinal=%d provider=%@ quality=%ld title=%@", _mUrl, (long)_mSerial, _mIsFinal, _mProvider, (long)_mQuality, _mTitle];
}

@end
