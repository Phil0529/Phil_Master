//
//  MessageView.h
//  EZTV
//
//  Created by Sunniwell on 11/11/15.
//  Copyright © 2015 Joygo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageView : UIView

@property (nonatomic,strong)UIButton *cancelBtn;

- (instancetype)initWithFrame:(CGRect )frame title:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle withTime:(int)autoHideTime;
- (void)show;
@end
