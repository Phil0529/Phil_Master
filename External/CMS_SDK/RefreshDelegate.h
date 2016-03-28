//
//  RefreshDelegate.h
//  EZTV
//
//  Created by Lee, Bo on 16/1/31.
//  Copyright © 2016年 Joygo. All rights reserved.
//

#ifndef RefreshDelegate_h
#define RefreshDelegate_h

@protocol RefreshDelegate <NSObject>

@required
- (void)managerDidFinishRefresh;

@end


#endif /* RefreshDelegate_h */
