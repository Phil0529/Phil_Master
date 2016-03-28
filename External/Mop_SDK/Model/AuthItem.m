//
//  AuthItem.m
//  SWMOP
//
//  Created by Lee, Bo on 14/12/12.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import "AuthItem.h"
#import "XmlDataParser.h"

@implementation AuthItem

@synthesize result = _result;
@synthesize allow_watch_duration = _allow_watch_duration;

- (id)initWithXml:(NSString *)xmlStr
{
    self =[super init];
    if (self) {
        if (xmlStr) {
            XmlDataParser *parser = [[XmlDataParser alloc]init];
            [parser startParse:xmlStr completion:^(NSArray *list) {
                for (xmlElement *elem in list) {
                    if (elem.NodeName && [elem.NodeName isEqualToString:@"result"]) {
                        _result = [elem.NodeValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    } else if (elem.NodeName && [elem.NodeName isEqualToString:@"allow_watch_duration"]) {
                        _allow_watch_duration = 0;
                        NSString *alduration = [elem.NodeValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        if (alduration && alduration.length > 0) {
                            _allow_watch_duration = [alduration integerValue];
                            if (_allow_watch_duration > 0) {
                                //容差1分钟
                                _allow_watch_duration = _allow_watch_duration - 60 > 0 ? _allow_watch_duration - 60 : 0;
                                
                            }
                        }
                    }
                }
            }];
        }
    }
    return self;
}

@end
