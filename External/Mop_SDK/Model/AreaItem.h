//
//  AreaItem.h
//  SWMOP
//
//  Created by Lee, Bo on 11/4/14.
//  Copyright (c) 2014 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaItem : NSObject<NSCoding, NSCopying>

@property (nonatomic, assign) NSInteger mId;
@property (nonatomic, strong) NSString *mTitle;

- (id) initWithJsonObject:(NSDictionary *)jsonItem;

@end
