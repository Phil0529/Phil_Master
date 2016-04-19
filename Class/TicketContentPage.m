//
//  TicketContentPage.m
//  Master
//
//  Created by Phil Xhc on 4/5/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "TicketContentPage.h"
#import "TicketNotUseCollViewCell.h"

@interface TicketContentPage()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
{
    TicketItem *_ticketItem;
}

@property (nonatomic, strong) UICollectionView *collView;

@end

@implementation TicketContentPage

- (instancetype)initWithFrame:(CGRect)frame item:(TicketItem *)item{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collView];
        _ticketItem = item;
    }
    return self;
}
- (void)refreshContentPage{
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10.f;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch ([[_ticketItem status] integerValue]) {
        case TicketStatus_NotUse:{
            TicketNotUseCollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TicketNotUseCollViewCellReuseIdentifier forIndexPath:indexPath];
            return cell;
        }
            break;
        case TicketStatus_Used:{
            TicketNotUseCollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TicketNotUseCollViewCellReuseIdentifier forIndexPath:indexPath];
            return cell;
        }
            break;
        case TicketStatus_Shared:{
            TicketNotUseCollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TicketNotUseCollViewCellReuseIdentifier forIndexPath:indexPath];
            return cell;
        }
            break;
        case TicketStatus_Expired:{
            TicketNotUseCollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TicketNotUseCollViewCellReuseIdentifier forIndexPath:indexPath];
            return cell;
        }
            break;
        default:{
            TicketNotUseCollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TicketNotUseCollViewCellReuseIdentifier forIndexPath:indexPath];
            return cell;
        }
            break;
    }
}

-(UICollectionView *)collView{
    if (!_collView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [flowLayout setMinimumInteritemSpacing:0.f];
        [flowLayout setMinimumLineSpacing:16.f];
        [flowLayout setItemSize:CGSizeMake(SCREEN_WIDTH - 20.f, 100.f)];
        [flowLayout setSectionInset:UIEdgeInsetsMake(16.f, 10.f,0.f, 10.f)];
        _collView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.f,0.f, SCREEN_WIDTH,Height(self)) collectionViewLayout:flowLayout];
        [_collView setBackgroundColor:BACKGROUND_COLOR];
        [_collView setDelegate:self];
        [_collView setDataSource:self];
        
        [_collView registerClass:[TicketNotUseCollViewCell class] forCellWithReuseIdentifier:TicketNotUseCollViewCellReuseIdentifier];
    }
    return _collView;
}

@end
