//
//  LiveAuthItem.h
//  EZTV
//
//  Created by Lee, Bo on 15/9/18.
//  Copyright © 2015年 Joygo. All rights reserved.
//

#import "MTLModel.h"

@interface AuthData : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *message;

@end

@interface LiveAuthItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) AuthData *data;

@end
