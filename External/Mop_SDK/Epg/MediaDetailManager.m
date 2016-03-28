//
//  MediaDetailManager.m
//  SWMOP
//
//  Created by Lee, Bo on 14-10-11.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//
#import "MediaDetailManager.h"
#import "SWMOPQuery.h"
#import "Parameter.h"

@interface MediaDetailManager()
{
    NSMutableDictionary *_mediaDetailMap;
}

@end

@implementation MediaDetailManager

+ (id) sharedInstance
{
    static dispatch_once_t once;
    static MediaDetailManager *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[MediaDetailManager alloc] init];
    });
    
    return sharedInstance;
}

- (id) init
{
    self = [super init];
    if(self)
    {
        _mediaDetailMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)getMediaDetailWithColumnId:(NSInteger)columnId mediaId:(NSString *)mediaId provider:(NSString *)provider completion:(void (^)(MediaItem *, NSError *))completion
{
    NSString *lang = [[Parameter sharedInstance] getValueOfKey:ParamLanguage];
    NSString *key = [NSString stringWithFormat:@"%ld_%@_%@_%@", (long)columnId, mediaId, provider, lang];
    MediaItem *ret = [_mediaDetailMap objectForKey:key];
    if (ret) {
        if (completion) {
            completion(ret,nil);
        }
    }else{
        NSString *path = [EpgBase getMediaDetailPath:columnId MediaId:mediaId Provider:provider lang:lang];
        SWMOPQuery *detailQuery = [[SWMOPQuery alloc] init];
        [detailQuery getFromPath:path params:nil parserBlock:^id(id data) {
            if (data && [data isKindOfClass:[NSDictionary class]]) {
                return [[MediaItem alloc] initWithJsonObject:(NSDictionary*)data];
            }
            return nil;
        } completion:^(id result, NSError *error) {
            if (error) {
                MopLogE(@"getMediaDetailWithColumnId:%ld MediaId:%@ provider:%@ erorr. \ncode:%ld info:%@", (long)columnId, mediaId, provider, (long)error.code, error.userInfo);
            }
            
            if (result && [result isKindOfClass:[MediaItem class]]) {
                [_mediaDetailMap setValue:result forKey:key];
            }
            if (completion) {
                completion(result, error);
            }
        }];
        
    }
}


@end
