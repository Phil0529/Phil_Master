//
//  HomeItem.m
//  EZTV
//
//  Created by Lee, Bo on 15/5/2.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "HomeItem.h"

@implementation HomeItem

@synthesize title = _title;
@synthesize hometype = _hometype;
@synthesize rowcount = _rowcount;
@synthesize columncount = _columncount;
@synthesize menuitem = _menuitem;
@synthesize subList = _subList;

#pragma mark - NSCoding

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"title": @"title",
             @"hometype": @"hometype",
             @"rowcount": @"rowcount",
             @"columncount": @"columncount",
             @"menuitem": @"menuitem",
             @"list": @"list"};
}

+ (NSValueTransformer *)menuitemJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[MenuItem class]];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self){
        if (_menuitem.menutype == 0) {
            _menuitem = nil;
        }
        switch (_hometype) {
            case HomeTypeColumn:
            case HomeTypeMenu:
            case HomeTypeAd:
            case HomeTypeTv:
            case HomeTypeExcel:
            {
                _subList = [MTLJSONAdapter modelsOfClass:[MenuItem class] fromJSONArray:dictionaryValue[@"list"] error:NULL];
            }
                break;
            case HomeTypeMLive:
            {
                _subList = [MTLJSONAdapter modelsOfClass:[LiveItem class] fromJSONArray:dictionaryValue[@"list"] error:NULL];
            }
                break;
            case HomeTypeScroll:
            {
                _subList = [MTLJSONAdapter modelsOfClass:[AdItem class] fromJSONArray:dictionaryValue[@"list"] error:NULL];
            }
                break;
            case HomeTypeLive:
            case HomeTypeNews:
            {
                _subList = [MTLJSONAdapter modelsOfClass:[EZMediaItem class] fromJSONArray:dictionaryValue[@"list"] error:NULL];
            }
                break;
            default:
                break;
        }
        while ((_list.count < _columncount * _rowcount) && _rowcount > 1) {
            _rowcount --;
        }
        if (_columncount <= 0) {
            _columncount = 2;
        }
        if (_rowcount <= 0) {
            _rowcount = 1;
        }
    }
    return self;
}

@end

