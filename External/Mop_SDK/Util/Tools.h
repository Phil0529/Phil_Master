//
//  Tools.h
//  SWMOP
//
//  Created by Lee, Bo on 14-2-25.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject

//// 保存对象到文件
//+ (void)writeObject:(id)object Key:(NSString *)key FileName:(NSString *)fileName;
//
//// 从文件读取对象
//+ (id)readObject:(NSString *)key FileName:(NSString *)fileName;

//判断是否为空字符串
+ (BOOL)isEmptyString:(NSString*)str;

@end
