//
//  AudienceModel.m
//  EZTV
//
//  Created by Sunni on 15/7/8.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "AudienceModel.h"

@implementation AudienceModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"userId" : @"id",
             @"userName" : @"name",
             @"imgUrl" : @"picid"};
}

@end
