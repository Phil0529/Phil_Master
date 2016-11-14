//
//  FDTbVC_Ph.m
//  Master
//
//  Created by xhc on 11/8/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "FDTbVC_Ph.h"
#import "FDTbCell_Ph.h"
#import "FDFeedEntity.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface FDTbVC_Ph ()

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) NSArray *sectionArray;

@end

@implementation FDTbVC_Ph

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.fd_debugLogEnabled = YES;
    
    [self.tableView registerClass:[FDTbCell_Ph class] forCellReuseIdentifier:FDTbCell_Ph_ReuseIdentifier];
    self.dataArray = @[].mutableCopy;
    [self buildTestDataThen:^{
        [self.dataArray addObject:self.sectionArray.mutableCopy];
        [self.tableView reloadData];
    }];
}

- (void)buildTestDataThen:(void (^)(void))then {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *feedDicts = rootDict[@"feed"];
        NSMutableArray *entities = @[].mutableCopy;
        [feedDicts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [entities addObject:[[FDFeedEntity alloc] initWithDictionary:obj]];
        }];
        self.sectionArray = entities;
        dispatch_async(dispatch_get_main_queue(), ^{
            !then ?: then();
        });
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FDTbCell_Ph *cell = [tableView dequeueReusableCellWithIdentifier:FDTbCell_Ph_ReuseIdentifier forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(FDTbCell_Ph *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = YES;
    [cell refreshViewWith:self.dataArray[indexPath.section][indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:FDTbCell_Ph_ReuseIdentifier cacheByIndexPath:indexPath configuration:^(FDTbCell_Ph *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
}

@end
