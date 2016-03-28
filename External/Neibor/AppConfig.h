//
//  AppConfig.h
//  EZTV
//
//  Created by Lee, Bo on 16/2/22.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NeighborItem.h"

@interface AppConfig : NSObject

@property (nonatomic, assign, readonly) BOOL isDefault;
@property (nonatomic, strong, readonly) NSString *cmsPath;
@property (nonatomic, strong, readonly) NSString *userPath;
@property (nonatomic, strong, readonly) NSString *appsPath;
@property (nonatomic, strong, readonly) NSString *oisPath;
@property (nonatomic, strong, readonly) NSString *appName;
@property (nonatomic, strong, readonly) NSString *appLogo;
@property (nonatomic, strong, readonly) UIColor *appColor;
@property (nonatomic, strong, readonly) NSString *appCoin;
@property (nonatomic, strong, readonly) NSString *appCoinUnit;
@property (nonatomic, retain) NSString *travelFrom;

+ (AppConfig *)sharedConfig;

- (void)loadDefaultConfig;

- (void)jumpToNeighbor:(NeighborItem *)item completion:(void(^)())completion;

@end
