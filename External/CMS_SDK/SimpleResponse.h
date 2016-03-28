//
//  SimpleResponse.h
//  Master
//
//  Created by Phil Xhc on 3/23/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface SimpleResponse : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSNumber *code;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSNumber *data;

@end
