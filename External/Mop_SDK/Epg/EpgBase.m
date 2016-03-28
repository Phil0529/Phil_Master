//
//  EpgBase.m
//  SWMOP
//
//  Created by guoziyi on 14-2-26.
//  Copyright (c) 2014年 husl. All rights reserved.
//
#import "Parameter.h"
#import "EpgBase.h"
#import "Tools.h"

@implementation EpgBase

+(NSString *)getBasePath
{
    NSString *epgs = [[Parameter sharedInstance] getValueOfKey:ParamEpgs];
    if(![Tools isEmptyString:epgs])
    {
        return [NSString stringWithFormat:@"http://%@/epgs/%@", epgs, [[Parameter sharedInstance] getValueOfKey:ParamEpg]];
    }
    return nil;
}

+ (NSString*)getSyncPath
{
    NSString *epgs = [[Parameter sharedInstance] getValueOfKey:ParamEpgs];
    if(![Tools isEmptyString:epgs])
    {
        NSString *epgsToken = @"guoziyun";
        if(![Tools isEmptyString:epgsToken])
        {
            return [NSString stringWithFormat:@"http://%@/epgs/%@/sync/get?token=%@", epgs, [[Parameter sharedInstance] getValueOfKey:ParamEpg], epgsToken];
        }
    }
    return nil;
}

+ (NSString*)getAdMapPath
{
    NSString *epgs = [[Parameter sharedInstance] getValueOfKey:ParamEpgs];
    if(![Tools isEmptyString:epgs])
    {
        NSString *epgsToken = @"guoziyun";
        if(![Tools isEmptyString:epgsToken])
        {
            return [NSString stringWithFormat:@"http://%@/epgs/%@/ad/map?token=%@", epgs, [[Parameter sharedInstance] getValueOfKey:ParamEpg], epgsToken];
        }
    }
    
    return nil;
}

+ (NSString*)getAdByColumnIdPath:(NSInteger)columnId
{
    NSString *epgs = [[Parameter sharedInstance] getValueOfKey:ParamEpgs];
    if(![Tools isEmptyString:epgs])
    {
        NSString *epgsToken = @"guoziyun";
        if(![Tools isEmptyString:epgsToken])
        {
            return [NSString stringWithFormat:@"http://%@/epgs/%@/ad/get?columnid=%d&token=%@", epgs, [[Parameter sharedInstance] getValueOfKey:ParamEpg], columnId, epgsToken];
        }
    }
    
    return nil;
}

+ (NSString *)getColumnMapPath:(NSString *)lang
{
    //查询接口lang可以为空,返回的是所有语言,本地的columnItem未处理.因而暂不考虑
    NSString *epgs = [[Parameter sharedInstance] getValueOfKey:ParamEpgs];
    if(![Tools isEmptyString:epgs])
    {
        NSString *epgsToken = @"guoziyun";
        if(![Tools isEmptyString:epgsToken])
        {
            return [NSString stringWithFormat:@"http://%@/epgs/%@/column/map?lang=%@&token=%@", epgs, [[Parameter sharedInstance] getValueOfKey:ParamEpg], lang, epgsToken];
        }
    }
    return nil;
}

+ (NSString *)getColumnListPath:(NSString *)lang
{
    NSString *epgs = [[Parameter sharedInstance] getValueOfKey:ParamEpgs];
    if(![Tools isEmptyString:epgs])
    {
        NSString *epgsToken = @"guoziyun";
        if(![Tools isEmptyString:epgsToken])
        {
            return [NSString stringWithFormat:@"http://%@/epgs/%@/column/list?lang=%@&token=%@", epgs, [[Parameter sharedInstance] getValueOfKey:ParamEpg], lang, epgsToken];
        }
    }
    return nil;
}

+(NSString *)getColumnSubPath:(NSInteger)pid lang:(NSString *)lang
{
    NSString *epgs = [[Parameter sharedInstance] getValueOfKey:ParamEpgs];
    if(![Tools isEmptyString:epgs])
    {
        NSString *epgsToken = @"guoziyun";
        if(![Tools isEmptyString:epgsToken])
        {
            return [NSString stringWithFormat:@"http://%@/epgs/%@/column/get?pid=%d&lang=%@&token=%@", epgs, [[Parameter sharedInstance] getValueOfKey:ParamEpg], pid, lang, epgsToken];
        }
    }

    return nil;
}

+ (NSString *)getColumnQueryPath:(NSInteger)columnId pid:(NSInteger)pid title:(NSString *)title lang:(NSString *)lang
{
    NSString *epgs = [[Parameter sharedInstance] getValueOfKey:ParamEpgs];
    if(![Tools isEmptyString:epgs])
    {
        NSString *epgsToken = @"guoziyun";
        if(![Tools isEmptyString:epgsToken] &&(columnId != -1 || pid != -1 || title))
        {
            NSMutableString *path = [[NSMutableString alloc] init];
            [path appendString:[NSString stringWithFormat:@"http://%@/epgs/%@/column/info?lang=%@&token=%@", epgs, [[Parameter sharedInstance] getValueOfKey:ParamEpg], lang, epgsToken]];
            if (title) {
                [path appendString:[NSString stringWithFormat:@"&title=%@", title]];
            }
            if (columnId != -1) {
                [path appendString:[NSString stringWithFormat:@"&id=%d", columnId]];
            }
            if (pid != -1) {
                [path appendString:[NSString stringWithFormat:@"&pid=%d", pid]];
            }
            return path;
        }
    }
    return nil;
}

+(NSString *)getAreaPath:(NSString *)lang
{
    NSString *epgs = [[Parameter sharedInstance] getValueOfKey:ParamEpgs];
    if(![Tools isEmptyString:epgs])
    {
        NSString *epgsToken = @"guoziyun";
        if(![Tools isEmptyString:epgsToken])
        {
            return [NSString stringWithFormat:@"http://%@/epgs/area/get?lang=%@&token=%@", epgs, lang, epgsToken];
        }
    }
    
    return nil;
}

+ (NSString *)getCategoryPath:(NSInteger)columnId lang:(NSString *)lang
{
    NSString *epgs = [[Parameter sharedInstance] getValueOfKey:ParamEpgs];
    if(![Tools isEmptyString:epgs])
    {
        NSString *epgsToken = @"guoziyun";
        if(![Tools isEmptyString:epgsToken])
        {
            return [NSString stringWithFormat:@"http://%@/epgs/%@/category/get?columnid=%d&lang=%@&token=%@", epgs, [[Parameter sharedInstance] getValueOfKey:ParamEpg], columnId, lang, epgsToken];
        }
    }
    return nil;
}

+ (NSString *)getEpgPath:(NSString *)columnId startUtc:(NSTimeInterval)startUtc endUtc:(NSTimeInterval)endUtc lang:(NSString *)lang
{
    NSString *epgs = [[Parameter sharedInstance] getValueOfKey:ParamEpgs];
    if(![Tools isEmptyString:epgs])
    {
        NSString *epgsToken = @"guoziyun";
        if(![Tools isEmptyString:epgsToken])
        {
            return [NSString stringWithFormat:@"http://%@/epgs/channel/epg/get?id=%@&utc=%.0f000&endutc=%.0f000&lang=%@&token=%@", epgs, columnId, startUtc, endUtc, lang, epgsToken];
        }
    }
    return nil;
}

+ (NSString *)getEpgPath:(NSString *)columnId date:(NSString *)date timezone:(NSInteger)timezone days:(NSInteger)days lang:(NSString *)lang
{
    NSString *epgs = [[Parameter sharedInstance] getValueOfKey:ParamEpgs];
    if(![Tools isEmptyString:epgs])
    {
        NSString *epgsToken = @"guoziyun";
        if(![Tools isEmptyString:epgsToken])
        {
            return [NSString stringWithFormat:@"http://%@/epgs/channel/epg/get?id=%@&date=%@&days=%d&timezone=%d&lang=%@&token=%@", epgs, columnId, date, days, timezone, lang, epgsToken];
        }
    }
    
    return nil;
}

+ (NSString *)getMediaPath:(NSInteger)columnId Meta:(NSString *)meta PageIndex:(NSInteger)pageIndex lang:(NSString *)lang pageSize:(NSUInteger)pageSize
{
    NSString *epgs = [[Parameter sharedInstance] getValueOfKey:ParamEpgs];
    if(![Tools isEmptyString:epgs])
    {
        NSString *epgsToken = @"guoziyun";
        if(![Tools isEmptyString:epgsToken])
        {
            NSString *ret = [NSString stringWithFormat:@"http://%@/epgs/%@/media/get?columnid=%d&pageindex=%d&pagesize=%d&lang=%@&token=%@", epgs, [[Parameter sharedInstance] getValueOfKey:ParamEpg], columnId, pageIndex, pageSize, lang, epgsToken];
            if(![meta isEqualToString:@"-1"])
            {
                ret = [ret stringByAppendingFormat:@"&meta=%@", meta];
            }
            return ret;
        }
    }
    
    return nil;
}

+ (NSMutableDictionary*) getMediaParamsWithCategory:(NSString *)category Area:(NSString *)area Tag:(NSString *)tag Year:(NSString *)year Title:(NSString *)title Pinyin:(NSString *)pinyin Actor:(NSString *)actor Director:(NSString *)director Sort:(NSString *)sort
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    if(category&& ![category isEqualToString:@""])
    {
        [params setObject:category forKey:@"category"];
    }
    
    if(area&& ![area isEqualToString:@""])
    {
        [params setObject:area forKey:@"area"];
    }
    
    if(tag&& ![tag isEqualToString:@""])
    {
        [params setObject:tag forKey:@"tag"];
    }
    
    if(year&& ![year isEqualToString:@""])
    {
        [params setObject:year forKey:@"year"];
    }
    
    if(title&& ![title isEqualToString:@""])
    {
        [params setObject:title forKey:@"title"];
    }
    
    if(pinyin&& ![pinyin isEqualToString:@""])
    {
        [params setObject:pinyin forKey:@"pinyin"];
    }
    
    if(actor&& ![actor isEqualToString:@""])
    {
        [params setObject:actor forKey:@"actor"];
    }
    
    if(director&& ![director isEqualToString:@""])
    {
        [params setObject:director forKey:@"dierector"];
    }
    
    if(sort&& ![sort isEqualToString:@""])
    {
        [params setObject:sort forKey:@"sort"];
    }

    if ([params count] == 0) {
        return nil;
    }
    return params;
}

+ (NSString *)getMediaDetailPath:(NSInteger)columnId MediaId:(NSString *)mediaId Provider:(NSString *)provider lang:(NSString *)lang
{
    NSString *epgs = [[Parameter sharedInstance] getValueOfKey:ParamEpgs];
    if(![Tools isEmptyString:epgs])
    {
        NSString *epgsToken = @"guoziyun";
        if(![Tools isEmptyString:epgsToken])
        {
            NSString *ret = [NSString stringWithFormat:@"http://%@/epgs/%@/media/detail?id=%@&columnid=%d&lang=%@&token=%@", epgs, [[Parameter sharedInstance] getValueOfKey:ParamEpg], mediaId, columnId, lang, epgsToken];
            
            if(provider&& ![provider isEqualToString:@""])
            {
                ret = [ret stringByAppendingFormat:@"&provider=%@", provider];
            }
            return ret;
        }
    }
    return nil;
}

+ (NSString*)getRealUrlPath:(NSString *)url Quality:(NSInteger)quality
{
    NSString *epgs = [[Parameter sharedInstance] getValueOfKey:ParamEpgs];
    if(![Tools isEmptyString:epgs])
    {
        NSString *epgsToken = @"guoziyun";
        if(![Tools isEmptyString:epgsToken])
        {
            return [NSString stringWithFormat:@"http://%@/epgs/realurl/get?url=%@&quality=%d&token=%@", epgs, url, quality, epgsToken];
        }
    }
    return nil;
}

@end
