//
//  AudienceModel.h
//  EZTV
//
//  Created by Sunni on 15/7/8.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "MTLModel.h"

@interface AudienceModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *imgUrl;

@end
