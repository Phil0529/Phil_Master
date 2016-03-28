//
//  SimpleResponse.m
//  Master
//
//  Created by Phil Xhc on 3/23/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "SimpleResponse.h"

@implementation SimpleResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"code": @"code",
             @"message": @"message",
             @"data":@"data"};
}


@end
