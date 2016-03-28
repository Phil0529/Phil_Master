//
//  SubscribeItem.h
//  SWMOP
//
//  Created by Lee, Bo on 14/12/11.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubscribeItem : NSObject

@property (nonatomic, strong) NSString *mUserId;        // 业务订购者 ID
@property (nonatomic, strong) NSString *mServiceId;     // 业务 ID
@property (nonatomic, assign) NSInteger mStartUtc;      // 订购生效时间
@property (nonatomic, assign) NSInteger mEndUtc;        // 订购失效时间
@property (nonatomic, assign) NSInteger mPrice;         // 价格

@end

@interface SubscribeCollect : NSObject

@property (nonatomic, strong) NSString *mUserId;
@property (nonatomic, strong) NSMutableArray *mDataArray;

- (id)initWithXml:(NSString*)xmlStr andUser:(NSString*)user;

@end