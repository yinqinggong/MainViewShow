//
//  MainViewController.m
//  MainViewShow
//
//  Created by Qinggong on 2017/3/8.
//  Copyright © 2017年 Qinggong. All rights reserved.
//

#import "MainViewController.h"
#import "HCategoryCell.h"
#import "BelowCell.h"
#import "Product.h"
#import "Feature.h"

#define bgImageHeight ([UIScreen mainScreen].bounds.size.width * 9.0 / 16.0)

const CGFloat WelcomeHeight = 160.0;
const NSInteger HCollectionWidth = 100;

static NSString *cellH = @"CellH";
static NSString *cellBelowH = @"CellBH";

@interface MainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,BelowCellDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UIView *topView;
@property (weak, nonatomic) UIView *belowView;
@property (weak, nonatomic) UIImageView *iconView;
@property (weak, nonatomic) UICollectionView *collectionViewTopH;
@property (weak, nonatomic) UICollectionView *collectionViewBelowH;
@property (weak, nonatomic) UILabel *welcomeLabel;
@property (weak, nonatomic) UILabel *copyrightLabel;
@property (weak, nonatomic) UIImageView *arrowView;
@property (assign, nonatomic) NSInteger currentHIndex;

/**
 *  正在切换通道 需要从头开始
 */
@property (assign, nonatomic) BOOL isSwitching;

/**
 *  手动翻页
 */
@property (assign, nonatomic) BOOL isManualScrolling;

@property (strong, nonatomic) NSMutableArray *productList;

@property (strong, nonatomic) Product *currentProduct;

@end

@implementation MainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"MainViewShow";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, -64.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) + 64.0)];
    scrollView.backgroundColor = [UIColor colorWithRed:0xf5/255.0 green:0xf5/255.0 blue:0xf8/255.0 alpha:1.0];
    
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.tabBarController.tabBar.alpha = 0.0;
    
    [self setupTopViews];
    [self setupBelowViews];
    
    [self initList];
    
    [self mainViewAnimation];
}

- (void)mainViewAnimation
{
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options:0
                     animations:^{
                         
                         [self.navigationController setNavigationBarHidden:NO animated:NO];
                         self.tabBarController.tabBar.alpha = 1.0;
                         
                         self.topView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), bgImageHeight);
                         self.belowView.frame = CGRectMake(0.0, CGRectGetMaxY(self.topView.frame), CGRectGetWidth(self.view.frame), (CGRectGetHeight(self.view.frame) - bgImageHeight - 64.0));
                         self.iconView.frame = self.topView.bounds;
                         self.welcomeLabel.alpha = 0.0;
                         self.copyrightLabel.alpha = 0.0;
                         self.collectionViewBelowH.alpha = 1;
                         self.collectionViewBelowH.frame = self.belowView.bounds;
                         self.collectionViewTopH.frame = CGRectMake(0.0, CGRectGetHeight(self.topView.frame) - 44.0, CGRectGetWidth(self.topView.frame), 44.0);
                         self.collectionViewTopH.alpha = 1.0;
                         self.arrowView.frame = CGRectMake((HCollectionWidth - 26.0) * 0.5, CGRectGetHeight(self.topView.frame) - 19.0 + 0.5, 26.0, 19.0);
                         self.arrowView.alpha = 1.0;
                         self.scrollView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)initList
{
    self.productList = [NSMutableArray array];
    
    for (int i = 0; i < 9 ; ++i) {
        Product *product = [Product productWithId:[NSString stringWithFormat:@"%d", i]];
        [self.productList addObject:product];
    }
    
    self.currentProduct = self.productList[0];
}

- (void)setupTopViews
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - WelcomeHeight)];
    self.topView = topView;
    [self.scrollView addSubview:topView];
    
    //上边背景图
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:topView.bounds];
    iconView.userInteractionEnabled = YES;
    iconView.contentMode = UIViewContentModeScaleAspectFill;
    self.iconView = iconView;
    [topView addSubview:iconView];
    
    //分类横向滚动条
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    UICollectionView *collectionViewTopH = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, CGRectGetHeight(topView.frame) - 44.0, CGRectGetWidth(topView.frame), 44.0) collectionViewLayout:flowLayout];
    collectionViewTopH.tag = 0;
    collectionViewTopH.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, CGRectGetWidth(collectionViewTopH.frame) - HCollectionWidth);
    collectionViewTopH.dataSource = self;
    collectionViewTopH.delegate = self;
    collectionViewTopH.backgroundColor = [UIColor clearColor];
    collectionViewTopH.showsHorizontalScrollIndicator = NO;
    [collectionViewTopH registerClass:[HCategoryCell class] forCellWithReuseIdentifier:cellH];
    collectionViewTopH.alpha = 0.0;
    collectionViewTopH.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_collection_bg"]];
    [topView addSubview:collectionViewTopH];
    self.collectionViewTopH = collectionViewTopH;
    
    UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloud_time_line"]];
    [arrowView setFrame:CGRectMake((HCollectionWidth - 26.0) * 0.5, CGRectGetHeight(topView.frame) - 19.0 + 0.5, 26.0, 19.0)];
    arrowView.contentMode = UIViewContentModeTop;
    arrowView.transform = CGAffineTransformMakeRotation(M_PI);
    arrowView.alpha = 0.0;
    [topView addSubview:arrowView];
    self.arrowView = arrowView;
}

- (void)setupBelowViews
{
    //下部功能列表
    UIView *belowView = [[UIView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(self.topView.frame), CGRectGetWidth(self.view.frame), WelcomeHeight)];
    self.belowView = belowView;
    [self.scrollView addSubview:belowView];
    
    //Welcome back
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:belowView.bounds];
    welcomeLabel.text = NSLocalizedString(@"Welcome back", @"Welcome back");
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    welcomeLabel.font = [UIFont systemFontOfSize:24.0];
    welcomeLabel.alpha = 1.0;
    [belowView addSubview:welcomeLabel];
    self.welcomeLabel = welcomeLabel;
    
    //Copyrights
    UILabel *copyrightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, CGRectGetHeight(belowView.frame) - 15.0 - 20.0-30, CGRectGetWidth(belowView.frame)-80, 50.0)];
    CGPoint cen = copyrightLabel.center;
    cen.x= belowView.center.x;
    copyrightLabel.center= cen;
    copyrightLabel.text = @"Copy Right:XXX_XXX.COM";
    copyrightLabel.textAlignment = NSTextAlignmentCenter;
    copyrightLabel.font = [UIFont systemFontOfSize:10.0];
    copyrightLabel.numberOfLines=0;
    copyrightLabel.alpha = 1.0;
    [belowView addSubview:copyrightLabel];
    self.copyrightLabel = copyrightLabel;
    
    //下方横向滚动条
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    UICollectionView *collectionViewBelowH = [[UICollectionView alloc] initWithFrame:belowView.bounds collectionViewLayout:flowLayout];
    collectionViewBelowH.tag = 1;
    collectionViewBelowH.dataSource = self;
    collectionViewBelowH.delegate = self;
    collectionViewBelowH.backgroundColor = [UIColor colorWithRed:0xf5/255.0 green:0xf5/255.0 blue:0xf8/255.0 alpha:1.0];
    collectionViewBelowH.showsHorizontalScrollIndicator = NO;
    collectionViewBelowH.pagingEnabled = YES;
    [collectionViewBelowH registerClass:[BelowCell class] forCellWithReuseIdentifier:cellBelowH];
    collectionViewBelowH.alpha = 0.0;
    [belowView addSubview:collectionViewBelowH];
    self.collectionViewBelowH = collectionViewBelowH;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView.tag == 1) {
        return self.productList.count;
    }
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag == 0) {
        return self.productList.count;
    }
    
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 0) {
        HCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellH forIndexPath:indexPath];
        Product *product = self.productList[indexPath.item];
        cell.name = product.name;
        return cell;
    }
    
    BelowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellBelowH forIndexPath:indexPath];
    cell.delegate = self;
    Product *product = self.productList[indexPath.section];
    cell.product = product;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 0) {
        self.currentHIndex = indexPath.item;
        [UIView animateWithDuration:0.2
                         animations:^{
                             collectionView.contentOffset = CGPointMake(indexPath.item * HCollectionWidth, 0.0);
                         }];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 1) {
        
        NSIndexPath *visiablePath = [[collectionView indexPathsForVisibleItems] firstObject];
        
        if (self.isSwitching) {
            //在切换类别时都滑到起始位置 防止崩溃
            if ([self.collectionViewBelowH numberOfItemsInSection:0] > 0) {
                [self.collectionViewBelowH scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
                
                if (self.productList.count > 0) {
                    self.currentProduct = self.productList[0];
                }
            }
            if ([self.collectionViewTopH numberOfItemsInSection:0] > 0) {
                [self.collectionViewTopH scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
            }
            
            self.isSwitching = NO;
        }else{
            if (self.isManualScrolling == YES) {
                
                if ([self.collectionViewTopH numberOfItemsInSection:0] > visiablePath.section) {
                    
                    [self.collectionViewTopH scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:visiablePath.section inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
                }
            }
            
            if (self.productList.count > visiablePath.section)
            {
                self.currentProduct = self.productList[visiablePath.section];
            }
        }
    }
}

#pragma mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 0) {
        return CGSizeMake(HCollectionWidth, CGRectGetHeight(collectionView.frame));
    }
    return collectionView.frame.size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.tag == 0) {
        
        CGPoint contentOffset = scrollView.contentOffset;
        [UIView animateWithDuration:0.2
                         animations:^{
                             scrollView.contentOffset = CGPointMake(((int)(contentOffset.x + HCollectionWidth * 0.5) / HCollectionWidth) * HCollectionWidth, 0.0);
                         } completion:^(BOOL finished) {
                             self.currentHIndex = scrollView.contentOffset.x / HCollectionWidth;
                         }];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 0) {
        
        CGPoint contentOffset = scrollView.contentOffset;
        [UIView animateWithDuration:0.2
                         animations:^{
                             scrollView.contentOffset = CGPointMake(((int)(contentOffset.x + HCollectionWidth * 0.5) / HCollectionWidth) * HCollectionWidth, 0.0);
                         } completion:^(BOOL finished) {
                             self.currentHIndex = scrollView.contentOffset.x / HCollectionWidth;
                         }];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView.tag == 0) {
        self.isManualScrolling = NO;
    }else if (scrollView.tag == 1) {
        self.isManualScrolling = YES;
    }
}

- (void)setCurrentHIndex:(NSInteger)currentHIndex
{
    _currentHIndex = currentHIndex;
    
    //防止滑太猛导致的崩溃
    NSInteger itemCount = self.productList.count;
    if (_currentHIndex < 0 || _currentHIndex >= itemCount) {
        return;
    }
    [self.collectionViewBelowH scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:currentHIndex] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

#pragma mark - BelowCellDelegate
- (void)BelowCellSelected:(Feature *)feature
{
    NSString *msg;
    switch (feature.type) {
        case FeatureTypeLive:
            msg = [NSString stringWithFormat:@"You selected Beer!"];
            break;
        case FeatureTypeAlert:
            msg = [NSString stringWithFormat:@"You selected Cooker!"];
            break;
        case FeatureTypeRing:
            msg = [NSString stringWithFormat:@"You selected Camera!"];
            break;
        case FeatureTypeDoor:
            msg = [NSString stringWithFormat:@"You selected Books!"];
            break;
        case FeatureTypeTemperature:
            msg = [NSString stringWithFormat:@"You selected Knife!"];
            break;
        case FeatureTypeHumidity:
            msg = [NSString stringWithFormat:@"You selected Package!"];
            break;
        case FeatureTypeRepeater:
            msg = [NSString stringWithFormat:@"You selected Mouse!"];
            break;
        case FeatureTypeSoundAndLightAlarm:
            msg = [NSString stringWithFormat:@"You selected Flowers!"];
            break;
        case FeatureTypeBuzzer:
            msg = [NSString stringWithFormat:@"You selected Pad!"];
            break;
        case FeatureTypeLight:
            msg = [NSString stringWithFormat:@"You selected Light!"];
            break;
        case FeatureTypeBluetooth:
            msg = [NSString stringWithFormat:@"You selected Red Book!"];
            break;
        case FeatureTypeRoomSetting:
            msg = [NSString stringWithFormat:@"You selected Phone!"];
            break;
        case FeatureTypeShop:
            msg = [NSString stringWithFormat:@"You selected Shop!"];
            break;
        case FeatureTypeCloud:
            msg = [NSString stringWithFormat:@"You selected Headset!"];
            break;
        case FeatureTypeShare:
            msg = [NSString stringWithFormat:@"You selected Coat!"];
            break;
        case FeatureTypeDeviceSetting:
            msg = [NSString stringWithFormat:@"You selected Settings!"];
            break;
        default:
            break;
        }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

- (void)setCurrentProduct:(Product *)currentProduct
{
    _currentProduct = currentProduct;
    self.iconView.image = [UIImage imageNamed:currentProduct.productId];
}

@end
