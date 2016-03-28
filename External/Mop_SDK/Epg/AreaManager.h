//
//  AreaManager.h
//  SWMOP
//
//  Created by Lee, Bo on 14-10-11.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AreaItem.h"

@interface AreaManager : NSObject

+ (id) sharedInstance;

- (void)getAreaList:(void(^)(NSArray *list ,NSError *error))completion;

@end
