//
//  UserInfoItem.h
//  EZTV
//
//  Created by Sunni on 15/6/5.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoItem : NSObject<NSCoding>

@property (nonatomic, strong) NSString *userCookie;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *headImg;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *mpno;
@property (nonatomic, assign) NSInteger gender;

@end
