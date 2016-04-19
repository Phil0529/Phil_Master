//
//  TicketItem.m
//  Master
//
//  Created by Phil Xhc on 4/5/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "TicketItem.h"

@implementation TicketItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"status":@"status",
             @"numer":@"no",
             @"name":@"name",
             @"expires":@"expires",
             @"ticketId":@"uid",
             @"useDate":@"usedate"
             };
}

@end

@implementation TicketItemResponseMessage

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{};
}

@end

@implementation TicketItemResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"code":@"code",
             @"message":@"message"};
}

//+ (NSValueTransformer *)messageJSONTransformer {
////    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[TicketItemResponseMessage class]];
//}

@end
