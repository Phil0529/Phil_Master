//
//  LaunchAdView.h
//  Created by http://github.com/iosdeveloper
//

#import <UIKit/UIKit.h>

extern NSString* const klaunchAdImage;

@interface LaunchAdView : UIImageView

- (id)initWithPresentDelay:(NSTimeInterval)seconds;

- (void)showOnWindow:(UIWindow *)window;

@end