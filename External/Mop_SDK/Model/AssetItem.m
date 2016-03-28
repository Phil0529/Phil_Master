//
//  AssetItem.m
//  SWMOP
//
//  Created by Lee, Bo on 14/12/11.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import "AssetItem.h"
#import "XmlDataParser.h"

@implementation AssetItem

@end

@implementation AssetCollect

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
                    if (elem.NodeName&& [elem.NodeName isEqualToString:@"assetlist"]) {
                        NSString *user_id = [elem.NodeAttrs objectForKey:@"user"];
                        if (user_id && [user_id isEqualToString:user]) {
                            AssetItem *item = [[AssetItem alloc] init];
                            item.mUserId = [elem.NodeAttrs objectForKey:@"user"];
                            item.mServiceId = [elem.NodeAttrs objectForKey:@"sid"];
                            item.mOpType = [[elem.NodeAttrs objectForKey:@"op_type"] integerValue];
                            item.mOpAmount = [[elem.NodeAttrs objectForKey:@"op_amount"] integerValue];
                            item.mOpUtc = [[elem.NodeAttrs objectForKey:@"op_utc"] integerValue];
                            item.mBalances = [[elem.NodeAttrs objectForKey:@"balances"] integerValue];
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

