//
//  SWRealUrlQuery.h
//  SWMOP
//
//  Created by Lee, Bo on 14-5-27.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import "SWMOPQuery.h"
#import "RealUrlItem.h"

@interface SWRealUrlQuery : NSObject

- (NSURLSessionDataTask*)getRealUrlItem:(NSString *)url quality:(NSInteger)quality completion:(void(^)(RealUrlItem *urlItem ,NSError *error))completion;

@end
