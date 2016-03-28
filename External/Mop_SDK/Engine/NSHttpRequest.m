//
//  NSHttp.m
//  SWMOP
//
//  Created by Lee, Bo on 14/12/12.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import "NSHttpRequest.h"
#import "MopLog.h"

@implementation HttpResponse

@synthesize mStatusCode = _mStatusCode;
@synthesize mLocation = _mLocation;
@synthesize mEpgsIp = _mEpgsIp;
@synthesize mEpgsToken = _mEpgsToken;
@synthesize mOisIp = _mOisIp;
@synthesize mOisToken = _mOisToken;
@synthesize mSoapBody = _mSoapBody;
@synthesize mExtend = _mExtend;

- (NSString*)description
{
    return [NSString stringWithFormat:@"SoapResponse statusCode=%d oisToken=%@ epgsToken=%@ ois=%@ epgs=%@ body=%@", _mStatusCode, _mOisToken, _mEpgsToken, _mOisIp, _mEpgsIp, _mSoapBody];
}

@end

@implementation HttpDelegate
{
    HttpResponseCompletion _completion;
}

- (instancetype)initWithCompletion:(HttpResponseCompletion)completion
{
    self = [super init];
    if (self) {
        _completion = completion;
        _mResponse = [[HttpResponse alloc]init];
        _mData = [[NSMutableData alloc] init];
    }
    return self;
}
//- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
//{
//    
//}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse =(NSHTTPURLResponse*)response;
    if ([httpResponse respondsToSelector:@selector(allHeaderFields)]) {
        NSDictionary *dictionary = [httpResponse allHeaderFields];
        _mResponse.mStatusCode = [httpResponse statusCode];
        _mResponse.mOisToken = [dictionary objectForKey:@"Token"];
        _mResponse.mEpgsToken = [dictionary objectForKey:@"EPGS-Token"];
        _mResponse.mOisIp = [dictionary objectForKey:@"OIS"];
        _mResponse.mEpgsIp = [dictionary objectForKey:@"EPGS"];
        _mResponse.mLocation = [dictionary objectForKey:@"Location"];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_mData appendData:data];
}

//- (NSInputStream *)connection:(NSURLConnection *)connection needNewBodyStream:(NSURLRequest *)request
//{
//    
//}

//- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
//{
//    
//}

//
//- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
//{
//    
//}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _mResponse.mSoapBody = [[NSString alloc] initWithData:_mData encoding:NSUTF8StringEncoding];
    if (_completion) {
        _completion(_mResponse);
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    _mResponse.mStatusCode = error.code;
    if (_completion) {
        _completion(_mResponse);
    }
}


#pragma --mark https delegate

//IOS8
//- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection
//{
//    
//}
//
//- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
//{
//    
//}

//IOS8-
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    
}


@end

@implementation NSHttpRequest

+ (void)GET:(NSString *)path timeout:(NSInteger)timeout completion:(HttpResponseCompletion)completion
{
    MopLogD(@"SoapHttps get path: %@", path);
    NSString* encodedString = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encodedString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    HttpDelegate *soapDelegate = [[HttpDelegate alloc] initWithCompletion:completion];
    NSURLConnection *urlConnection = [NSURLConnection connectionWithRequest:request delegate:soapDelegate];
    
    if (urlConnection != nil){
        MopLogD(@"SoapHttps get Successfully created the connection");
    } else {
        MopLogE(@"SoapHttps get Could not create the connection");
    }
    
}

+ (void)POST:(NSString *)path content:(NSString *)content timeout:(NSInteger)timeout completion:(HttpResponseCompletion)completion
{
    MopLogD(@"SoapHttps post path: %@, \n content : %@", path, content);
    NSString* encodedString = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL    *url = [NSURL URLWithString:encodedString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:timeout];
    [request setHTTPMethod:@"POST"];
    //这里设置为 application/x-www-form-urlencoded ，如果设置为其它的，比如text/html;charset=utf-8，或者 text/html 等，都会出错。不知道什么原因。
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    //将NSSrring格式的参数转换格式为NSData，POST提交必须用NSData数据。
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    //计算POST提交数据的长度
    NSString *contentLength = [NSString stringWithFormat:@"%d",[contentData length]];
    //设置http-header:Content-Length
    [request setValue:contentLength forHTTPHeaderField:@"Content-Length"];
    
    //设置需要post提交的内容
    [request setHTTPBody:contentData];
    
    HttpDelegate *soapDelegate = [[HttpDelegate alloc] initWithCompletion:completion];
    
    NSURLConnection *urlConnection = [NSURLConnection connectionWithRequest:request delegate:soapDelegate];
    
    if (urlConnection != nil){
        MopLogD(@"SoapHttps post Successfully created the connection");
    } else {
        MopLogE(@"SoapHttps post Could not create the connection");
    }
}

@end
