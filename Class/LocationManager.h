//
//  LocationManager.h
//  Primary
//
//  Created by Phil Xhc on 15/11/27.
//  Copyright © 2015年 Xhc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationItem.h"

UIKIT_EXTERN NSString *const  LOCATION_INFORMATION;
UIKIT_EXTERN NSString *const  OPEN_SYSTEM_LOCATION_SERVICE;

@interface LocationManager : NSObject

@property (nonatomic, strong) NSString *needLocaPage;
@property (nonatomic, strong) LocationItem *locationItem;

- (void)startGetLocation;
- (void)stopGetLocation;


@end
