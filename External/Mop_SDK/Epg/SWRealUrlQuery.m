//
//  SWRealUrlQuery.m
//  SWMOP
//
//  Created by Lee, Bo on 14-5-27.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import "SWRealUrlQuery.h"
#import "SWMOPQuery.h"

@implementation SWRealUrlQuery

- (NSURLSessionDataTask *)getRealUrlItem:(NSString *)url quality:(NSInteger)quality completion:(void(^)(RealUrlItem *, NSError *))completion
{
    NSString *encodeUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *path = [EpgBase getRealUrlPath:encodeUrl Quality:quality];
    SWMOPQuery *query = [[SWMOPQuery alloc] init];
    return [query getFromPath:path params:nil parserBlock:^id(id data) {
        if (data && [data isKindOfClass:[NSDictionary class]]) {
            return [[RealUrlItem alloc] initWithJsonObject:data];
        }
        return nil;
    } completion:^(id result, NSError *error) {
        if (error) {
            MopLogE(@"getRealUrlItem erorr \n code:%ld info:%@", (long)error.code, error.userInfo);
        }
        if (completion) {
            completion(result, error);
        }
    }];
}

@end
