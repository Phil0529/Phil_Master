//
//  TopicItem.h
//  EZTV
//
//  Created by Lee, Bo on 15/11/4.
//  Copyright © 2015年 Joygo. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "EZMediaItem.h"

@interface TopicItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString* tagName;
@property (nonatomic, copy) NSArray* itemList;

@end
