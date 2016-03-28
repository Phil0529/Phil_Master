//
//  TokenModel.h
//  EZTV
//
//  Created by Sunni on 15/7/6.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "MTLModel.h"

@interface TokenModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *token;

@end
