//
//  TokenModel.m
//  EZTV
//
//  Created by Sunni on 15/7/6.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "TokenModel.h"

@implementation TokenModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"userId": @"userId",
             @"token": @"token"};
}

@end
