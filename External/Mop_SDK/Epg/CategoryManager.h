//
//  CategoryManager.h
//  SWMOP
//
//  Created by Lee, Bo on 14-10-11.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryItem.h"
#import "SyncManager.h"

@interface CategoryManager : NSObject<SyncListener>

+ (id) sharedInstance;

- (void)getCategoryList:(NSInteger)columnId completion:(void(^)(NSArray *list ,NSError *error))completion;

@end
