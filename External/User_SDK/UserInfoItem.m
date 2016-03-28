//
//  UserInfoItem.m
//  EZTV
//
//  Created by Sunni on 15/6/5.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "UserInfoItem.h"

@implementation UserInfoItem

@synthesize userCookie = _userCookie;
@synthesize userID = _userID;
@synthesize headImg = _headImg;
@synthesize nickName = _nickName;
@synthesize mpno = _mpno;
@synthesize gender = _gender;

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_userCookie forKey:@"userCookie"];
    [aCoder encodeObject:_userID forKey:@"userId"];
    [aCoder encodeObject:_headImg forKey:@"userHeadImg"];
    [aCoder encodeObject:_nickName forKey:@"usernickname"];
    [aCoder encodeObject:_mpno forKey:@"usermpno"];
    [aCoder encodeInteger:_gender forKey:@"usergender"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _userCookie = [aDecoder decodeObjectForKey:@"userCookie"];
        _userID = [aDecoder decodeObjectForKey:@"userId"];
        _headImg = [aDecoder decodeObjectForKey:@"userHeadImg"];
        _nickName = [aDecoder decodeObjectForKey:@"usernickname"];
        _mpno = [aDecoder decodeObjectForKey:@"usermpno"];
        _gender = [aDecoder decodeIntegerForKey:@"usergender"];
    }
    return self;
}

@end
