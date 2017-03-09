//
//  Feature.h
//  Zmodo
//
//  Created by Qinggong on 16/8/12.
//  Copyright © 2016年 Zmodo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, FeatureType)
{
    FeatureTypeLive = 0,
    FeatureTypeAlert,
    FeatureTypeRing,
    FeatureTypeDoor,
    FeatureTypeTemperature,
    FeatureTypeHumidity,
    FeatureTypeRepeater,
    FeatureTypeBuzzer,
    FeatureTypeLight,
    FeatureTypeBluetooth,
    FeatureTypeSoundAndLightAlarm,
    FeatureTypeRoomSetting,
    FeatureTypeShop,
    FeatureTypeCloud,
    FeatureTypeShare,
    FeatureTypeDeviceSetting,
};

@interface Feature : NSObject

@property (assign, nonatomic) FeatureType type;

+ (instancetype)featureWithType:(FeatureType)type;
- (instancetype)initWithType:(FeatureType)type;

@end
