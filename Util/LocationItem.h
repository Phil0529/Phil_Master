//
//  LocationItem.h
//  EZTV
//
//  Created by Lee, Bo on 15/11/6.
//  Copyright © 2015年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationItem : NSObject

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;

+ (LocationItem *)newLocation;

@end