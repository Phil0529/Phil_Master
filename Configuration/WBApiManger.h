//
//  WBApiManger.h
//  EZTV
//
//  Created by Admin on 16/4/11.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeiboSDK.h>

@protocol WBApiMangerDelegate <NSObject>

@optional

- (void)didRecvAuthRequest:(WBBaseRequest *)response;

- (void)didRecvAuthResponse:(WBAuthorizeResponse *)response;

@end

@interface WBApiManger : NSObject<WeiboSDKDelegate>

@property (nonatomic, weak) id<WBApiMangerDelegate> delegate;

+ (instancetype)sharedManager;

@end
