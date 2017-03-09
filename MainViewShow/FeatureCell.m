//
//  FeatureCell.m
//  MainInterface
//
//  Created by Qinggong on 16/8/10.
//  Copyright © 2016年 zmodo. All rights reserved.
//

#import "FeatureCell.h"
#import "Feature.h"
#import "Product.h"

@interface FeatureCell ()

@property (weak, nonatomic) UILabel *centerLabel;
@property (weak, nonatomic) UIImageView *iconView;
@property (weak, nonatomic) UILabel *detailLabel;
@property (weak, nonatomic) UILabel *nameLabel;

@end

@implementation FeatureCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.contentView.layer.cornerRadius = 1.0;
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.borderColor = [UIColor colorWithRed:0xdd/255.0 green:0xdd/255.0 blue:0xdd/255.0 alpha:1.0].CGColor;
        self.contentView.layer.borderWidth = 1.0/[UIScreen mainScreen].scale;
        
        //中间行
        UILabel *centerLabel = [[UILabel alloc] init];
        centerLabel.textAlignment = NSTextAlignmentCenter;
        centerLabel.textColor = [UIColor blackColor];
        centerLabel.font = [UIFont systemFontOfSize:16.0];
        centerLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:centerLabel];
        self.centerLabel = centerLabel;
        
        //上方图片
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        //下方显示
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.font = [UIFont systemFontOfSize:12.0];
        detailLabel.textColor = [UIColor colorWithRed:0x7d/255.0 green:0x84/255.0 blue:0x87/255.0 alpha:1.0];
        detailLabel.backgroundColor = [UIColor clearColor];
        detailLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:detailLabel];
        self.detailLabel = detailLabel;
        
        //设备名称 功能分类展示
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:9.0];
        nameLabel.textColor = [UIColor colorWithRed:0x7d/255.0 green:0x84/255.0 blue:0x87/255.0 alpha:1.0];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
    }
    return self;
}

- (void)layoutSubviews
{
    self.centerLabel.frame = CGRectMake(0.0, 0.0,[UIScreen mainScreen].bounds.size.width/2-30, 20.0);
    self.centerLabel.center = self.contentView.center;
    
    self.iconView.frame = CGRectMake(0.0, 0.0, 27.0, 27.0);
    self.iconView.center = CGPointMake(self.contentView.center.x, CGRectGetMinY(self.centerLabel.frame) - 7.5 - CGRectGetHeight(self.centerLabel.frame) * 0.5);
    
    self.detailLabel.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.contentView.frame), 20.0);
    self.detailLabel.center = CGPointMake(self.contentView.center.x, (CGRectGetHeight(self.contentView.frame) + CGRectGetMaxY(self.centerLabel.frame)) * 0.5);
    
    self.nameLabel.frame = CGRectMake(0.0, 6.0, CGRectGetWidth(self.contentView.frame) - 12.0, 20.0);
}

- (void)setFeature:(Feature *)feature
{
    _feature = feature;
    
    NSString *iconName = @"icon_feature_setting";
    NSString *centerName = @"Live";
    NSString *detailName = @"1 Camera";
    NSString *deviceName = @"My Home";
    
    switch (feature.type) {
        case FeatureTypeLive:
        {
            iconName = @"icon_feature_live";
            centerName = NSLocalizedString(@"Beer", @"Beer");
            detailName = NSLocalizedString(@"Beer", @"Beer");
        }
            break;
        case FeatureTypeAlert:
        {
            iconName = @"icon_feature_alert";
            centerName = NSLocalizedString(@"Cooker", @"Cooker");
            detailName = centerName;
        }
            break;
        case FeatureTypeRing:
        {
            iconName = @"icon_feature_answering";
            centerName = NSLocalizedString(@"Camera", @"Camera");
            detailName = centerName;
        }
            break;
        case FeatureTypeDoor:
        {
            iconName = @"icon_feature_door";
            centerName = NSLocalizedString(@"Books", @"Books");
            detailName = centerName;
        }
            break;
        case FeatureTypeSoundAndLightAlarm:
        {
            iconName = @"icon_feature_soundligth";
            centerName = NSLocalizedString(@"Flowers", @"Flowers");
            detailName = centerName;
        }
            break;
        case FeatureTypeTemperature:
        {
            iconName = @"icon_feature_temperature";
            centerName = NSLocalizedString(@"Knife", @"Knife");
            detailName = [NSString stringWithFormat:@"Knife"];
        }
            break;
        case FeatureTypeHumidity:
        {
            iconName = @"icon_feature_humidity";
            centerName = NSLocalizedString(@"Package", @"Package");
            detailName = [NSString stringWithFormat:@"Package"];
        }
            break;
        case FeatureTypeRepeater:
        {
            iconName = @"icon_feature_WiFi_Repeater";
            centerName = NSLocalizedString(@"Mouse", @"Mouse");
            detailName = NSLocalizedString(@"Mouse", @"Mouse");
        }
            break;
        case FeatureTypeBuzzer:
        {
            iconName = @"icon_feature_buzzer";
            centerName = NSLocalizedString(@"Pad", @"Pad");
            detailName = NSLocalizedString(@"Pad", @"Pad");
        }
            break;
        case FeatureTypeLight:
        {
            iconName = @"icon_feature_light";
            centerName = NSLocalizedString(@"Light", @"Light");
            detailName =centerName;
        }
            break;
        case FeatureTypeBluetooth:
        {
            iconName = @"icon_feature_bluetooth";
            centerName = NSLocalizedString(@"Red Book", @"Red Book");
            detailName = centerName;
        }
            break;
        case FeatureTypeRoomSetting:
        {
            iconName = @"icon_feature_setting";
            centerName = NSLocalizedString(@"Phone", @"Phone");
            detailName = @"1234";
        }
            break;
        case FeatureTypeShop:
        {
            iconName = @"icon_feature_shop";
            centerName = NSLocalizedString(@"Shop", @"Shop");
            detailName =  centerName;
        }
            break;
        case FeatureTypeCloud:
        {
            iconName = @"icon_feature_cloud";
            centerName = NSLocalizedString(@"Headset", @"Headset");
            detailName = NSLocalizedString(@"Headset", @"Headset");
        }
            break;
        case FeatureTypeShare:
        {
            iconName = @"icon_feature_share";
            centerName = NSLocalizedString(@"Coat", @"Coat");
            detailName = NSLocalizedString(@"Coat", @"Coat");
        }
            break;
        case FeatureTypeDeviceSetting:
        {
            iconName = @"icon_feature_setting";
            centerName = NSLocalizedString(@"Settings", @"Settings");
            detailName =  centerName;
        }
            break;
        default:
            iconName = @"icon_feature_setting";
            break;
    }
    
    self.iconView.image = [UIImage imageNamed:iconName];
    self.centerLabel.text = centerName;
    self.detailLabel.text = detailName;
    self.nameLabel.text = deviceName;
}

@end
