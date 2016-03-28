//
//  FlvcdXmlItem.h
//  SWMOP
//
//  Created by Lee, Bo on 14/11/25.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlvcdXmlItem : NSObject

@property (nonatomic, assign) BOOL error;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *formatList;
@property (nonatomic, assign) NSInteger total_duration;
@property (nonatomic, strong) NSString *ts;
@property (nonatomic, strong) NSString *te;
@property (nonatomic, strong) NSString *TYPE;
@property (nonatomic, strong) NSString *C;
@property (nonatomic, strong) NSMutableArray *U;

- (id)initWithXml:(NSString*)xmlStr;

- (id)initWithDataArray:(NSArray*)list;

@end
