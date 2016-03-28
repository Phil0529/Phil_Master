//
//  FlvRealUrlQuery.m
//  SWMOP
//
//  Created by Lee, Bo on 14/11/26.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import "FlvRealUrlQuery.h"
#import "AFXmlAPIClient.h"
#import "AFHttpAPIClient.h"
#import "AFJsonAPIClient.h"
#import "MopLog.h"
#import "FlvcdXmlItem.h"
#import "XmlDataParser.h"
#import "EpgBase.h"


static NSString *urlPrefix = @"http://vparis.flvcd.com/remote/zhongtian_m3u8.php?url=";

@implementation FlvRealUrlQuery
{
    NSInteger _reqQuality;
    NSString *_requestUrl;
}

- (void)getRealUrlItem:(NSString *)url quality:(UrlQuality)quality completion:(flvRealUrlQueryCompletion)completion
{
    NSString *format;
    switch (quality) {
        case QUALITY_LOW:
        case QUALITY_STANDARD:
            format = @"normal"; //标清
            break;
        case QUALITY_HIGH:
            format = @"high";   //高清
            break;
        case QUALITY_720P:
            format = @"super2"; //超高清
            break;
        case QUALITY_UNKNOWN:
        case QUALITY_SUPER:
        default:
            format = @"super";  // 默认超清
            break;
    }
    NSString *encodeUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    _reqQuality = quality;
    _requestUrl = encodeUrl;
    NSString *path = [NSString stringWithFormat:@"%@%@&format=%@", urlPrefix, encodeUrl, format];
    
    [[AFXmlAPIClient sharedClient] GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSXMLParser class]]) {
            NSXMLParser *dataParser = (NSXMLParser*)responseObject;
            XmlDataParser *parserDelegate = [[XmlDataParser alloc] init];
            [parserDelegate setCompleteion:^(NSArray *list) {
                FlvcdXmlItem *responseItem = [[FlvcdXmlItem alloc] initWithDataArray:list];
                if (!responseItem || responseItem.error) {
                    NSError *error = [NSError errorWithDomain:@"net.sunniwell.swmop.realurlQuery"
                                                         code:Error_FlvError
                                                     userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"none result", @"desc", responseItem.description, @"info", nil]];
                    if (completion) {
                        completion(nil, error);
                    }
                } else {
                    [self parseXmlResponse:responseItem completion:completion];
                }
            }];
            [dataParser setDelegate:parserDelegate];
            [dataParser parse];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        MopLogE(@"FlvRealUrlQuery getRealUrlItem erorr \n code:%ld info:%@", (long)error.code, error.userInfo);
        if (completion) {
            completion(nil, error);
        }
    }];
}

- (void)parseXmlResponse:(FlvcdXmlItem*)xmlItem completion:(flvRealUrlQueryCompletion)completion
{
    if ([xmlItem.TYPE isEqualToString:@"DIRECT"]) {
        //解析即用型
        RealUrlItem *result = [[RealUrlItem alloc] init];
        [result setMTitle:xmlItem.title];
        NSString *urlStr = [xmlItem.U firstObject];
        if (urlStr) {
            [result setMUrl:[urlStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        }
        [result setMQualitys:xmlItem.formatList];
        [result setMQuality:_reqQuality];
        if (completion) {
            completion(result, nil);
        }
    } else if ([xmlItem.TYPE isEqualToString:@"CUSTOM"]) {
        //需要二次请求
        if ([xmlItem.url rangeOfString:@"v.pptv.com"].length > 0) {
            [[AFHttpAPIClient sharedClient] GET:xmlItem.C parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                NSString *kC = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSRange rTs = [kC rangeOfString:xmlItem.ts options:NSCaseInsensitiveSearch];
                NSRange rTe = [kC rangeOfString:xmlItem.te options:NSCaseInsensitiveSearch
                                          range:NSMakeRange(rTs.location + rTs.length, kC.length - rTs.length - rTs.location)];
                NSRange rIP = NSMakeRange(rTs.location + rTs.length, rTe.location - rTs.location - rTs.length);
                NSString *ip = [kC substringWithRange:rIP];
                
                RealUrlItem *result = [[RealUrlItem alloc] init];
                [result setMTitle:xmlItem.title];
                NSString *urlStr = [xmlItem.U firstObject];
                if (urlStr) {
                    [result setMUrl:[urlStr stringByReplacingOccurrencesOfString:@"v.pptv.com" withString:ip]];
                }
                [result setMQualitys:xmlItem.formatList];
                [result setMQuality:_reqQuality];
                if (completion) {
                    completion(result, nil);
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                MopLogE(@"FlvRealUrlQuery parseXmlResponse pptv erorr \n code:%ld info:%@", (long)error.code, error.userInfo);
                if (completion) {
                    completion(nil, error);
                }
            }];
        } else if ([xmlItem.url rangeOfString:@"www.letv.com"].length > 0) {
            [[AFHttpAPIClient sharedClient] GET:xmlItem.C parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                NSString *kC = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSRange rTs = [kC rangeOfString:xmlItem.ts options:NSCaseInsensitiveSearch];
                NSRange rTe = [kC rangeOfString:xmlItem.te options:NSCaseInsensitiveSearch
                                                    range:NSMakeRange(rTs.location + rTs.length, kC.length - rTs.length - rTs.location)];
                NSRange rUrl = NSMakeRange(rTs.location + rTs.length, rTe.location - rTs.location - rTs.length);
                NSString *url = [kC substringWithRange:rUrl];
                url = [url stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
                RealUrlItem *result = [[RealUrlItem alloc] init];
                [result setMTitle:xmlItem.title];
                [result setMUrl:url];
                [result setMQualitys:xmlItem.formatList];
                [result setMQuality:_reqQuality];
                if (completion) {
                    completion(result, nil);
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                MopLogE(@"FlvRealUrlQuery parseXmlResponse letv erorr \n code:%ld info:%@", (long)error.code, error.userInfo);
                if (completion) {
                    completion(nil, error);
                }
            }];
        } else {
            //本地逻辑无法解析,去Epgs拿
            NSString *path = [EpgBase getRealUrlPath:_requestUrl Quality:_reqQuality];
            [[AFJsonAPIClient sharedClient] GET:path parameters:nil
                                        success:
             ^(NSURLSessionDataTask *task, id responseObject) {
                 RealUrlItem *urlItem;
                 if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                     urlItem = [[RealUrlItem alloc] initWithJsonObject:responseObject];
                 }
                 if (completion) {
                     completion(urlItem, nil);
                 }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                if (error) {
                    MopLogE(@"getRealUrlItem parseXmlResponse epg erorr \n code:%ld info:%@", (long)error.code, error.userInfo);
                }
                if (completion) {
                    completion(nil, error);
                }
            }];
        }
    }
}


@end
