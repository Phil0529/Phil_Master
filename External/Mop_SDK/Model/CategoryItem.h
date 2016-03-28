//
//  CategoryItem.h
//  SWMOP
//
//  Created by Lee, Bo on 11/6/14.
//  Copyright (c) 2014 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryItem : NSObject<NSCoding, NSCopying>

@property (nonatomic, assign) NSInteger mId;
@property (nonatomic, strong) NSString *mTitle;
@property (nonatomic, assign) NSInteger mTotal;

- (id) initWithJsonObject:(NSDictionary *)jsonItem;

@end
