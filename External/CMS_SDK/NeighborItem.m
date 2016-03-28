//
//  NeighborItem.m
//  EZTV
//
//  Created by Lee, Bo on 16/1/31.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import "NeighborItem.h"

@implementation NeighborItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"cmsPath": @"cmspath",
             @"userPath": @"userpath",
             @"appsPath": @"appspath",
             @"oisPath": @"oispath",
             @"appName": @"appname",
             @"appColor": @"appcolor",
             @"appIcon": @"appicon",
             @"appLogo": @"applogo",
             @"appImage": @"appimg",
             @"appDistance": @"appdistance",
             @"appDesc": @"appdesc",
             @"appDept": @"appdep",
             @"appCoin":@"appcoin",
             @"appCoinUnit":@"appcoinunit"};
}

@end
