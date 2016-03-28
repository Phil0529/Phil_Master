//
//  VideoCardItem.h
//  SWMOP
//
//  Created by Lee, Bo on 14/12/11.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoCardItem : NSObject

@property (nonatomic, strong) NSString *mCardNo;  // 视频充值卡的 id 号
@property (nonatomic, assign) NSInteger mAmount;  // 视频充值卡的金额
@property (nonatomic, assign) NSInteger mUsed;    // 标识该视频充值卡是否已经使用过. 0--表示未使用过, 1--表示已经使用过

- (id)initWithXml:(NSString*)xmlStr;

@end
