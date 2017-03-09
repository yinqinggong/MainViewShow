//
//  BelowCell.m
//  Zmodo
//
//  Created by Qinggong on 16/8/11.
//  Copyright © 2016年 Zmodo. All rights reserved.
//

#import "BelowCell.h"
#import "FeatureCell.h"
#import "Feature.h"
#import "Product.h"

static NSString *cellID = @"CellID";

@interface BelowCell ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) UICollectionView *collectionView;

@end

@implementation BelowCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = [UIColor clearColor];
        [collectionView registerClass:[FeatureCell class] forCellWithReuseIdentifier:cellID];
        self.collectionView = collectionView;
        [self.contentView addSubview:collectionView];
    }
    return self;
}

- (void)setProduct:(Product *)product
{
    _product = product;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.product.features.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.feature = self.product.features[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Feature *feature = self.product.features[indexPath.item];
    if ([self.delegate respondsToSelector:@selector(BelowCellSelected:)]) {
        [self.delegate BelowCellSelected:feature];
    }
}

#pragma mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (collectionView.frame.size.width - 3.0 * 3) * 0.5;
    CGFloat height = width * 232 / 311;
    return CGSizeMake(width, height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 3.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 3.0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(3.0, 3.0, 3.0, 3.0);
}
@end
