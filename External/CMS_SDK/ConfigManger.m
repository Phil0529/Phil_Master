//
//  ConfigManger.m
//  EZTV
//
//  Created by Sunni on 15/6/17.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "ConfigManger.h"
#import "AFCMSClient.h"
#import "LiveQuery.h"
#import "CMSDataQuery.h"
#import <TMCache/TMCache.h>

NSString* const menuKey = @"tabmenu.key";
NSString* const mapKey = @"configmap.key";

@implementation ConfigManger

@synthesize isShield = _isShield;
@synthesize tagArray = _tagArray;
@synthesize tabMenuArray = _tabMenuArray;
@synthesize configMap = _configMap;

+ (ConfigManger *)sharedManager
{
    static ConfigManger *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ConfigManger alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
#ifdef RELEASE_VER
        _isShield = NO;
        [self checkAppNeedShield];
#else
        _isShield = NO;
#endif
        _tabMenuArray = [[TMCache sharedCache] objectForKey:menuKey];
        [self refreshTabMenuArray];
        _configMap = [[TMCache sharedCache] objectForKey:mapKey];
        if (!_configMap) {
            _configMap = [[ConfigMap alloc] init];
        }
        [self refreshConfigMap];
        [self refreshTagArray];
    }
    return self;
}

- (void)refreshTagArray
{
    __weak __typeof(self) weakSelf = self;
    [LiveQuery getTagList:^(NSArray *result) {
        if (weakSelf) {
            [weakSelf setTagArray:result];
        }
    }];
}

- (void)setTagArray:(NSArray *)tagArray
{
    _tagArray = tagArray;
}

- (void)refreshTabMenuArray
{
    __weak __typeof(self) weakSelf = self;
    [CMSDataQuery queryTabMenuDataArray:^(NSArray *result) {
        if (weakSelf) {
            [weakSelf saveTabMenuToCache:result];
        }
    }];
}

- (void)saveTabMenuToCache:(NSArray *)result
{
    if ([result count] > 0) {
        _tabMenuArray = result;
        [[TMCache sharedCache] setObject:_tabMenuArray forKey:menuKey block:nil];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(managerDidFinishRefresh)]) {
        [self.delegate managerDidFinishRefresh];
    }
}

- (NSArray *)tabMenuArray
{
    NSMutableArray *tabArray = [[NSMutableArray alloc] initWithCapacity:5];
//    MenuItem *test = [MenuItem defaultItem];
//    [test setName:LBLocalized(@"定位")];
//    test.cid = 1010101;
//    test.adstatus = 1;
//    test.haschild = 1;
//    test.menutype = MenuTypeLocation;
//    test.tabIcon = TabIconVideo;
//    [tabArray addObject:test];
    
    MenuItem *test2 = [MenuItem defaultItem];
    [test2 setName:LBLocalized(@"等待付款")];
    test2.cid = 1010101;
    test2.adstatus = 1;
    test2.haschild = 1;
    test2.menutype = MenuTypePay;
    test2.tabIcon = TabIconVideo;
    [tabArray addObject:test2];
    
    return tabArray;
}

- (void)refreshConfigMap
{
    __weak __typeof(self) weakSelf = self;
    [CMSDataQuery queryConfigDataMap:^(ConfigMap *result) {
        if (weakSelf) {
            [weakSelf setConfigMap:result];
        }
    }];
}

- (void)setConfigMap:(ConfigMap *)configMap
{
    if (configMap) {
        _configMap = configMap;
        [[TMCache sharedCache] setObject:_configMap forKey:mapKey block:nil];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(managerDidFinishRefresh)]) {
        [self.delegate managerDidFinishRefresh];
    }
}

- (void)checkAppNeedShield
{
    NSDictionary *params = @{VER_KEY:REVIEW_VER,
                             OS_KEY:OS_VERSION,
                             PROJECT_KEY:PROJECT_ID};
    [[AFCMSClient newClient] GET:@"get_system_config"
                      parameters:params
                         success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
             NSInteger code = [[(NSDictionary *)responseObject objectForKey:@"code"] integerValue];
             if (code == 0) {
                 _isShield = YES;
             }
         }
     } failure:nil];
}

@end
