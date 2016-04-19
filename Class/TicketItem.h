//
//  TicketItem.h
//  Master
//
//  Created by Phil Xhc on 4/5/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import <Mantle/Mantle.h>

typedef NS_ENUM(NSUInteger,TicketStatus){
    TicketStatus_NotUse     = 10,
    TicketStatus_Used       = 11,
    TicketStatus_Shared     = 12,
    TicketStatus_Expired    = 13,
};

@interface TicketItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSNumber *status;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *expires;
@property (nonatomic, copy) NSNumber *ticketId;
@property (nonatomic, copy) NSString *useDate;

@end

@interface TicketItemResponseMessage : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSArray *list;
@property (nonatomic, copy) NSNumber *code;
@property (nonatomic, copy) NSNumber *totalCount;

@end

@interface TicketItemResponse : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSNumber *code;
@property (nonatomic, copy) TicketItemResponseMessage *message;

@end

