//
//  NeighborQuery.m
//  EZTV
//
//  Created by Lee, Bo on 16/2/16.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import "NeighborQuery.h"

@implementation NeighborQuery

+ (AFHTTPRequestOperation *)getMyNeighbors:(void (^)(NSArray *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    
    return [[OVCCMSClient defaultClient] GET:@"get_ios_neighbor" parameters:params resultClass:[NeighborItem class] resultKeyPath:@"list" completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

@end
