//
//  NSString+Additions.m
//  SWMOP
//
//  Created by Lee, Bo on 14-8-27.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import "NSString+Additions.h"
#import "LanguageBundle.h"
#import "GTMNSString+HTML.h"

@implementation NSString(Additions)

+ (BOOL)isEmptyString:(NSString*)str
{
    if (str) {
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (str.length > 0) {
            return NO;
        }
    }
    return YES;
}

- (BOOL) stringIsUsefull
{
    NSString *regex = @"[A-Za-z0-9_－]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL) stringIsEmail
{
    NSString *regex = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL) stringIsPhone
{
    NSString *regex = @"[0-9]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (NSString*)checkUrl;
{
    //去掉url空格
    NSString *newurl = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    newurl = [newurl stringByReplacingOccurrencesOfString:@" " withString:@""];
    newurl = [NSString stringWithString:[newurl gtm_stringByUnescapingFromHTML]];
    return newurl;
}

- (BOOL)containsStr:(NSString *)str
{
    if (IS_OS_8_OR_LATER) {
        return [self containsString:str];
    } else {
        return [self rangeOfString:str].length > 0;
    }
}

- (NSString *)stringByDecodingURLFormat
{
    NSString *result = [(NSString *)self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

@end
