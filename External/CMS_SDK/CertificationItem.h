//
//  CertificationItem.h
//  EZTV
//
//  Created by Sunniwell on 8/12/15.
//  Copyright (c) 2015 Joygo. All rights reserved.
//

#import "MTLModel.h"

@interface CertificationItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) BOOL code;
@property (nonatomic, copy) NSString *message;

@end

@interface CertificationInfo : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *mpno;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSNumber *status;
@property (nonatomic, copy) NSString *applyreasons;
@property (nonatomic, copy) NSString *idpics;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *idnumber;
@property (nonatomic, copy) NSString *place;
@property (nonatomic, copy) NSString *occupation;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *roles;
@property (nonatomic, assign) NSInteger issign;
@property (nonatomic, copy) NSString *rejectreasons;

@end

