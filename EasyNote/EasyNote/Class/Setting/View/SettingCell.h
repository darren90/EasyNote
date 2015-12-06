//
//  SettingCell.h
//  EasyNote
//
//  Created by Tengfei on 15/12/6.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingItem;
@interface SettingCell : UITableViewCell
@property (nonatomic, strong) SettingItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
