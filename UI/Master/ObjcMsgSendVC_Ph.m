//
//  ObjcMsgSendVC_Ph.m
//  Master
//
//  Created by xhc on 10/20/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "ObjcMsgSendVC_Ph.h"
#import <stdio.h>
#import "EOCAutoDictionary.h"
#import "NSString+Develop.h"

@interface ObjcMsgSendVC_Ph ()

@end

@implementation ObjcMsgSendVC_Ph

- (void)viewDidLoad {
    [super viewDidLoad];
//    printHello();
//    EOCAutoDictionary *eocObject = [EOCAutoDictionary new];
//    eocObject.date = [NSDate date];
//    NSLog(@"%@",eocObject.date);
    
    NSString *testString = @"aA1bB";
    NSString *str1 = [testString lowercaseString];
    NSLog(@"------%@",str1);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(100.f, 100.f, 100.f, 100.f)];
    [btn setTitle:@"测试" forState:0];
    [btn setTitleColor:[UIColor redColor] forState:0];
    [[btn rac_signalForControlEvents:1<<6] subscribeNext:^(id x) {
//        NSString *test = @"23123";
    }];
    [self.view addSubview:btn];
    
}

void printHello(){
    printf("Hello Objectiv-C\n");
}

void printGoodBye(){
    printf("Good bye\n");
}

void doSomeThing(int type){
    void (*func)();
    if(type == 0){
        printHello();
    }else{
        printGoodBye();
    }
    func();
    return;
}



@end
