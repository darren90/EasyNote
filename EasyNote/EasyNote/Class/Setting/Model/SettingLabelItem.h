//
//  SettingLabelItem.h
//  EasyNote
//
//  Created by Tengfei on 15/12/6.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "SettingItem.h"

@interface SettingLabelItem : SettingItem

@property (nonatomic, copy) NSString *labelTitle;


+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title labelTitle:(NSString *)labelTitle;
+ (instancetype)itemWithTitle:(NSString *)title labelTitle:(NSString *)labelTitle;

@end
