

//
//  ContentViewController.m
//  Master
//
//  Created by Phil Xhc on 3/22/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "ContentViewController.h"
#import "HorizontalMenu.h"
#import "PageScrollView.h"
#import "ContentPageProtocol.h"
#import "ContentPage.h"
#import "ConfigManger.h"
#import "EZColumnManager.h"

@interface ContentViewController ()<ContentPageDelegate,HorizontalMenuDelegate,HorizontalMenuDataSource,PageScrollViewDataSource,PageScrollViewDelegate>
{
    ContentStyle _style;
    CGSize _contentSize;
}

//Navigation

@property (nonatomic, copy) NSArray *leftNavButtons;
@property (nonatomic, copy) NSArray *rightNavButtons;
@property (nonatomic, strong) NSMutableArray *rightBarsArray;
@property (nonatomic, strong) NSMutableArray *leftBarsArray;
@property (nonatomic, retain) NSArray *columnList;
@property (nonatomic, assign) NSUInteger selectedIndex;

@property (nonatomic, strong) HorizontalMenu *menuView;
@property (nonatomic, strong) PageScrollView *pageView;
@property (nonatomic, retain) UIView<ContentPageProtocol> *currentPage;
//upload
@property (nonatomic, strong) UIBarButtonItem *navMyUpload;
@property (nonatomic, strong) UIButton *btnUpload;

//web
@property (nonatomic, strong) UIBarButtonItem *navWebBack;
@property (nonatomic, strong) UIBarButtonItem *navBack;
@property (nonatomic, strong) UIBarButtonItem *navWebClose;
@property (nonatomic, assign) BOOL canGoBack;

//live
@property (nonatomic, strong) UIBarButtonItem *navMenu;
//@property (nonatomic, strong) LiveListMenu *listMenu;

@end

@implementation ContentViewController

- (instancetype)initWithStyle:(ContentStyle)style
{
    if (self = [super init]) {
        _style = style;
    }
    return self;
}

- (void)setColumnItem:(EZColumnItem *)columnItem
{
    _columnItem = columnItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self.view setBackgroundColor:[UIColor clearColor]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (SYSTEM_VERSION_LESS_THAN(@"8.0")) {
        [self.navigationController.navigationBar setTranslucent:NO];
    }
    [self.view setBackgroundColor:BACKGROUND_COLOR];
    
    if (!ISEMPTYSTR(_columnItem.name)) {
        [self.navigationItem setTitle:_columnItem.name];
    }
    if ([self.navigationItem.leftBarButtonItems count] > 0) {
        //save the orignal icons
        _leftNavButtons = self.navigationItem.leftBarButtonItems;
    }
    if ([self.navigationItem.rightBarButtonItems count] > 0) {
        //save the orignal icons
        _rightNavButtons = self.navigationItem.rightBarButtonItems;
    }
    
    [self layoutViewContent];
    if (_style == ColumnContent) {
    }
}

- (void)layoutViewContent
{
    CGFloat bottomHeight = 0.f;
    if (self.tabBarController && !self.hidesBottomBarWhenPushed) {
        bottomHeight = CGRectGetHeight(self.tabBarController.tabBar.frame);
    }
    
    switch (_style) {
        case ColumnContent:
        {
            _currentPage = [ContentPage contentPageWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, SCREEN_HEIGHT - 64.f - bottomHeight) columnItem:_columnItem delegate:self];
            _contentSize = _currentPage.frame.size;
            [self.view addSubview:_currentPage];
        }
            break;
        case MultiColumnContent:
        {
            self.menuView = [[HorizontalMenu alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, 40.f)];
            [self.menuView setMenuDelegate:self];
            [self.menuView setDataSource:self];
            [self.view addSubview:self.menuView];
            
            self.pageView = [[PageScrollView alloc] initWithFrame:CGRectMake(0.f, CGRectGetMaxY(_menuView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - 64.f - bottomHeight - CGRectGetHeight(_menuView.frame))];
            [self.pageView setDelegate:self];
            [self.pageView setDataSource:self];
            [self.view addSubview:self.pageView];
            _contentSize = self.pageView.frame.size;
            [self loadNewsColumnList];
        }
            break;
        default:
            break;
    }
}

- (NSInteger)numberOfItemsInHorizontalMenu:(HorizontalMenu *)horizontalMenu
{
    return [_columnList count];
}

- (NSString *)horizontalMenu:(HorizontalMenu *)horizontalMenu titleForItemAtIndex:(NSInteger)index
{
    if (ISINDEXINRANGE(index, _columnList)) {
        EZColumnItem *item = [_columnList objectAtIndex:index];
        return item.name;
    }
    return @"";
}

- (void)horizontalMenu:(HorizontalMenu *)horizontalMenu didClickedAtIndex:(NSInteger)index
{
    [self.pageView scrollViewToPage:index];
    [self changeSelectedIndex:index];
}

- (void)changeSelectedIndex:(NSInteger)index
{
    _selectedIndex = index;
    _currentPage = [_pageView contentPageIndex:index];
    _columnItem = [_columnList objectAtIndex:index];
    [self setSelectedColumn:_columnItem];
}

#pragma pagescrollview delegate

- (NSInteger)numberOfContentPagesInPageScrollView:(PageScrollView *)pageScrollView
{
    return [_columnList count];
}

- (UIView<ContentPageProtocol> *)pageScrollView:(PageScrollView *)pageScrollView contentPageIndex:(NSInteger)pageIndex
{
    EZColumnItem *item = [_columnList objectAtIndex:pageIndex];
    UIView<ContentPageProtocol> *contentPage =
    [ContentPage contentPageWithFrame:CGRectMake(SCREEN_WIDTH * pageIndex, 0.f, CGRectGetWidth(_pageView.frame), CGRectGetHeight(_pageView.frame))
                           columnItem:item
                             delegate:self];
    return contentPage;
}

- (void)pageScrollView:(PageScrollView *)pageScrollView scrollToPage:(NSInteger)page
{
    [self.menuView setButtonSelectedAtIndex:page];
    [self changeSelectedIndex:page];
}

- (void)setSelectedColumn:(EZColumnItem *)column
{
    ButtonSet newSet = ButtonNone;
    if (column.listtype == ListTypeHtml) {
        //网页
        if ([self.navigationController.viewControllers count] > 1) {
            newSet = newSet | ButtonBack | ButtonWebClose;
        } else {
            newSet = newSet | ButtonWebBack;
        }
    }
    if (![ConfigManger sharedManager].isShield) {
        if (column.upstatus == 1) {
            //上传
            newSet = newSet | ButtonUpload | ButtonMyUpload;
        }
        
        if (column.listtype == ListTypeLive) {
            //微直播
            newSet = newSet | ButtonLiveMenu;
        }
        if (column.listtype == ListTypeMLive) {
            //荔枝新闻
            newSet = newSet | ButtonLiveMenu;
        }
    }
    
    if (newSet != _buttonSet) {
        _buttonSet = newSet;
        [self layoutViewButtons];
    }
    
    if (_buttonSet & ButtonMyUpload) {
        if ([self.btnUpload superview]) {
            [self.btnUpload removeFromSuperview];
        }
        if (_currentPage) {
            [_currentPage addSubview:self.btnUpload];
        }
    }
    
    if (column.listtype == ListTypeHtml) {
        if ([_currentPage respondsToSelector:@selector(canGoBack)]) {
            BOOL canGoBack = [_currentPage performSelector:@selector(canGoBack)];
            [self pageGoBackChanged:canGoBack];
        }
    }
}

- (void)layoutViewButtons
{
    [self.leftBarsArray removeAllObjects];
    if ([_currentPage respondsToSelector:@selector(canGoBack)]) {
        BOOL canGoBack = [_currentPage performSelector:@selector(canGoBack)];
        if (canGoBack) {
            if (_buttonSet & ButtonWebBack) {
                [self.leftBarsArray addObjectsFromArray:_leftNavButtons];
                [self.leftBarsArray addObject:self.navWebBack];
            }
            
            if (_buttonSet & ButtonWebClose) {
                [self.leftBarsArray addObject:self.navBack];
                [self.leftBarsArray addObject:self.navWebClose];
            }
        }
    }
    
    if ([self.leftBarsArray count] > 0) {
        [self.navigationItem setLeftBarButtonItems:self.leftBarsArray animated:YES];
    } else {
        [self.navigationItem setLeftBarButtonItems:self.leftNavButtons animated:YES];
    }
    
    [self.rightBarsArray removeAllObjects];
    //    if (_buttonSet & ButtonLiveMenu) {
    //        [self.rightBarsArray addObject:self.navMenu];
    //        [self.listMenu setColumnItem:_columnItem];
    //        if (![self.listMenu superview]) {
    //            [self.view addSubview:self.listMenu];
    //        }
    //    }
    //    else {
    //        [self.rightBarsArray addObjectsFromArray:_rightNavButtons];
    //    }
    
    if (_buttonSet & ButtonMyUpload) {
        [self.rightBarsArray addObject:self.navMyUpload];
    }
    
    if (self.rightBarsArray.count > 0) {
        [self.navigationItem setRightBarButtonItems:self.rightBarsArray animated:YES];
    } else {
        [self.navigationItem setRightBarButtonItems:_rightNavButtons animated:YES];
    }
}



- (void)loadNewsColumnList
{
    __weak __typeof(self) weakSelf = self;
    [[EZColumnManager sharedManager] getColumnArrayByPid:_columnItem.cid completion:^(NSArray *result) {
        if (weakSelf) {
            [weakSelf refreshPageWithresult:result];
        }
    }];
}

- (void)refreshPageWithresult:(NSArray *)result
{
    _columnList = result;
    if ([_columnList count] > 0) {
        [self.menuView refreshMenuView];
        [self.pageView reloadPageScrollView];
        [self horizontalMenu:self.menuView didClickedAtIndex:0];
    } else {
        //        [self.loadErrorView setDisplayStatus:YES];
    }
}


@end
