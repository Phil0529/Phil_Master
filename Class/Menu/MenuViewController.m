//
//  EZMenuViewCtrler.m
//  EZTV
//
//  Created by Lee, Bo on 15/4/15.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//
#import "MenuViewController.h"
#import "AppConfig.h"
#import "TabBarViewController.h"
#import "ContentViewController.h"
#import "LocationViewController.h"
#import "PayViewController.h"



@interface MenuViewController ()
{
    UIScrollView *_btnMapView;
    
    NSArray *_menuDataArray;
    int loadTime;
}

@property (nonatomic, strong) UIView *btnBg;
@property (nonatomic, strong) UIView *navigationBar;

@end

@implementation MenuViewController


+ (UIViewController *)paneViewControllerForMenuItem:(MenuItem *)menuItem
{
    UIViewController *paneViewController;
    if (!menuItem) {
        return paneViewController;
    }
    switch (menuItem.menutype) {
        case MenuTypeSimpleNews:{
            paneViewController = [[ContentViewController alloc] initWithStyle:ColumnContent];
            [(ContentViewController *)paneViewController setColumnItem:menuItem];
        }
            break;
        case MenuTypeLocation:{
            LocationViewController *vc = [[LocationViewController alloc] init];
            return vc;
        }
            break;
        case MenuTypePay:{
            PayViewController *vc = [[PayViewController alloc] init];
            [vc setTitle:menuItem.name];
            return vc;
        }
            break;
        default:
        {
            paneViewController = [[ContentViewController alloc] initWithStyle:ColumnContent];
            [(ContentViewController *)paneViewController setColumnItem:menuItem];
        }
            break;
    }
    return paneViewController;
}

@synthesize drawer = _drawer;


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (UIView *)navigationBar
{
    if (!_navigationBar) {
        _navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, 64.f)];
        [_navigationBar setBackgroundColor:[AppConfig sharedConfig].appColor];
        [_navigationBar.layer setShadowOffset:CGSizeMake(0.f, .3f)];
        [_navigationBar.layer setShadowOpacity:.3f];
    }
    return _navigationBar;
}

- (UIView *)btnBg
{
    if (!_btnBg) {
        _btnBg = [[UIView alloc] init];
        [_btnBg setBackgroundColor:COLORFORRGB(0xe5e3e4)];
        [_btnMapView addSubview:_btnBg];
    }
    return _btnBg;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:COLORFORRGB(0xfdfcfc)];
        [self.view addSubview:self.navigationBar];
        UIButton *btnSearch = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 20.f, NAVBTN_WIDTH + 20.f, NAVBTN_HEIGHT)];
        [btnSearch setImage:[UIImage imageNamed:@"nav_search_m"] forState:UIControlStateNormal];
        [btnSearch addTarget:self action:@selector(clickOnSearch:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationBar addSubview:btnSearch];
        
        _btnMapView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 64.f, SCREEN_WIDTH, SCREEN_HEIGHT - 64.f)];
        [_btnMapView setShowsHorizontalScrollIndicator:NO];
        [_btnMapView setShowsVerticalScrollIndicator:NO];
        [_btnMapView setBackgroundColor:COLORFORRGB(0xfdfcfc)];
        [self.view addSubview:_btnMapView];
        [self getMenuColumns];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appConfigChanged) name:kNotificationAppDidTraveled object:nil];
}

- (void)tapOnNavigationBar:(UIGestureRecognizer *)gesture
{
    if ([self.drawer.centerViewController isKindOfClass:[UITabBarController class]])
    {
        [(UITabBarController *)self.drawer.centerViewController setSelectedIndex:0];
    }
    [self.drawer close];
}

- (void)getMenuColumns
{
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getMenuColumns) object:nil];
}

#pragma mark LoadErrorViewDelegate

- (void)needPageReload
{
}

- (void)appConfigChanged
{
    
}

- (void)reloadMenuDataArray
{
    [self getMenuColumns];
}

- (void)layoutMenuButtons
{
    if ([_menuDataArray count] == 0) {
        return;
    }
    //    [_btnMapView.mj_header endRefreshing];
    [_btnMapView.subviews enumerateObjectsUsingBlock:^(UIView* view, NSUInteger idx, BOOL *stop)
     {
         if (view.tag == 1000) {
             [view removeFromSuperview];
         }
     }];
    
    CGFloat leftButtonWidth = (SCREEN_WIDTH - MenuFloatWidth)/2 - .5f;
    CGFloat rightButtonWidth = SCREEN_WIDTH - leftButtonWidth;
    CGFloat buttonHeight = 60.f;
    
    int rowCount = 0;
    int i = 0;
    MenuItem *prevs;
    MenuItem *current = [_menuDataArray firstObject];
    MenuItem *next;
    
    for (; i < [_menuDataArray count]; i++) {
        if (i+1 < [_menuDataArray count]) {
            next = [_menuDataArray objectAtIndex:i+1];
        } else {
            next = nil;
        }
        if (current.position != PositionCenter) {
            if (!prevs || prevs.position != PositionLeft) {
                current.position = PositionLeft;
                if (!next || next.position == PositionCenter) {
                    current.position = PositionCenter;
                }
            } else {
                current.position = PositionRigth;
            }
        }
        
        BOOL needWrap = NO;
        //        btnMode mode = MODE_LARGE;
        CGRect frame = CGRectZero;
        //        switch (current.position) {
        //            case PositionLeft:
        ////                mode = MODE_LEFT;
        //                frame = CGRectMake(0.f, rowCount * buttonHeight, leftButtonWidth, buttonHeight - .5f);
        //                break;
        //            case PositionRigth:
        //                mode = MODE_RIGHT;
        //                frame = CGRectMake(leftButtonWidth + .5f, rowCount * buttonHeight, rightButtonWidth, buttonHeight - .5f);
        //                needWrap = YES;
        //                break;
        //            case PositionCenter:
        //                frame = CGRectMake(0.f, rowCount * buttonHeight, SCREEN_WIDTH, buttonHeight - .5f);
        //                needWrap = YES;
        //                break;
        //        }
        //        EZMenuButton *button = [[EZMenuButton alloc] initWithFrame:frame Title:current.name Image:current.icon Mode:mode];
        //        button.menuItem = current;
        //        button.tag = 1000;
        //        [button addTarget:self action:@selector(tapOnMenuButton:) forControlEvents:UIControlEventTouchUpInside];
        //        [_btnMapView addSubview:button];
        //        if (needWrap) {
        //            rowCount++;
        //        }
        //        prevs = current;
        //        current = next;
    }
    
    CGFloat contentHeight = rowCount * buttonHeight;
    
    if (CGRectGetHeight(_btnMapView.frame) - contentHeight > 0) {
        UIView *cover = [[UIView alloc] initWithFrame:CGRectMake(0.f, rowCount * buttonHeight, SCREEN_WIDTH, CGRectGetHeight(_btnMapView.frame) - contentHeight)];
        cover.tag = 1000;
        [cover setBackgroundColor:COLORFORRGB(0xfdfcfc)];
        [_btnMapView addSubview:cover];
        
        contentHeight = CGRectGetHeight(_btnMapView.frame);
    }
    [self.btnBg setFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, contentHeight)];
    [_btnMapView setContentSize:CGSizeMake(SCREEN_WIDTH, contentHeight)];
    [_btnMapView sendSubviewToBack:self.btnBg];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
}

- (void)tapOnMenuButton:(UIButton *)button
{
}

- (void)transitionToViewController:(MenuItem *)menuItem animated:(BOOL)animated
{
    UIViewController *paneViewController = [[self class] paneViewControllerForMenuItem:menuItem];
    
    if (paneViewController) {
    }
}

- (void)clickOnSearch:(id)sender
{
}

- (BOOL)isItem:(MenuItem *)menu sameWithItemTwo:(MenuItem *)menuTwo
{
    if (menuTwo && menu.menutype == menuTwo.menutype && menu.cid == menuTwo.cid) {
        return YES;
    } else {
        return NO;
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - delegate ICSDrawerControllerPresenting

/**
 Tells the child controller that the drawer controller is about to open.
 
 @param drawerController The drawer object that is about to open.
 */
- (void)drawerControllerWillOpen:(ICSDrawerController *)drawerController
{
    [self.view setUserInteractionEnabled:NO];
}
/**
 Tells the child controller that the drawer controller has completed the opening phase and is now open.
 
 @param drawerController The drawer object that is now open.
 */
- (void)drawerControllerDidOpen:(ICSDrawerController *)drawerController
{
    [self.view setUserInteractionEnabled:YES];
}
/**
 Tells the child controller that the drawer controller is about to close.
 
 @param drawerController The drawer object that is about to close.
 */
- (void)drawerControllerWillClose:(ICSDrawerController *)drawerController
{
    [self.view setUserInteractionEnabled:NO];
}
/**
 Tells the child controller that the drawer controller has completed the closing phase and is now closed.
 
 @param drawerController The drawer object that is now closed.
 */
- (void)drawerControllerDidClose:(ICSDrawerController *)drawerController
{
    [self.view setUserInteractionEnabled:YES];
}

@end
