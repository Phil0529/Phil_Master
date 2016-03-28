//
//  NeighborItem.h
//  EZTV
//
//  Created by Lee, Bo on 16/1/31.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import <MTLModel.h>

@interface NeighborItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *cmsPath;
@property (nonatomic, copy) NSString *userPath;
@property (nonatomic, copy) NSString *appsPath;
@property (nonatomic, copy) NSString *oisPath;
@property (nonatomic, copy) NSString *appName;
@property (nonatomic, copy) NSString *appColor;
@property (nonatomic, copy) NSString *appIcon;
@property (nonatomic, copy) NSString *appLogo;
@property (nonatomic, copy) NSString *appImage;
@property (nonatomic, copy) NSString *appDistance;
@property (nonatomic, copy) NSString *appDesc;
@property (nonatomic, copy) NSString *appDept;
@property (nonatomic, copy) NSString *appCoin;
@property (nonatomic, copy) NSString *appCoinUnit;

@end
