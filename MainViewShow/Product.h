//
//  Product.h
//  MainViewShow
//
//  Created by Qinggong on 2017/3/8.
//  Copyright © 2017年 Qinggong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *productId;
@property (strong, nonatomic) NSMutableArray *features;

- (instancetype)initWithId:(NSString *)productId;
+ (instancetype)productWithId:(NSString *)productId;

@end
