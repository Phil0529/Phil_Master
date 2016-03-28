//
//  SubscribeItem.m
//  SWMOP
//
//  Created by Lee, Bo on 14/12/11.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import "SubscribeItem.h"
#import "XmlDataParser.h"

@implementation SubscribeItem

@end

@implementation SubscribeCollect

- (id)initWithXml:(NSString*)xmlStr andUser:(NSString*)user
{
    self = [super init];
    if (self) {
        _mUserId = user;
        _mDataArray = [[NSMutableArray alloc]init];
        if (xmlStr) {
            XmlDataParser *parser = [[XmlDataParser alloc]init];
            [parser startParse:xmlStr completion:^(NSArray *list) {
                for (xmlElement *elem in list) {
                    if (elem.NodeName&& [elem.NodeName isEqualToString:@"subscribelist"]) {
                        NSString *user_id = [elem.NodeAttrs objectForKey:@"user"];
                        if (user_id && [user_id isEqualToString:user]) {
                            SubscribeItem *item = [[SubscribeItem alloc] init];
                            item.mUserId = [elem.NodeAttrs objectForKey:@"user"];
                            item.mServiceId = [elem.NodeAttrs objectForKey:@"sid"];
                            item.mStartUtc = [[elem.NodeAttrs objectForKey:@"start_utc"] integerValue];
                            item.mEndUtc = [[elem.NodeAttrs objectForKey:@"end_utc"] integerValue];
                            item.mPrice = [[elem.NodeAttrs objectForKey:@"price"] integerValue];
                            [_mDataArray addObject:item];
                        }
                    }
                }
            }];
        }
    }
    return self;
}

@end