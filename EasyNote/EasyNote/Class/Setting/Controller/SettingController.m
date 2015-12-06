//
//  SettingController.m
//  EasyNote
//
//  Created by Tengfei on 15/12/6.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "SettingController.h"
#import "SettingItem.h"
#import "SettingSwitchItem.h"
#import "SettingArrowItem.h"
#import "SettingLabelItem.h"
#import "SettingGroup.h"

@interface SettingController ()
@property (nonatomic,strong)NSMutableArray *dataArray ;
@end

@implementation SettingController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"page_设置"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"page_设置"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissSelf)];
    
    // 1.标题
    self.title = @"设置";
    
//    self.tableView.backgroundColor = MJColor(229, 230, 231);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 160 / 3;
    
    // 2.添加数据
    [self setupGroup_0];
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}
-(void)dismissSelf
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

/**
 *  第10组数据
 */
- (void)setupGroup_0
{
    //begain
    SettingItem *login = [SettingItem itemWithTitle:@"长按删除笔记"];
 
    
    SettingGroup *group = [[SettingGroup alloc] init];
    //    self.dataArray = @[login,synch];
    group.items = @[login];
    
    [self.data addObject:group];
}


/**
 *  第10组数据
 */
- (void)setupGroup0
{
    //begain
    SettingItem *login = [SettingItem itemWithTitle:@"登陆EverNote"];
    //    push.subtitle = @"追剧，影评，动态马上知道";
    
    SettingItem *synch = [SettingLabelItem itemWithTitle:@"同步笔记"];
    
    SettingGroup *group = [[SettingGroup alloc] init];
    //    self.dataArray = @[login,synch];
    group.items = @[login,synch];
    
    [self.data addObject:group];
}
/**
 *  第1组数据
 */
- (void)setupGroup1
{
    SettingItem *mark = [SettingItem itemWithTitle:@"去App Store评分"];
    mark.option =  ^{
        NSString *str = @"https://itunes.apple.com/cn/app/ren-ren-mei-ju-zhong-guo-zui/id952950430?mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    };
    
    SettingGroup *group = [[SettingGroup alloc] init];
    group.items = @[mark];

    [self.data addObject:group];
}


/**
 *  第2组数据
 */
- (void)setupGroup2
{
    SettingItem *suggest = [SettingArrowItem itemWithTitle:@"建议"];
    SettingItem *about = [SettingArrowItem itemWithTitle:@"关于"];
    
    SettingGroup *group = [[SettingGroup alloc] init];
    group.items = @[suggest,about];
 
    [self.data addObject:group];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)return;//取消按钮
    NSString *str = @"https://itunes.apple.com/cn/app/ren-ren-mei-ju-zhong-guo-zui/id952950430?mt=8";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


@end
