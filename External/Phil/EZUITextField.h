//
//  EZUITextField.h
//  EZTV
//
//  Created by Sunni on 15/6/15.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EZUITextField : UITextField

- (instancetype)initWithFrame:(CGRect)frame leftView:(UIView *)leftView;

- (void)setPlaceholder_b:(NSString *)placeholder;

@end
