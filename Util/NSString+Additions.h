//
//  NSString+Additions.h
//  SWMOP
//
//  Created by Lee, Bo on 14-8-27.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Additions)

+ (BOOL)isEmptyString:(NSString*)str;

- (BOOL)stringIsUsefull;

- (BOOL)stringIsEmail;

- (BOOL)stringIsPhone;

- (NSString *)checkUrl;

- (BOOL)containsStr:(NSString*)str;

- (NSString *)stringByDecodingURLFormat;

@end
