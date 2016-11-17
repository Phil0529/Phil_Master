

//
//  TestVC_Ph.m
//  Master
//
//  Created by xhc on 11/2/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "TestVC_Ph.h"

extern NSString *const Test_Address;

@interface TestVC_Ph ()

@end

@implementation TestVC_Ph

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *baseURL = [NSURL URLWithString:@"https://api.service.com/v1"];
    NSURL *relativeURL = [NSURL URLWithString:@"/files/search" relativeToURL:baseURL];
//    But then [relativeURL absoluteString] will return https://api.service.com/files/search.
    
//    So I tried a few examples:
    
    NSURL *baseURL1 = [NSURL URLWithString:@"https://api.service.com/v1/"];
    NSURL *baseURL2 = [NSURL URLWithString:@"https://api.service.com/v1"];
    NSURL *baseURL3 = [NSURL URLWithString:@"/v1" relativeToURL:[NSURL URLWithString:@"https://api.service.com"]];
    
    NSURL *relativeURL1 = [NSURL URLWithString:@"/files/search" relativeToURL:baseURL1];
    NSURL *relativeURL2 = [NSURL URLWithString:@"/files/search" relativeToURL:baseURL2];
    NSURL *relativeURL3 = [NSURL URLWithString:@"/files/search" relativeToURL:baseURL3];
    NSURL *relativeURL4 = [NSURL URLWithString:@"files/search" relativeToURL:baseURL1];
    NSURL *relativeURL5 = [NSURL URLWithString:@"files/search" relativeToURL:baseURL2];
    NSURL *relativeURL6 = [NSURL URLWithString:@"files/search" relativeToURL:baseURL3];
    
    NSLog(@"0: %@",Test_Address);
    NSLog(@"1: %@", [relativeURL1 absoluteString]);
    NSLog(@"2: %@", [relativeURL2 absoluteString]);
    NSLog(@"3: %@", [relativeURL3 absoluteString]);
    NSLog(@"4: %@", [relativeURL4 absoluteString]);
    NSLog(@"5: %@", [relativeURL5 absoluteString]);
    NSLog(@"6: %@", [relativeURL6 absoluteString]);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
