//
//  HCategoryCell.m
//  MainInterface
//
//  Created by Qinggong on 16/8/10.
//  Copyright © 2016年 zmodo. All rights reserved.
//

#import "HCategoryCell.h"

@interface HCategoryCell ()

@property (weak, nonatomic) UILabel *label;

@end

@implementation HCategoryCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)layoutSubviews
{
    self.label.frame = self.contentView.frame;
}

- (void)setName:(NSString *)name{
    self.label.text = name;
}

@end
