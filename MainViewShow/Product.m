//
//  Product.m
//  MainViewShow
//
//  Created by Qinggong on 2017/3/8.
//  Copyright © 2017年 Qinggong. All rights reserved.
//

#import "Product.h"
#import "Feature.h"

@implementation Product

- (instancetype)initWithId:(NSString *)productId
{
    if (self = [super init]) {
        _productId = productId;
        
        Feature *feature0 =  [Feature featureWithType:FeatureTypeLive];
        Feature *feature1 =  [Feature featureWithType:FeatureTypeAlert];
        Feature *feature2 =  [Feature featureWithType:FeatureTypeRing];
        Feature *feature3 =  [Feature featureWithType:FeatureTypeDoor];
        Feature *feature4 =  [Feature featureWithType:FeatureTypeTemperature];
        Feature *feature5 =  [Feature featureWithType:FeatureTypeHumidity];
        Feature *feature6 =  [Feature featureWithType:FeatureTypeRepeater];
        Feature *feature7 =  [Feature featureWithType:FeatureTypeBuzzer];
        Feature *feature8 =  [Feature featureWithType:FeatureTypeLight];
        Feature *feature9 =  [Feature featureWithType:FeatureTypeBluetooth];
        Feature *feature12 = [Feature featureWithType:FeatureTypeSoundAndLightAlarm];
        Feature *feature13 = [Feature featureWithType:FeatureTypeRoomSetting];
        Feature *feature14 = [Feature featureWithType:FeatureTypeShop];
        Feature *feature15 = [Feature featureWithType:FeatureTypeCloud];
        Feature *feature16 = [Feature featureWithType:FeatureTypeShare];
        Feature *feature17 = [Feature featureWithType:FeatureTypeDeviceSetting];

        switch ([productId intValue]) {
            case 0:
                _name = @"Sunset";
                _features = [NSMutableArray arrayWithObjects:feature0,feature1,feature2,feature3,feature4,
                             feature5,feature6,feature7,feature8,feature9,feature12,
                             feature13,feature14,feature15,feature16,feature17,nil];
                break;
            case 1:
                _name = @"Watch";
                _features = [NSMutableArray arrayWithObjects:feature0,feature1,feature2,feature3,nil];
                break;
            case 2:
                _name = @"Landscape";
                _features = [NSMutableArray arrayWithObjects:feature0,feature1,feature3,feature4,
                             feature5,feature6,feature8,feature9,
                             feature13,feature14,feature15,feature16,nil];
                break;
            case 3:
                _name = @"Bloodborne";
                _features = [NSMutableArray arrayWithObjects:feature0,feature1,feature2,feature3,feature4,nil];
                break;
            case 4:
                _name = @"Bugatti";
                _features = [NSMutableArray arrayWithObjects:feature12,
                             feature13,feature14,feature15,feature16,feature17,nil];
                break;
            case 5:
                _name = @"Industry";
                _features = [NSMutableArray arrayWithObjects:feature1,feature2,feature3,feature4,
                             feature5,feature6,feature7,feature12,
                             feature13,feature14,feature15,feature16,feature17,nil];
                break;
            case 6:
                _name = @"Bicycle";
                _features = [NSMutableArray arrayWithObjects:feature0,feature2,feature3,feature4,
                             feature5,feature7,feature8,feature12,
                             feature13,feature14,feature15,feature17,nil];
                break;
            case 7:
                _name = @"Asahi";
                _features = [NSMutableArray arrayWithObjects:feature0,feature1,feature17,nil];
                break;
            case 8:
                _name = @"Floor";
                _features = [NSMutableArray arrayWithObjects:feature0,feature1,feature2,feature3,feature4,
                             feature5,feature6,feature7,feature8,feature9,feature12,
                             feature13,feature14,feature15,feature16,feature17,nil];
                break;
            default:
                break;
        }
    }
    return self;
}

+ (instancetype)productWithId:(NSString *)productId
{
    return [[self alloc] initWithId:productId];
}

@end
