//
//  CoinQuery.h
//  EZTV
//
//  Created by Lee, Bo on 15/5/22.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CoinChannel) {
    CoinChannel_Sign = 1,
    CoinChannel_Share = 2,
};

@interface CoinQuery : NSObject

+ (void)addCoinCountbyChannel:(CoinChannel)channel completion:(void(^)(NSInteger code, NSInteger num))completion;

+ (void)checkSignUpWithMpno:(NSString *)mpno completion:(void(^)(BOOL result))completion;

@end
