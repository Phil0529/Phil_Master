//
//  LiveQuery.m
//  EZTV
//
//  Created by Lee, Bo on 15/8/11.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "LiveQuery.h"
#import "UserCenter.h"

@implementation LiveQuery

+ (AFHTTPRequestOperation *)getTagList:(void (^)(NSArray *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    return [[OVCCMSClient newClient] GET:@"lives/get_columns" parameters:params resultClass:[TagItem class] resultKeyPath:@"list" completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)getLiveHomeDataArray:(void (^)(NSArray *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    return [[OVCCMSClient newClient] GET:@"lives/get_home" parameters:params resultClass:[LiveHomeItem class] resultKeyPath:@"list" completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)getLiveListWithTagName:(NSString *)tagName tagType:(NSString *)tagType liveType:(NSString *)liveType liveId:(NSString *)liveId pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize completion:(void (^)(NSArray *))completion
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   tagName, @"columnname",
                                   tagType, @"columntype",
                                   liveType, @"livetype",
                                   @(pageIndex), @"pageindex",
                                   @(pageSize), @"pagesize",
                                   REVIEW_VER, VER_KEY,
                                   OS_VERSION, OS_KEY,
                                   PROJECT_ID, PROJECT_KEY, nil];
    if (!ISEMPTYSTR(liveId)) {
        [params setObject:liveId forKey:@"_id"];
    }
    return [[OVCCMSClient newClient] GET:@"lives/get_lives" parameters:params resultClass:[LiveItem class] resultKeyPath:@"list" completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)getLiveDetailWithLiveId:(NSString *)lid completion:(void (^)(LiveItem *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            lid, @"_id",
                            [UserCenter defaultCenter].currentUser.mpno, @"mpno",
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    return [[OVCCMSClient newClient] GET:@"lives/get_detail" parameters:params resultClass:[LiveItem class] resultKeyPath:@"data" completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)sendLiveRequestWithType:(LiveType)liveType lid:(NSString *)lid startTime:(NSTimeInterval)startTime title:(NSString *)title desc:(NSString *)desc uid:(NSString *)uid cid:(NSString *)cid tid:(NSString *)tid cdsid:(NSString *)cdsid tagName:(NSString *)tagName tagType:(TagType)tagType cover:(NSString *)cover lon:(NSString *)lon lat:(NSString *)lat address:(NSString *)address city:(NSString *)city showLocation:(NSString *)show completion:(void (^)(LiveResponseModel *))completion
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @(liveType), @"type",
                                   [UserCenter defaultCenter].currentUser.mpno,@"mpno",
                                   [UserCenter defaultCenter].currentUser.headImgUri, @"face",
                                   [UserCenter defaultCenter].currentUser.nickName, @"nickname",
                                   title, @"title",
                                   desc, @"desc",
                                   tagName, @"columnsname",
                                   @(tagType), @"columnstype",
                                   cover, @"pics",
                                   show, @"show",
                                   uid, @"uid",
                                   cid, @"cid",
                                   tid, @"tid",
                                   cdsid, @"cdsid",
                                   lon, @"lon",
                                   lat, @"lat",
                                   address, @"address",
                                   city, @"city",
                                   REVIEW_VER, VER_KEY,
                                   OS_VERSION, OS_KEY,
                                   PROJECT_ID, PROJECT_KEY,
                                   nil];
    if (!ISEMPTYSTR(lid)) {
        [params setObject:lid forKey:@"_id"];
    }
    if (liveType == LiveType_Trailer) {
        [params setObject:@(startTime) forKey:@"starttime"];
    }
    OVCCMSClient *cmsClient = [OVCCMSClient newClient];
    [cmsClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [cmsClient POST:@"lives/set_lives" parameters:params resultClass:[LiveResponseModel class] resultKeyPath:nil completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)getTrailerListWithMpno:(NSString *)mpno pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize completion:(void (^)(NSArray *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            mpno, @"mpno",
                            @(pageIndex), @"pageindex",
                            @(pageSize), @"pagesize",
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    return [[OVCCMSClient newClient] GET:@"lives/get_trailer_near" parameters:params resultClass:[LiveItem class] resultKeyPath:@"list" completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)stopLiveStreamWithLiveId:(NSString *)lid completion:(void (^)(LiveResponseModel *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            lid,@"_id",
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    OVCCMSClient *cmsClient = [OVCCMSClient newClient];
    [cmsClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [cmsClient POST:@"lives/set_lives_destroy" parameters:params resultClass:[LiveResponseModel class] resultKeyPath:nil completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)startPushLiveStreamWithLiveId:(NSString *)lid completion:(void (^)(LiveResponseModel *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            lid,@"_id",
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    OVCCMSClient *cmsClient = [OVCCMSClient newClient];
    [cmsClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [cmsClient POST:@"lives/set_lives_notice" parameters:params resultClass:[LiveResponseModel class] resultKeyPath:nil completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)getCertificateInfo:(void (^)(CertificationInfo *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [UserCenter defaultCenter].currentUser.mpno,@"mpno",
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];

    return [[OVCCMSClient newClient] GET:@"lives/get_users" parameters:params resultClass:[CertificationInfo class] resultKeyPath:@"data" completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)postCertificateInfoWithNickName:(NSString *)nickName occupation:(NSString *)occupation place:(NSString *)NativePlace IDNumber:(NSString *)IDNum photo:(NSString *)photoStr phoneNo:(NSString *)phoneNo applyReasons:(NSString *)reasons completion:(void (^)(CertificationItem *certificate))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [UserCenter defaultCenter].currentUser.mpno,@"mpno",
                            nickName,@"name",
                            occupation,@"occupation",
                            NativePlace,@"place",
                            IDNum,@"idnumber",
                            phoneNo,@"phone",
                            reasons,@"applyreasons",
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY,
                            photoStr,@"idpics",nil];
    OVCCMSClient *cmsClient = [OVCCMSClient newClient];
    [cmsClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [cmsClient POST:@"lives/set_users" parameters:params resultClass:[CertificationItem class] resultKeyPath:nil completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)feedbackWithContent:(NSString *)content contact:(NSString *)contact type:(NSString *)type from:(NSInteger)from mid:(NSString *)mid completion:(void (^)(LiveResponseModel *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [UserCenter defaultCenter].currentUser.mpno,@"mpno",
                            content,@"content",
                            contact,@"contact",
                            type,@"feedbacktype",
                            @(from),@"from",
                            mid,@"mid",
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    OVCCMSClient *cmsClient = [OVCCMSClient newClient];
    [cmsClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [cmsClient POST:@"set_feedback" parameters:params resultClass:[CertificationItem class] resultKeyPath:nil completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)assitLiveWithCount:(NSInteger)count lid:(NSString *)lid completion:(void (^)(LiveResponseModel *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @(count), @"assistcount",
                            lid, @"_id",
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    OVCCMSClient *cmsClient = [OVCCMSClient newClient];
    [cmsClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [cmsClient POST:@"lives/set_lives_assist" parameters:params resultClass:[CertificationItem class] resultKeyPath:nil completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)saveLiveHistoryWithLiveID:(NSString *)lid completion:(void (^)(LiveResponseModel *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            lid, @"_id",
                            [UserCenter defaultCenter].currentUser.mpno, @"mpno",
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    OVCCMSClient *cmsClient = [OVCCMSClient newClient];
    [cmsClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [cmsClient POST:@"lives/set_lives_histories" parameters:params resultClass:[CertificationItem class] resultKeyPath:nil completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)liveSignWithAddress:(NSString *)address lon:(NSString *)lon lat:(NSString *)lat city:(NSString *)city completion:(void (^)(LiveResponseModel *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [UserCenter defaultCenter].currentUser.mpno, @"mpno",
                            address, @"address",
                            lon, @"lon",
                            lat, @"lat",
                            city, @"city",
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    OVCCMSClient *cmsClient = [OVCCMSClient newClient];
    [cmsClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [cmsClient POST:@"lives/set_signs" parameters:params resultClass:[LiveResponseModel class] resultKeyPath:nil completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)checkLiveAuthentication:(void (^)(LiveAuthItem *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [UserCenter defaultCenter].currentUser.mpno, @"mpno",
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    OVCCMSClient *cmsClient = [OVCCMSClient newClient];
    [cmsClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [cmsClient GET:@"lives/get_lives_status" parameters:params resultClass:[LiveAuthItem class] resultKeyPath:nil completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)getViewCountWithLiveID:(NSString *)lid completion:(void (^)(CountItem *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            lid, @"_id",
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    OVCCMSClient *cmsClient = [OVCCMSClient newClient];
    [cmsClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [cmsClient GET:@"get_statistics" parameters:params resultClass:[CountItem class] resultKeyPath:@"data" completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

@end
