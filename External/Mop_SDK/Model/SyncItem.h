//
//  SyncItem.h
//  SWMOP
//
//  Created by Lee, Bo on 11/4/14.
//  Copyright (c) 2014 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SyncItem : NSObject<NSCoding, NSCopying>

@property (nonatomic, assign) NSInteger mColumnId;
@property (nonatomic, assign) NSInteger mSyncNum;
@property (nonatomic, assign) NSInteger mLastSyncNum;

- (id) initWithJsonObject:(NSDictionary *)jsonItem;

@end