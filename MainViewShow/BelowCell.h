//
//  BelowCell.h
//  Zmodo
//
//  Created by Qinggong on 16/8/11.
//  Copyright © 2016年 Zmodo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Feature, Product;

@protocol BelowCellDelegate <NSObject>

@optional
- (void)BelowCellSelected:(Feature *)feature;

@end
@interface BelowCell : UICollectionViewCell

@property (strong, nonatomic) Product *product;

@property (weak, nonatomic) id<BelowCellDelegate> delegate;

@end
