//
//  SponsorsListItem.h
//  EZTV
//
//  Created by Phil Xhc on 16/1/21.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface SponsorsListItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSNumber *sId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imgURL;

@end


@interface SponsorsListItemResponse : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSNumber *code;
@property (nonatomic, strong) NSArray *list;

@end
