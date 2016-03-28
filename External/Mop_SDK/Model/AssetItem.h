//
//  AssetItem.h
//  SWMOP
//
//  Created by Lee, Bo on 14/12/11.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AssetItem : NSObject

@property (nonatomic, strong) NSString *mUserId;       // 业务订购者 ID
@property (nonatomic, strong) NSString *mServiceId;    // 产品包 ID 号  (注：只有当 op_type == 2|3 的时候, 该变量才有效)
@property (nonatomic, assign) NSInteger mOpType;       // 消费记录类型 (1:充值, 2: 订购, 3: 退订)
@property (nonatomic, assign) NSInteger mOpAmount;     // 此次消费的数额
@property (nonatomic, assign) NSInteger mOpUtc;        // 此次消费的时间 (以秒为单位)
@property (nonatomic, assign) NSInteger mBalances;     // 此次消费后, 账户的余额

@end

@interface AssetCollect : NSObject

@property (nonatomic, strong) NSString *mUserId;
@property (nonatomic, strong) NSMutableArray *mDataArray;

- (id)initWithXml:(NSString*)xmlStr andUser:(NSString*)user;

@end