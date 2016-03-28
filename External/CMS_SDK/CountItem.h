//
//  CountItem.h
//  EZTV
//
//  Created by Lee, Bo on 16/3/2.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CountItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString* count;

@end
