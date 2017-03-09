//
//  Feature.m
//  Zmodo
//
//  Created by Qinggong on 16/8/12.
//  Copyright © 2016年 Zmodo. All rights reserved.
//

#import "Feature.h"

@implementation Feature

+ (instancetype)featureWithType:(FeatureType)type
{
    return [[self alloc] initWithType:type];
}
- (instancetype)initWithType:(FeatureType)type
{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}
    
@end
