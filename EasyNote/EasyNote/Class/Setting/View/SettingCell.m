//
//  SettingCell.m
//  EasyNote
//
//  Created by Tengfei on 15/12/6.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "SettingCell.h"
#import "SettingItem.h"
#import "SettingSwitchItem.h"
#import "SettingArrowItem.h"
#import "SettingLabelItem.h"

@interface SettingCell ()<UIAlertViewDelegate>
/***  箭头 */
@property (nonatomic, strong) UIImageView *arrowView;
/***  开关 */
@property (nonatomic, strong) UISwitch *switchView;
/***  标签 */
@property (nonatomic, strong) UILabel *labelView;

@property (nonatomic,weak)UILabel * titleLabel;

@property (nonatomic,weak)UILabel * infoLabel;

@end

@implementation SettingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.textLabel.textColor = [UIColor blackColor];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:16];
        
        UILabel *infoLabel = [[UILabel alloc]init];
        [self.contentView addSubview:infoLabel];
        self.infoLabel = infoLabel;
        infoLabel.textColor = [UIColor grayColor];
        infoLabel.font = [UIFont systemFontOfSize:12];
        self.infoLabel = infoLabel;
    }
    return self;
}

- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_indictor_img"]];
    }
    return _arrowView;
}

- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
        [_switchView addTarget:self action:@selector(switchStateChange) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}

/**
 *  监听开关状态改变
 */
- (void)switchStateChange
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    if (self.item.key) {
    [defaults setBool:self.switchView.isOn forKey:self.item.title];
    [defaults synchronize];
    
}


- (BOOL)isAllowedNotification {
    //iOS8 check if user allow notification
    if (IsIOS8) {// system is iOS8
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone != setting.types) {
            return YES;
        }
    } else {//iOS7
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone != type)
            return YES;
    }
    
    return NO;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) return;
    NSURL*url=[NSURL URLWithString:@"prefs:root=NOTIFICATI_ID"];
    [[UIApplication sharedApplication] openURL:url];
}

- (UILabel *)labelView
{
    if (_labelView == nil) {
        _labelView = [[UILabel alloc] init];
        _labelView.bounds = CGRectMake(0, 0, 100, 30);
        _labelView.font = [UIFont systemFontOfSize:12];
        _labelView.textColor = [UIColor grayColor];
        _labelView.textAlignment = NSTextAlignmentRight;
    }
    return _labelView;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"setting";
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (void)setItem:(SettingItem *)item
{
    _item = item;
    
    // 1.设置数据
    [self setupData];
    
    // 2.设置右边的内容
    [self setupRightContent];
}

/**
 *  设置右边的内容
 */
- (void)setupRightContent
{
    if ([self.item isKindOfClass:[SettingArrowItem class]]) { // 箭头
        self.accessoryView = self.arrowView;
        self.accessoryView.frame =  CGRectMake(KWidth - 65, 0.5, 44, 44);
    } else if ([self.item isKindOfClass:[SettingSwitchItem class]]) { // 开关
        self.accessoryView = self.switchView;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 设置开关的状态
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.switchView.on = [defaults boolForKey:self.item.title];
    } else if ([self.item isKindOfClass:[SettingLabelItem class]]) { // 标签
        self.accessoryView = self.labelView;
        SettingLabelItem *labelItem = (SettingLabelItem *)self.item;
        self.labelView.text = labelItem.labelTitle;
    } else {
        self.accessoryView = nil;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //frame
    CGSize titleSize = [self.item.title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    CGFloat height = self.frame.size.height;
    CGFloat margin = 15;
    
    if ( self.item.subtitle) {//有子标题
        self.titleLabel.hidden = NO;
        CGSize infoSize = [self.item.subtitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        
        CGFloat title2info = 3;
        CGFloat lMargin = (height - titleSize.height-infoSize.height - title2info) / 2;//距离顶部的高度 3：两个label的间距
        self.titleLabel.frame = CGRectMake(margin, lMargin, titleSize.width, titleSize.height);
        
        self.infoLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.titleLabel.frame)+title2info, infoSize.width, infoSize.height);
    }else{  //无
        self.infoLabel.hidden = YES;
        self.titleLabel.frame = CGRectMake(margin, (height-titleSize.height)/2, titleSize.width, titleSize.height);
    }
    
    if (IsIOS7) {//ios7下， drawRect划线无法显示
        [self.subviews[0] setBackgroundColor:[UIColor clearColor]];
    }
}

/**
 *  设置数据
 */
- (void)setupData
{
    if (self.item.icon) {
        self.imageView.image = [UIImage imageNamed:self.item.icon];
    }
    //    self.textLabel.text = self.item.title;
    //    self.detailTextLabel.text = self.item.subtitle;
    self.titleLabel.text = self.item.title;
    self.infoLabel.text = self.item.subtitle;
    
}

- (void)drawRect:(CGRect)rect   //画出tableviewcell下方的分割线
{
    CGFloat lineHeight = 0.001;
    CGFloat cellHetht = self.frame.size.height;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, 0, cellHetht - lineHeight);
    CGContextAddLineToPoint(ctx, KWidth, cellHetht - lineHeight);
    [[UIColor lightGrayColor] set];
    CGContextStrokePath(ctx);
}

@end
