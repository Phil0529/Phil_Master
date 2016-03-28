//
//  MediaDetailManager.h
//  SWMOP
//
//  Created by Lee, Bo on 14-10-11.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MediaItem.h"

@interface MediaDetailManager : NSObject

+ (id) sharedInstance;

- (void)getMediaDetailWithColumnId:(NSInteger)columnId mediaId:(NSString*)mediaId provider:(NSString*)provider completion:(void (^)(MediaItem *detailItem ,NSError *error))completion;

@end
