//
//  MessageListModel.h
//  EZTV
//
//  Created by Sunni on 15/7/12.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "MTLModel.h"

@interface MessageModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString* userId;
@property (nonatomic, copy) NSString* nickName;
@property (nonatomic, copy) NSString* headUrl;
@property (nonatomic, copy) NSString* content;
@property (nonatomic, assign) NSTimeInterval sendTime;

@end

@interface MessageListModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) BOOL success;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSArray *list;

@end
