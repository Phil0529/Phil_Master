//
//  LocationManager.m
//  Primary
//
//  Created by Phil Xhc on 15/11/27.
//  Copyright © 2015年 Xhc. All rights reserved.
//

#import "LocationManager.h"
#import <AMapLocationKit/AMapLocationKit.h>


NSString *const LOCATION_INFORMATION = @"Location_Information_Notication";

@interface LocationManager()<AMapLocationManagerDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) AMapLocationManager *locationManager;

@property (nonatomic, strong) UIAlertView *locationApplicationAlert;
@property (nonatomic, strong) UIAlertView *locationSystemAlert;
@end

@implementation LocationManager

- (void)stopGetLocation{
    [self.locationManager stopUpdatingLocation];
}

- (void)startGetLocation{

    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    __weak __typeof(self) weakSelf = self;
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            SWLogD(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code)
            {
                SWLogD(@"%li",(long)error.code);
            }
        }
        if (location) {
            [weakSelf.locationItem setLatitude:[NSString stringWithFormat:@"%.16f",(CGFloat)location.coordinate.latitude]];
            [weakSelf.locationItem setLongitude:[NSString stringWithFormat:@"%.16f",(CGFloat)location.coordinate.longitude]];
            if (regeocode)
            {
                [weakSelf.locationItem setAddress:regeocode.formattedAddress];
                [[NSNotificationCenter defaultCenter] postNotificationName:LOCATION_INFORMATION object:self.locationItem];
                [weakSelf stopGetLocation];
            }
            else{
                SWLogD(@"反地理编码失败");
            }
        }
    }];
}

- (LocationItem *)locationItem{
    if (!_locationItem) {
        _locationItem = [LocationItem newLocation];
    }
    return _locationItem;
}


@end
