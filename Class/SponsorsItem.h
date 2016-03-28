//
//  SponsorsItem.h
//  EZTV
//
//  Created by Phil Xhc on 16/1/21.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,SponsorsType) {
    SponsorsType_Name           = 0,
    SponsorsType_Photo          = 1,
    SponsorsType_ContactPeople  = 2,
    SponsorsType_ContactPhone   = 3,
    SponsorsType_ContactAddress = 4,
    SponsorsType_Detail         = 5,
    SponsorsType_Reason         = 6,
};

@interface SponsorsItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) CGFloat space;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) SponsorsType type;


+ (instancetype)initWithTitle:(NSString *)title space:(CGFloat)space height:(CGFloat)height type:(SponsorsType)type;

@end
