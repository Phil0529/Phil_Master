//
//  DeviceGlobal.h
//  MyLinkV
//
//  Created by guoziyi on 13-8-6.
//  Copyright (c) 2013年 bruce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString* const gFontEn  =  @"Helvetica";
static NSString* const gFontEnBold  =  @"Helvetica-Bold";
static NSString* const gFontCn  = @"STHeitiSC-Medium";
//@"STHeitiSC-Medium";
//  @"STHeitiSC-Light";

@interface DeviceGlobal : NSObject

@property (nonatomic, readonly) NSString *UUID;
@property (nonatomic, readonly) NSString *macAddr;
@property (nonatomic, readonly) NSString *hardVersion;

+ (DeviceGlobal *)sharedDevice;
+ (long long)getFreeSpace;

@end
