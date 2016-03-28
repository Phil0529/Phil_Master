//
//  ContentPage.m
//  EZTV
//
//  Created by Lee, Bo on 15/10/19.
//  Copyright © 2015年 Joygo. All rights reserved.
//

#import "ContentPage.h"
#import "ConfigManger.h"
#import "TableContentPage.h"

@implementation ContentPage

+ (UIView<ContentPageProtocol> *)contentPageWithFrame:(CGRect)frame columnItem:(EZColumnItem *)item delegate:(id<ContentPageDelegate>)delegate
{
    TableContentPage *contentPage = [[TableContentPage alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, SCREEN_HEIGHT-64.f) columnItem:item];
    [contentPage setDelegate:delegate];
    return contentPage;
}

@end
