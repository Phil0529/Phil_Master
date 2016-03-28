//
//  LiveResponseModel.h
//  EZTV
//
//  Created by Lee, Bo on 15/8/13.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "MTLModel.h"

@interface ChatRoomModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *lId;
@property (nonatomic, copy) NSString *mId;
@property (nonatomic ,copy) NSString *name;
@property (nonatomic, assign) BOOL chatEnable;

@end

@interface LiveResponseModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) ChatRoomModel *chatRoom;

@end
