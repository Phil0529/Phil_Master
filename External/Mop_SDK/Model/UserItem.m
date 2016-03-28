//
//  UserItem.m
//  SWMOP
//
//  Created by Lee, Bo on 14/12/11.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import "UserItem.h"
#import "XmlDataParser.h"

@implementation UserItem

- (id)initWithXml:(NSString*)xmlStr andUser:(NSString *)user;
{
    self = [super init];
    if (self) {
        if (xmlStr) {
            XmlDataParser *parser = [[XmlDataParser alloc]init];
            [parser startParse:xmlStr completion:^(NSArray *list) {
                for (xmlElement *elem in list) {
                    if (elem.NodeName&& [elem.NodeName isEqualToString:@"info"]) {
                        NSString *user_id = [elem.NodeAttrs objectForKey:@"user"];
                        if (user_id && [user_id isEqualToString:user]) {
                            _mUserId = user_id;
                            _mPassword = [elem.NodeAttrs objectForKey:@"password"];
                            _mRealname = [elem.NodeAttrs objectForKey:@"realname"];
                            _mCountry = [elem.NodeAttrs objectForKey:@"country"];
                            _mEmail = [elem.NodeAttrs objectForKey:@"email"];
                            _mAddr = [elem.NodeAttrs objectForKey:@"addr"];
                            _mPhone = [elem.NodeAttrs objectForKey:@"phone"];
                            _mMobile = [elem.NodeAttrs objectForKey:@"mobile"];
                            _mPostcode = [elem.NodeAttrs objectForKey:@"postcode"];
                            _mBirthday = [elem.NodeAttrs objectForKey:@"birthday"];
                            _mTermcnt = [[elem.NodeAttrs objectForKey:@"termcnt"]integerValue];
                            _mAllowst = [[elem.NodeAttrs objectForKey:@"allowst"]integerValue];
                            _mBalances = [[elem.NodeAttrs objectForKey:@"amount"]integerValue];
                            _mEnableUtc = [[elem.NodeAttrs objectForKey:@"enable_utc"]integerValue];
                            _mValidtoUtc = [[elem.NodeAttrs objectForKey:@"validto_utc"]integerValue];
                        }
                    }
                }
            }];
        }
    }
    return self;
}

@end
