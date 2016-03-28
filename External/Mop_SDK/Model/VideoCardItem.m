//
//  VideoCardItem.m
//  SWMOP
//
//  Created by Lee, Bo on 14/12/11.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import "VideoCardItem.h"
#import "XmlDataParser.h"

@implementation VideoCardItem

- (id)initWithXml:(NSString *)xmlStr
{
    self =[super init];
    if (self) {
        if (xmlStr) {
            XmlDataParser *parser = [[XmlDataParser alloc]init];
            [parser startParse:xmlStr completion:^(NSArray *list) {
                for (xmlElement *elem in list) {
                    if (elem.NodeName&& [elem.NodeName isEqualToString:@"info"]) {
                        _mCardNo = [elem.NodeAttrs objectForKey:@"card_id"];
                        _mAmount = [[elem.NodeAttrs objectForKey:@"amount"] integerValue];
                        _mUsed = [[elem.NodeAttrs objectForKey:@"used"] integerValue];
                    }
                }
            }];
        }
    }
    return self;
}

@end
