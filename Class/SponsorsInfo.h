//
//  SponsorsInfo.h
//  EZTV
//
//  Created by Phil Xhc on 16/1/21.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>


@interface SponsorsInfo :MTLModel<MTLJSONSerializing>

+ (instancetype)shareInstance;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage  *photo;
@property (nonatomic, strong) NSString *imgURL;
@property (nonatomic, strong) NSString *contactPeople;
@property (nonatomic, strong) NSString *contactPhone;
@property (nonatomic, strong) NSString *contactAddress;
@property (nonatomic, strong) NSString *detailInfo;
@property (nonatomic, strong) NSString *applyReason;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, assign) NSInteger bestSponsors;
@property (nonatomic, assign) NSInteger reviewStatus;
@property (nonatomic, strong) NSString *sId;
@property (nonatomic, strong) NSString *shareURL;
@property (nonatomic, strong) NSString *rejectInfo;

@end


@interface SponsorsInfoResponse : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSNumber *code;
@property (nonatomic, strong) NSArray *list;

@end

