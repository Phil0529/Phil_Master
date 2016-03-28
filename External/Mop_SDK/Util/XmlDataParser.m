//
//  XmlDataParser.m
//  ParserXml
//
//  Created by zengraoli on 13-11-6.
//  Copyright (c) 2013年 zeng. All rights reserved.
//

#import "XmlDataParser.h"

@implementation xmlElement

- (instancetype)init
{
    self = [super init];
    if (self) {
        _NodeValue = [[NSMutableString alloc] init];
    }
    return self;
}

@end

@implementation XmlDataParser
{
    NSMutableArray *_tmpStack;
    NSMutableArray *_dataList;
}

@synthesize completeion = _completeion;

- (BOOL)StartParse:(NSString *)xmlContent
{
    NSXMLParser *mXMLParser = [[NSXMLParser alloc] initWithData:[xmlContent dataUsingEncoding:NSUTF8StringEncoding]];
    [mXMLParser setShouldProcessNamespaces:NO];
    [mXMLParser setShouldReportNamespacePrefixes:NO];
    [mXMLParser setShouldResolveExternalEntities:NO];
    [mXMLParser setDelegate:self];
    return [mXMLParser parse];
}

- (BOOL)startParse:(NSString *)xmlContent completion:(XmlDataParserCompletion)completion
{
    _completeion = completion;
    NSXMLParser *mXMLParser = [[NSXMLParser alloc] initWithData:[xmlContent dataUsingEncoding:NSUTF8StringEncoding]];
    [mXMLParser setShouldProcessNamespaces:NO];
    [mXMLParser setShouldReportNamespacePrefixes:NO];
    [mXMLParser setShouldResolveExternalEntities:NO];
    [mXMLParser setDelegate:self];
    return [mXMLParser parse];
}

#pragma NSXMLParser delegate

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    _dataList = [[NSMutableArray alloc] init];
    _tmpStack = [[NSMutableArray alloc] init];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    // 完成之后继续完成接下来的事情
    if (_completeion) {
        _completeion(_dataList);
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName rangeOfString:@"SOAP-ENV"].length > 0) {
        return;
    }
    xmlElement *elem = [[xmlElement alloc]init];
    [_tmpStack addObject:elem];
    elem.NodeName = elementName;
    elem.NodeAttrs = attributeDict;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    xmlElement *elem = [_tmpStack lastObject];
    if (elem) {
        [elem.NodeValue appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName rangeOfString:@"SOAP-ENV"].length > 0) {
        return;
    }
    xmlElement *elem = [_tmpStack lastObject];
    if (elem) {
        [_dataList addObject:elem];
        [_tmpStack removeLastObject];
    }
}

@end
