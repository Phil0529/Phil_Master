//
//  EpgItem.h
//  SWMOP
//
//  Created by Lee, Bo on 11/4/14.
//  Copyright (c) 2014 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EpgItem : NSObject<NSCoding, NSCopying>

@property (nonatomic, strong) NSString *mTitle;
@property (nonatomic, assign) NSTimeInterval mStartUtc;
@property (nonatomic, assign) NSTimeInterval mEndUtc;

- (id) initWithJsonObject:(NSDictionary *)jsonItem;

@end
