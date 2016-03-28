//
//  FlvRealUrlQuery.h
//  SWMOP
//
//  Created by Lee, Bo on 14/11/26.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RealUrlItem.h"

typedef NS_ENUM(NSInteger, FlvError) {
    Error_FlvError = 889,
    Error_NotSupport = 899
};

typedef void(^flvRealUrlQueryCompletion)(RealUrlItem *urlItem ,NSError *error);

@interface FlvRealUrlQuery : NSObject

- (void)getRealUrlItem:(NSString *)url quality:(UrlQuality)quality completion:(flvRealUrlQueryCompletion)completion;

@end
