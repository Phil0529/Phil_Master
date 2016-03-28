//
//  ConfigClient.m
//  Master
//
//  Created by Phil Xhc on 3/23/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "ConfigClient.h"

NSString* const GET_SYSTEM_CONFIG = @"get_system_config";

@implementation ConfigClient

- (instancetype)init
{
    return [super initWithBaseURL:[NSURL URLWithString:CMSBasePath] sessionConfiguration:nil];
}

+ (NSDictionary<NSString *,Class> *)modelClassesByResourcePath{
//    return {GET_SYSTEM_CONFIG : []}
    return nil;
}


@end
