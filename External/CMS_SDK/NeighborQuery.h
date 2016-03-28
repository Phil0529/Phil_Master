//
//  NeighborQuery.h
//  EZTV
//
//  Created by Lee, Bo on 16/2/16.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPRequestOperation.h>
#import "OVCCMSClient.h"
#import "NeighborItem.h"

@interface NeighborQuery : NSObject

+ (AFHTTPRequestOperation *)getMyNeighbors:(void(^)(NSArray *result))completion;

@end
