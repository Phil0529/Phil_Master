//
//  ConfigManger.h
//  EZTV
//
//  Created by Sunni on 15/6/17.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigMap.h"
#import "RefreshDelegate.h"

@interface ConfigManger : NSObject

@property (nonatomic, assign) id<RefreshDelegate> delegate;
@property (nonatomic, assign, readonly) BOOL isShield;
@property (nonatomic ,strong, readonly) NSArray *tagArray;
@property (nonatomic, strong, readonly) NSArray *tabMenuArray;
@property (nonatomic, strong, readonly) ConfigMap *configMap;

+ (ConfigManger *)sharedManager;

- (void)refreshTabMenuArray;

- (void)refreshConfigMap;

- (void)refreshTagArray;

@end
