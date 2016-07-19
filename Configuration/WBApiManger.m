//
//  WBApiManger.m
//  EZTV
//
//  Created by Admin on 16/4/11.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import "WBApiManger.h"

@implementation WBApiManger
#pragma mark - LifeCycle
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WBApiManger *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WBApiManger alloc] init];
    });
    return instance;
}

- (void)dealloc {
    self.delegate = nil;
}

#pragma mark - WXApiDelegate

-(void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

-(void)didReceiveWeiboResponse:(WBAuthorizeResponse *)response
{
    
    if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
        if (_delegate && [_delegate respondsToSelector:@selector(didRecvAuthResponse:)]) {
            [_delegate didRecvAuthResponse:response];
        }
    } else {
        if (_delegate && [_delegate respondsToSelector:@selector(didRecvAuthResponse:)]) {
            [_delegate didRecvAuthResponse:nil];
        }
    }
}

@end
