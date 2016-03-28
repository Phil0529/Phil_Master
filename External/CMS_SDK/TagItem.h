//
//  TagItem.h
//  EZTV
//
//  Created by Lee, Bo on 15/8/11.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "MTLModel.h"

typedef NS_ENUM(NSUInteger, TagType)
{
    TagType_System = 0,
    TagType_Customize = 1,
};

@interface TagItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) TagType type;

@end
