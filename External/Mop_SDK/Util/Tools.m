//
//  Tools.m
//  SWMOP
//
//  Created by Lee, Bo on 14-2-25.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import "Tools.h"
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "MopLog.h"

@implementation Tools
//
//// 保存对象到文件
//+ (void)writeObject :(id)object Key:(NSString *)key FileName:(NSString *)fileName
//{
//    MopLogD(@"writeObject key : %@, fileName : %@", key, fileName);
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *filePath = [[paths firstObject] stringByAppendingPathComponent:fileName];
//    
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
//    [data writeToFile:filePath atomically:YES];
//}
//
//// 从文件读取对象
//+ (id)readObject :(NSString *)key FileName:(NSString *)fileName
//{
//    MopLogD(@"readObject key : %@, fileName : %@", key, fileName);
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *filePath = [[paths firstObject] stringByAppendingPathComponent:fileName];
//    NSFileManager *fm = [NSFileManager defaultManager];
//    if ([fm fileExistsAtPath:filePath]) {
//        NSData *data = [NSData dataWithContentsOfFile:filePath];
//        return  [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    }
//    return nil;
//}

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

@end
