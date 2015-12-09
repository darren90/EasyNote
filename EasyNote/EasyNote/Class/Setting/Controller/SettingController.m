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

#import "CommonUtils.h"
#import <ENSDK.h>
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
    self.view.backgroundColor =  KColor(239, 239, 239);
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
    group.header = @"操作";
    
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
    group.items = @[login,synch];
    group.header = @"同步";
    
    [self.data addObject:group];
}
/**
 *  第1组数据
 */
- (void)setupGroup1
{
    SettingItem *mark = [SettingArrowItem itemWithTitle:@"去App Store评分"];
    mark.option =  ^{
        NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8",KAppid];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    };
    SettingItem *suggest = [SettingArrowItem itemWithTitle:@"建议"];
    suggest.option = ^{
        NSString *stringURL = @"mailto:fengtenfei90@163.com";
        NSURL *url = [NSURL URLWithString:stringURL];
        [[UIApplication sharedApplication] openURL:url];
    };
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    NSString *title = [NSString stringWithFormat:@"当前版本 (V:%@)",currentVersion];
    SettingItem *version = [SettingItem itemWithTitle:title];

    
    SettingGroup *group = [[SettingGroup alloc] init];
    group.items = @[mark,suggest];
    group.header = @"APP";

    [self.data addObject:group];
}


/**
 *  第2组数据
 */
- (void)setupGroup2
{
    SettingItem *weibo = [SettingItem itemWithTitle:@"微博ID：STRING冯"];
    SettingItem *about = [SettingItem itemWithTitle:@"程序员，iOS开发者，热爱编程，热爱生活！"];
    
    SettingGroup *group = [[SettingGroup alloc] init];
    group.items = @[weibo,about];
    group.header = @"关于";
 
    [self.data addObject:group];
}
// http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1065348807&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 && indexPath.row == 0) {//第二区，App Store评价
        NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8",KAppid];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else if (indexPath.section == 2 && indexPath.row == 1){//第二区，App Store建议
        NSString *stringURL = @"mailto:fengtenfei90@163.com";
        NSURL *url = [NSURL URLWithString:stringURL];
        [[UIApplication sharedApplication] openURL:url];
    }else if (indexPath.section == 1 && indexPath.row == 0){//第一区，登陆EverNote
        [self logInOrLogOut];
    }
    
}


- (void)logInOrLogOut {
    if ([[ENSession sharedSession] isAuthenticated]) {
        [[ENSession sharedSession] unauthenticate];
        [self update];
    } else {
        [[ENSession sharedSession] authenticateWithViewController:self
                                               preferRegistration:NO
                                                       completion:^(NSError *authenticateError) {
                                                           if (!authenticateError) {
                                                               [self update];
                                                           } else if (authenticateError.code != ENErrorCodeCancelled) {
                                                               [CommonUtils showSimpleAlertWithMessage:@"Could not authenticate."];
                                                           }
                                                       }];
    }
}
/**
 *  登陆EverNote成功
 */
- (void)update
{
    if ([[ENSession sharedSession] isAuthenticated]) {
        NSString *userName = [[ENSession sharedSession] userDisplayName];
        NSLog(@"---:%@",userName);
        [self.navigationItem setTitle:[[ENSession sharedSession] userDisplayName]];
    } else {
        [self.navigationItem setTitle:nil];
    }
//    [self updateLoginItem];//更新登陆/登出的状态显示
    
    [self.tableView reloadData];
}



@end
