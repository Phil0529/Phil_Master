//
//  ColumnItem.h
//  SWMOP
//
//  Created by Lee, Bo on 11/4/14.
//  Copyright (c) 2014 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColumnItem : NSObject<NSCoding, NSCopying>

@property (nonatomic, assign) NSInteger mId;
@property (nonatomic, assign) NSInteger mPid;
@property (nonatomic, strong) NSString *mTitle;
@property (nonatomic, strong) NSString *mType;
@property (nonatomic, assign) BOOL mLeaf;

- (id) initWithJosnObject:(NSDictionary *)jsonItem;

@end
