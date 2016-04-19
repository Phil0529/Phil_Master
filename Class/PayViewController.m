//
//  PayViewController.m
//  Master
//
//  Created by Phil Xhc on 3/28/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "PayViewController.h"
#import "WaitPayViewController.h"
#import "MyTicketViewController.h"

@interface PayViewController ()

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(20.f,SCREEN_HEIGHT - 200.f, SCREEN_WIDTH-40.f, 40.f)];
    [btn setTitle:@"去支付" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(payClick) forControlEvents:1<<6];
    [self.view addSubview:btn];

//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setFrame:CGRectMake(20.f,SCREEN_HEIGHT - 200.f, SCREEN_WIDTH-40.f, 40.f)];
//    [btn setTitle:@"影票" forState:UIControlStateNormal];
//    [btn setBackgroundColor:[UIColor redColor]];
//    [btn addTarget:self action:@selector(ticketClick) forControlEvents:1<<6];
//    [self.view addSubview:btn];
}

- (void)payClick{
    WaitPayViewController *vc = [[WaitPayViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)ticketClick{
    MyTicketViewController *vc = [[MyTicketViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIImage *)circleImageName:(UIImage *)img borderWith:(double)border colorWith:(UIColor *)color
{
    //    UIImage *img=[UIImage imageNamed:path];
    UIGraphicsBeginImageContext(img.size );
    
    CGContextRef ctr=UIGraphicsGetCurrentContext();
    
    double radius=img.size.height>img.size.width?(img.size.width/2):(img.size.height/2);
    
    radius/=2;
    
    
    double centerx=img.size.width/2;
    double centery=img.size.height/2;
    
    
    [color set];
    //   CGContextSetLineWidth(ctr, border);
    CGContextAddArc(ctr, centerx, centery, radius+border, 0, M_PI_2*4, YES);
    CGContextFillPath(ctr);
    
    CGContextAddArc(ctr, centerx, centery, radius, 0, M_PI_2*4, YES);
    
    CGContextClip(ctr);
    
    //    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    
    UIImage *newImg=UIGraphicsGetImageFromCurrentImageContext();
    
    
    UIGraphicsEndImageContext();
    return newImg;
    
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
