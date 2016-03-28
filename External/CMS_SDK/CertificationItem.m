//
//  CertificationItem.m
//  EZTV
//
//  Created by Sunniwell on 8/12/15.
//  Copyright (c) 2015 Joygo. All rights reserved.
//

#import "CertificationItem.h"

@implementation CertificationItem
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"code": @"code",
             @"message": @"message",
             };
}

@end

@implementation CertificationInfo
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"mpno": @"mpno",
             @"createtime": @"createtime",
             @"status": @"status",
             @"rejectreasons": @"rejectreasons",
             @"applyreasons": @"applyreasons",
             @"idpics": @"idpics",
             @"phone": @"phone",
             @"idnumber": @"idnumber",
             @"place": @"place",
             @"occupation": @"occupation",
             @"name": @"name",
             @"roles": @"roles",
             @"issign": @"issign",
             };
}

@end
