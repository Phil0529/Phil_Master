//
//  MyTicketViewController.m
//  Master
//
//  Created by Phil Xhc on 4/5/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "MyTicketViewController.h"
#import "HorizontalTitleMenu.h"
#import "PageScrollView.h"
#import "TicketNotUseCollViewCell.h"
#import "TicketContentPage.h"

@interface MyTicketViewController ()<HorizontalTitleMenuDataSource,HorizontalTitleMenuDelegate,PageScrollViewDelegate,PageScrollViewDataSource,ContentPageDelegate>

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) HorizontalTitleMenu *titleMenu;
@property (nonatomic, strong) PageScrollView *contentScrollView;
@property (nonatomic, strong) UICollectionView *collView;

@end

@implementation MyTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UNDERGROUND_COLOR];
    [self.navigationItem setTitle:@"我的影票"];
    [self showUI];
}

- (void)showUI{
    [self.view addSubview:self.titleMenu];
    [self.titleMenu refreshMenuView];
    [self.view addSubview:self.contentScrollView];
    [self.contentScrollView reloadPageScrollView];
}

- (NSInteger)numberOfItemsInHorizontalMenu:(HorizontalTitleMenu *)horizontalMenu{
    return self.titleArray.count;
}

- (NSString *)horizontalMenu:(HorizontalTitleMenu *)horizontalMenu titleForItemAtIndex:(NSInteger)index{
    return self.titleArray[index];
}

- (void)horizontalMenu:(HorizontalTitleMenu *)horizontalMenu didClickedAtIndex:(NSInteger)index{
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TicketNotUseCollViewCellReuseIdentifier forIndexPath:indexPath];
    return cell;
}

#pragma mark pageScrollView Delegate

- (void)pageScrollView:(PageScrollView *)pageScrollView scrollToPage:(NSInteger)page
{
    [self.titleMenu setButtonSelectedAtIndex:page];
}

#pragma mark pageScrollView DataSource

- (NSInteger)numberOfContentPagesInPageScrollView:(PageScrollView *)pageScrollView
{
    return self.titleArray.count;
}

- (UIView<ContentPageProtocol> *)pageScrollView:(PageScrollView *)pageScrollView contentPageIndex:(NSInteger)pageIndex{
    switch (pageIndex) {
        case 0:{
            TicketItem *item = [[TicketItem alloc] init];
            item.status = [NSNumber numberWithInt:0];
            TicketContentPage *contentPage = [[TicketContentPage alloc] initWithFrame:CGRectMake(0.f,MaxY(self.titleMenu), SCREEN_WIDTH, SCREEN_HEIGHT - 64.f - MaxY(self.titleMenu)) item:item];
            [contentPage setDelegate:self];
            return contentPage;
        }
            break;
        default:{
            TicketContentPage *contentPage = [[TicketContentPage alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*pageIndex,MaxY(self.titleMenu), SCREEN_WIDTH, SCREEN_HEIGHT - 64.f - MaxY(self.titleMenu))];
            [contentPage setDelegate:self];
            return contentPage;
        }
            break;
    }
}

#pragma ContentPageDelegate

- (void)needPushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)needPresentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion
{
    [self presentViewController:viewController animated:YES completion:nil];
}


- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"未使用",@"已使用",@"已分享",@"已过期"];
    }
    return _titleArray;
}

- (HorizontalTitleMenu *)titleMenu{
    if (!_titleMenu) {
        _titleMenu = [[HorizontalTitleMenu alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, 40.f)];
        [_titleMenu setDataSource:self];
        [_titleMenu setMenuDelegate:self];
    }
    return _titleMenu;
}

- (PageScrollView *)contentScrollView{
    if (!_contentScrollView) {
        _contentScrollView = [[PageScrollView alloc] initWithFrame:CGRectMake(0.f,0.f, SCREEN_WIDTH, SCREEN_HEIGHT - 64.f)];
        [_contentScrollView setDelegate:self];
        [_contentScrollView setDataSource:self];
    }
    return _contentScrollView;
}

@end
