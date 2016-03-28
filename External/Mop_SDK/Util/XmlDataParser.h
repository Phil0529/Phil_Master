//
//  XmlDataParser.h
//  ParserXml
//
//  Created by zengraoli on 13-11-6.
//  Copyright (c) 2013年 zeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface xmlElement : NSObject

@property (strong, nonatomic) NSString *NodeName;
@property (strong, nonatomic) NSDictionary *NodeAttrs;
@property (strong, nonatomic) NSMutableString *NodeValue;

@end

typedef void(^XmlDataParserCompletion)(NSArray *list);

@interface XmlDataParser : NSObject<NSXMLParserDelegate>

@property(copy, nonatomic) XmlDataParserCompletion completeion;

- (BOOL)startParse:(NSString *)xmlContent completion:(XmlDataParserCompletion)completion;

- (BOOL)StartParse:(NSString *)xmlContent;

@end
