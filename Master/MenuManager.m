//
//  MenuManager.m
//  Master
//
//  Created by Phil Xhc on 3/24/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "MenuManager.h"

@implementation MenuManager

+ (UIImage *)normalImage:(MenuItem *)item{
    switch (item.tabIcon) {
        case TabIconHome: {
            return [[UIImage imageNamed:@"tab_home"]
                         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
            break;
        case TabIconNews: {
            return [[UIImage imageNamed:@"tab_news"]
                         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
            break;
            
        case TabIconLotery: {
            return [[UIImage imageNamed:@"tab_caipiao"]
                         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
            break;
            
        case TabIconVideo: {
            return [[UIImage imageNamed:@"tab_video"]
                         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
            break;
        case TabIconService: {
            return [[UIImage imageNamed:@"tab_service"]
                         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
            break;
        case TabIconDiscovery: {
            return [[UIImage imageNamed:@"tab_finder"]
                         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        } break;
        case TabIconActivity: {
            return [[UIImage imageNamed:@"tab_activity"]
                         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        } break;
        case TabIconShake: {
            return [[UIImage imageNamed:@"tab_shake"]
                         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        } break;
        case TabIconMall: {
            return [[UIImage imageNamed:@"tab_mall"]
                         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        } break;
        case TabIconLive: {
            return [[UIImage imageNamed:@"tab_live"]
                         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        } break;
        case TabIconCloud: {
            return [[UIImage imageNamed:@"tab_cloud"]
                         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        } break;
        case TabIconCommon:
        default: {
            return [[UIImage imageNamed:@"tab_common"]
                         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        } break;
    }

}
+ (UIImage *)selectedImage:(MenuItem *)item{
    switch (item.tabIcon) {
        case TabIconHome: {
            return [[UIImage imageNamed:@"tab_home_pressed"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
            break;
        case TabIconNews: {
            return [[UIImage imageNamed:@"tab_news_pressed"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
            break;
            
        case TabIconLotery: {
            return [[UIImage imageNamed:@"tab_caipiao_pressed"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
            break;
            
        case TabIconVideo: {
            return [[UIImage imageNamed:@"tab_video_pressed"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
            break;
        case TabIconService: {
            return [[UIImage imageNamed:@"tab_service_pressed"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
            break;
        case TabIconDiscovery: {
            return [[UIImage imageNamed:@"tab_finder_pressed"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        } break;
        case TabIconActivity: {
            return [[UIImage imageNamed:@"tab_activity_pressed"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        } break;
        case TabIconShake: {
            return [[UIImage imageNamed:@"tab_shake_pressed"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        } break;
        case TabIconMall: {
            return [[UIImage imageNamed:@"tab_mall_pressed"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        } break;
        case TabIconLive: {
            return [[UIImage imageNamed:@"tab_live_pressed"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        } break;
        case TabIconCloud: {
            return [[UIImage imageNamed:@"tab_cloud_pressed"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        } break;
        case TabIconCommon:
        default: {
            return [[UIImage imageNamed:@"tab_common_pressed"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        } break;
    }
}

@end
