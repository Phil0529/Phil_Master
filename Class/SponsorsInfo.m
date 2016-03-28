//
//  SponsorsInfo.m
//  EZTV
//
//  Created by Phil Xhc on 16/1/21.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import "SponsorsInfo.h"

@implementation SponsorsInfo

+ (instancetype)shareInstance{
    static SponsorsInfo *shareInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInfo = [[SponsorsInfo alloc] init];
    });
    return shareInfo;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"sId":@"_id",
             @"name":@"name",
             @"contactAddress":@"ads",
             @"applyReason":@"cause",
             @"createTime":@"createtime",
             @"contactPeople":@"nickname",
             @"contactPhone":@"phone",
             @"imgURL":@"img",
             @"bestSponsors":@"faith",
             @"reviewStatus":@"status",
             @"detailInfo":@"desc",
             @"shareURL":@"url",
             @"rejectInfo":@"reject"};
}

@end

@implementation SponsorsInfoResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"code": @"code",
             @"list": @"list"};
}


+ (NSValueTransformer *)listJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[SponsorsInfo class]];
}



@end
