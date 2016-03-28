//
//  FlvcdXmlItem.m
//  SWMOP
//
//  Created by Lee, Bo on 14/11/25.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import "FlvcdXmlItem.h"
#import "XmlDataParser.h"

@implementation FlvcdXmlItem

@synthesize code = _code;
@synthesize description = _description;
@synthesize source = _source;
@synthesize url = _url;
@synthesize title = _title;
@synthesize formatList = _formatList;
@synthesize total_duration = _total_duration;
@synthesize ts = _ts;
@synthesize te = _te;
@synthesize TYPE = _TYPE;
@synthesize C = _C;
@synthesize U = _U;

- (id)initWithDataArray:(NSArray *)list
{
    self = [super init];
    if (self) {
        _U = [[NSMutableArray alloc] init];
        if (list) {
            _error = NO;
            for (xmlElement *elem in list) {
                if (elem.NodeName) {
                    if ([elem.NodeName isEqualToString:@"R"]) {
                        _source = [elem.NodeAttrs objectForKey:@"source"];
                    } else if ([elem.NodeName isEqualToString:@"url"]) {
                        _url = elem.NodeValue;
                    } else if ([elem.NodeName isEqualToString:@"title"]) {
                        _title = elem.NodeValue;
                    } else if ([elem.NodeName isEqualToString:@"formatList"]) {
                        _formatList = elem.NodeValue;
                    } else if ([elem.NodeName isEqualToString:@"total_duration"]) {
                        _total_duration = [elem.NodeValue integerValue];
                    } else if ([elem.NodeName isEqualToString:@"ts"]) {
                        _ts = elem.NodeValue;
                    } else if ([elem.NodeName isEqualToString:@"te"]) {
                        _te = elem.NodeValue;
                    } else if ([elem.NodeName isEqualToString:@"TYPE"]) {
                        _TYPE = [elem.NodeValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    } else if ([elem.NodeName isEqualToString:@"C"]) {
                        _C = [elem.NodeValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    } else if ([elem.NodeName isEqualToString:@"U"]) {
                        [_U addObject:[elem.NodeValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
                    } else if ([elem.NodeName isEqualToString:@"error"]) {
                        _error = YES;
                    } else if ([elem.NodeName isEqualToString:@"code"]) {
                        _code = elem.NodeValue;
                    } else if ([elem.NodeName isEqualToString:@"description"]) {
                        _description = elem.NodeValue;
                    }
                }
            }
        } else {
            _error = YES;
        }
    }
    return self;
}

- (id)initWithXml:(NSString *)xmlStr
{
    self = [super init];
    if (self) {
        if (xmlStr) {
            _U = [[NSMutableArray alloc] init];
            _error = NO;
            XmlDataParser *parser = [[XmlDataParser alloc]init];
            [parser startParse:xmlStr completion:^(NSArray *list) {
                for (xmlElement *elem in list) {
                    if (elem.NodeName) {
                        if ([elem.NodeName isEqualToString:@"R"]) {
                            _source = [elem.NodeAttrs objectForKey:@"source"];
                        } else if ([elem.NodeName isEqualToString:@"url"]) {
                            _url = elem.NodeValue;
                        } else if ([elem.NodeName isEqualToString:@"title"]) {
                            _title = elem.NodeValue;
                        } else if ([elem.NodeName isEqualToString:@"formatList"]) {
                            _formatList = elem.NodeValue;
                        } else if ([elem.NodeName isEqualToString:@"total_duration"]) {
                            _total_duration = [elem.NodeValue integerValue];
                        } else if ([elem.NodeName isEqualToString:@"ts"]) {
                            _ts = elem.NodeValue;
                        } else if ([elem.NodeName isEqualToString:@"te"]) {
                            _te = elem.NodeValue;
                        } else if ([elem.NodeName isEqualToString:@"TYPE"]) {
                            _TYPE = [elem.NodeValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        } else if ([elem.NodeName isEqualToString:@"C"]) {
                            _C = elem.NodeValue;
                        } else if ([elem.NodeName isEqualToString:@"U"]) {
                            [_U addObject:elem.NodeValue];
                        } else if ([elem.NodeName isEqualToString:@"error"]) {
                            _error = YES;
                        } else if ([elem.NodeName isEqualToString:@"code"]) {
                            _code = elem.NodeValue;
                        } else if ([elem.NodeName isEqualToString:@"description"]) {
                            _description = elem.NodeValue;
                        }
                    }
                }
            }];
        } else {
            _error = YES;
        }
    }
    return self;
}
@end
