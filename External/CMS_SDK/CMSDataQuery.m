//
//  CMSDataQuery.m
//  EZTV
//
//  Created by Sunni on 15/7/15.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "CMSDataQuery.h"
#import "UserCenter.h"
#import "OVCCMSClient.h"
#import "Base64Helper.h"

@implementation CMSDataQuery

+ (AFHTTPRequestOperation *)getLaunchAdArray:(void (^)(NSArray *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    return [[OVCCMSClient newClient] GET:@"get_start_pics" parameters:params resultClass:[LaunchAdModel class] resultKeyPath:@"list" completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)getMenuPageDataArray:(void(^)(NSArray *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    return [[OVCCMSClient newClient] GET:@"get_menu" parameters:params resultClass:[MenuItem class] resultKeyPath:@"list" completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)queryTabMenuDataArray:(void (^)(NSArray *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    return [[OVCCMSClient newClient] GET:@"get_menu_bottom" parameters:params resultClass:[MenuItem class] resultKeyPath:@"list" completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)queryConfigDataMap:(void (^)(ConfigMap *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    return [[OVCCMSClient newClient] GET:@"get_init_config_add" parameters:params resultClass:[ConfigMap class] resultKeyPath:@"data" completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)queryHomePageDataArrayFromNet:(void (^)(NSArray *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    return [[OVCCMSClient newClient] GET:@"get_ios_home" parameters:params resultClass:[HomeItem class] resultKeyPath:@"list" completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)queryServiceDataArrayFromNet:(void (^)(NSArray *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    return [[OVCCMSClient newClient] GET:@"get_service" parameters:params resultClass:[HomeItem class] resultKeyPath:@"list" completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)queryDiscoveryDataArrayFromNet:(void (^)(NSArray *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    return [[OVCCMSClient newClient] GET:@"get_found" parameters:params resultClass:[MenuMap class] resultKeyPath:nil completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            if ([responseObject isKindOfClass:[MenuMap class]]) {
                MenuMap *map = responseObject;
                NSMutableArray *menuMap = [[NSMutableArray alloc] initWithCapacity:[map.list count]];
                for (NSArray *arr in map.list) {
                    NSArray *menuArray = [MTLJSONAdapter modelsOfClass:[MenuItem class] fromJSONArray:arr error:NULL];
                    [menuMap addObject:menuArray];
                }
                completion(menuMap);
            }
            else{
                completion(nil);
            }
        }
    }];
}

+ (AFHTTPRequestOperation *)queryAdDataWithCid:(NSInteger)cid completion:(void (^)(NSArray *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @(cid), @"adposition",
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    return [[OVCCMSClient newClient] GET:@"get_ad" parameters:params resultClass:[AdItem class] resultKeyPath:@"list" completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)queryTopicNewsArrayWithMid:(NSString *)mid completion:(void (^)(NSArray *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            mid, @"mid",
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    return [[OVCCMSClient newClient] GET:@"get_specials_group" parameters:params resultClass:[TopicItem class] resultKeyPath:@"list" completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)removeMyUploadsWithIds:(NSString *)ids completion:(void (^)(ResponseModel *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            ids, @"_ids",
                            [UserCenter defaultCenter].currentUser.mpno, @"mpno",
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    OVCCMSClient *cmsClient = [OVCCMSClient newClient];
    [cmsClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [cmsClient POST:@"delete_myuploads" parameters:params resultClass:[ResponseModel class] resultKeyPath:nil completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)getMyFavoriteArraybyMpno:(NSString *)mpno completion:(void (^)(NSArray *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            mpno, @"mpno",
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    OVCCMSClient *cmsClient = [OVCCMSClient newClient];
    [cmsClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [cmsClient GET:@"get_favorites" parameters:params resultClass:EZMediaItem.class resultKeyPath:@"list" completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)unFavoriteWithItemId:(NSString *)fId mpno:(NSString *)mpno completion:(void (^)(ResponseModel *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            mpno, @"mpno",
                            fId, @"_id",
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    OVCCMSClient *cmsClient = [OVCCMSClient newClient];
    [cmsClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [cmsClient POST:@"delete_favorites" parameters:params resultClass:[ResponseModel class] resultKeyPath:nil completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
}

+ (AFHTTPRequestOperation *)postApplyInfomation:(SponsorsInfo *)info completion:(void (^)(ResponseModel *result))completion{
    
    NSMutableDictionary *params;
    NSDictionary *baseParams = @{VER_KEY:REVIEW_VER,
                                 OS_KEY:OS_VERSION,
                                 PROJECT_KEY:PROJECT_ID,
                                 @"name":info.name,
                                 @"mpno":[UserCenter defaultCenter].currentUser.mpno,
                                 @"phone":info.contactPhone,
                                 @"ads":info.contactAddress,
                                 @"nickname":info.contactPeople,
                                 @"cause":info.applyReason,
                                 @"desc":info.detailInfo };
    params = [[NSMutableDictionary alloc] initWithDictionary:baseParams];

    if (info.sId.length > 0) {
        [params addEntriesFromDictionary:@{@"id":info.sId}];
    }
    if (info.photo) {
        [params addEntriesFromDictionary:@{@"img":[Base64Helper image2String:info.photo]}];
    }
    OVCCMSClient *cmsClient = [OVCCMSClient newClient];
    [cmsClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [cmsClient POST:ACTION_SET_SPONSORS parameters:params resultClass:[ResponseModel class] resultKeyPath:nil completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject);
        }
    }];
    
}


+ (AFHTTPRequestOperation *)getSponsorsListCompletion:(void (^)(NSArray *result))completion{
    NSDictionary *params = @{VER_KEY:REVIEW_VER,
                             OS_KEY:OS_VERSION,
                             PROJECT_KEY:PROJECT_ID,
                             };
    
    OVCCMSClient *cmsClient = [OVCCMSClient newClient];
    [cmsClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [cmsClient GET:ACTION_GET_SPONSORS parameters:params resultClass:[SponsorsInfoResponse class] resultKeyPath:nil completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            if (responseObject) {
                SponsorsInfoResponse *response = responseObject;
                completion(response.list);
            }
            
        }
    }];
}

+ (AFHTTPRequestOperation *)getSponsorsStatus:(NSString *)mpno Completion:(void (^)(NSArray *))completion{
    NSDictionary *params = @{@"mpno":mpno,
                             VER_KEY:REVIEW_VER,
                             OS_KEY:OS_VERSION,
                             PROJECT_KEY:PROJECT_ID,
                             };
    
    OVCCMSClient *cmsClient = [OVCCMSClient newClient];
    [cmsClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    return [cmsClient GET:ACTION_GET_SPONSORSDETAIL parameters:params resultClass:[SponsorsInfoResponse class] resultKeyPath:nil completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (completion) {
            if (responseObject) {
                SponsorsInfoResponse *response = responseObject;
                completion(response.list);
            }
            
        }
    }];
}

@end
