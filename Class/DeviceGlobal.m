//
//  DeviceGlobal.m
//  MyLinkV
//
//  Created by guoziyi on 13-8-6.
//  Copyright (c) 2013年 bruce. All rights reserved.
//

#import "DeviceGlobal.h"
#import <sys/utsname.h>
#import <CommonCrypto/CommonDigest.h>
#include <sys/param.h>
#include <sys/mount.h>

static DeviceGlobal *device;

@implementation DeviceGlobal
@synthesize macAddr = _macAddr;
@synthesize hardVersion = _hardVersion;

+ (DeviceGlobal *)sharedDevice
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        device = [[DeviceGlobal alloc] init];
    });
    return device;
}

+ (long long)getFreeSpace
{
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/", &buf) >= 0){
        freespace = (long long)buf.f_bsize * buf.f_bfree;
    }
    
    return freespace;
}

- (NSString *)UUID
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

- (NSString *)macAddr
{
    if (!_macAddr) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yy:MM:dd:HH:mm:ss"];
        NSDate *nowDate = [NSDate date];
        _macAddr = [dateFormatter stringFromDate:nowDate];
    }
    return _macAddr;
}

- (NSString *)hardVersion
{
    if (!_hardVersion) {
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        
        NSArray *modelArray = @[

                                @"i386", @"x86_64",
                                
                                @"iPhone1,1",
                                @"iPhone1,2",
                                @"iPhone2,1",
                                @"iPhone3,1",
                                @"iPhone3,2",
                                @"iPhone3,3",
                                @"iPhone4,1",
                                @"iPhone5,1",
                                @"iPhone5,2",
                                @"iPhone5,3",
                                @"iPhone5,4",
                                @"iPhone6,1",
                                @"iPhone6,2",
                                @"iPhone7,2",
                                @"iPhone7,1",
                                
                                @"iPod1,1",
                                @"iPod2,1",
                                @"iPod3,1",
                                @"iPod4,1",
                                @"iPod5,1",
                                
                                @"iPad1,1",
                                @"iPad2,1",
                                @"iPad2,2",
                                @"iPad2,3",
                                @"iPad2,4",
                                @"iPad3,1",
                                @"iPad3,2",
                                @"iPad3,3",
                                @"iPad3,4",
                                @"iPad3,5",
                                @"iPad3,6",
                                
                                @"iPad2,5",
                                @"iPad2,6",
                                @"iPad2,7",
                                ];
        NSArray *modelNameArray = @[
                                    
                                    @"iPhone Simulator", @"iPhone Simulator",
                                    
                                    @"iPhone 2G",
                                    @"iPhone 3G",
                                    @"iPhone 3GS",
                                    @"iPhone 4(GSM)",
                                    @"iPhone 4(GSM Rev A)",
                                    @"iPhone 4(CDMA)",
                                    @"iPhone 4S",
                                    @"iPhone 5(GSM)",
                                    @"iPhone 5(GSM+CDMA)",
                                    @"iPhone 5c(GSM)",
                                    @"iPhone 5c(Global)",
                                    @"iphone 5s(GSM)",
                                    @"iphone 5s(Global)",
                                    @"iPhone 6(Global)",
                                    @"iPhone 6p(Global)",
                                    
                                    @"iPod Touch 1G",
                                    @"iPod Touch 2G",
                                    @"iPod Touch 3G",
                                    @"iPod Touch 4G",
                                    @"iPod Touch 5G",
                                    
                                    @"iPad",
                                    @"iPad 2(WiFi)",
                                    @"iPad 2(GSM)",
                                    @"iPad 2(CDMA)",
                                    @"iPad 2(WiFi + New Chip)",
                                    @"iPad 3(WiFi)",
                                    @"iPad 3(GSM+CDMA)",
                                    @"iPad 3(GSM)",
                                    @"iPad 4(WiFi)",
                                    @"iPad 4(GSM)",
                                    @"iPad 4(GSM+CDMA)",
                                    
                                    @"iPad mini (WiFi)",
                                    @"iPad mini (GSM)",
                                    @"ipad mini (GSM+CDMA)"
                                    ];
        NSInteger modelIndex = - 1;
        NSString *modelNameString = deviceString;
        modelIndex = [modelArray indexOfObject:deviceString];
        if (modelIndex >= 0 && modelIndex < [modelNameArray count]) {
            modelNameString = [modelNameArray objectAtIndex:modelIndex];
        }
        
        _hardVersion = modelNameString;
    }
    return _hardVersion;
}

@end
