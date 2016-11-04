//

//  FMDBView_Ph.m
//  Master
//
//  Created by xhc on 11/1/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "FMDBView_Ph.h"

@interface FMDBView_Ph()

@end

@implementation FMDBView_Ph

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.firBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.firBtn setFrame:CGRectMake(20.f, 20.f, 100.f, 30.f)];
        self.firBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            self.firBtnClick();
            return [RACSignal empty];
        }];
        [self.firBtn setBackgroundColor:[UIColor greenColor]];
        [self addSubview:self.firBtn];
    }
    return self;
}

@end
