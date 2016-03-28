//
//  LaunchAdModel.h
//  EZTV
//
//  Created by Lee, Bo on 15/10/9.
//  Copyright © 2015年 Joygo. All rights reserved.
//

#import "MTLModel.h"

@interface LaunchAdModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *pics;

@end
