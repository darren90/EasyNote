//
//  SettingLabelItem.m
//  EasyNote
//
//  Created by Tengfei on 15/12/6.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "SettingLabelItem.h"

@implementation SettingLabelItem
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title labelTitle:(NSString *)labelTitle
{
    SettingLabelItem *item = [self itemWithIcon:icon title:title];
    item.labelTitle = labelTitle;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title labelTitle:(NSString *)labelTitle
{
    return [self itemWithIcon:nil title:title labelTitle:labelTitle];
}

@end
