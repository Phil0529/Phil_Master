//
//  AuthItem.h
//  SWMOP
//
//  Created by Lee, Bo on 14/12/12.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthItem : NSObject

@property (nonatomic ,assign) NSString* result;
@property (nonatomic, assign) NSInteger allow_watch_duration;

- (id)initWithXml:(NSString*)xmlStr;

@end
