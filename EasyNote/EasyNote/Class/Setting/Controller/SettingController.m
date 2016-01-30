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
#import "NoteModel.h"

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
    [self setupArraydata];
  }

-(void)setupArraydata
{
    [self setupGroup_0];
//    [self setupGroup0];//印象笔记相关
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
    SettingItem *operate1 = [SettingItem itemWithTitle:@"长按可删除笔记"];
    SettingItem *operate2 = [SettingItem itemWithTitle:@"右下角有云朵标示的为已同步笔记"];

    
    SettingGroup *group = [[SettingGroup alloc] init];
    //    self.dataArray = @[login,synch];
    group.items = @[operate1,operate2];
    group.header = @"操作";
    
    [self.data addObject:group];
}

/**
 *  第10组数据
 */
- (void)setupGroup0
{
    //begain
    SettingItem *synch = [SettingLabelItem itemWithTitle:@"同步笔记"];
    
    SettingGroup *group = [[SettingGroup alloc] init];
    if([[ENSession sharedSession] isAuthenticated]){
        SettingItem *login = [SettingItem itemWithTitle:@"退出登陆"];
        group.items = @[login,synch];
    }else{
        SettingItem *login = [SettingItem itemWithTitle:@"登陆EverNote"];

        group.items = @[login];
    }
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
//    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *titlePre = @"当前版本";
    NSString *title = [NSString stringWithFormat:@"%@ (%@)",titlePre,currentVersion];
    
    NSMutableAttributedString *markAttrStr = [[NSMutableAttributedString alloc]initWithString:title];
    [markAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, titlePre.length)];
    [markAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(titlePre.length, title.length - titlePre.length)];
    [markAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(titlePre.length, title.length - titlePre.length)];
    [markAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(titlePre.length+2, title.length - titlePre.length - 3)];//有个空格，所以+1
#warning TODO - 待做，属性字符串
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.section == 2 && indexPath.row == 0) {//第二区，App Store评价
//        NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8",KAppid];
//        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//    }else if (indexPath.section == 2 && indexPath.row == 1){//第二区，App Store建议
//        NSString *stringURL = @"mailto:fengtenfei90@163.com";
//        NSURL *url = [NSURL URLWithString:stringURL];
//        [[UIApplication sharedApplication] openURL:url];
//    }else if (indexPath.section == 1 && indexPath.row == 0){//第一区，登陆EverNote
//        [self logInOrLogOut];
//    }else if (indexPath.section == 1 && indexPath.row == 1){//第一区，同步笔记
//        [self synchroNotes];
//    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {//第二区，App Store评价
        NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8",KAppid];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else if (indexPath.section == 1 && indexPath.row == 1){//第二区，App Store建议
        NSString *stringURL = @"mailto:fengtenfei90@163.com";
        NSURL *url = [NSURL URLWithString:stringURL];
        [[UIApplication sharedApplication] openURL:url];
    }
}


-(void)synchroNotes
{
    NSArray *array = [FMDBTool getNotesWithNoteSynched:NO];
    
    for (int i = 0 ; i< array.count; i++) {
        NoteModel *model = array[i];
        [SVProgressHUD showProgress:i/array.count status:[NSString stringWithFormat:@"同步中:%d/%lu",i ,(unsigned long)array.count] maskType:SVProgressHUDMaskTypeBlack];
        [self synchroNoteWithNoteModel:model];
    }
    [SVProgressHUD dismiss];
}

- (void)synchroNoteWithNoteModel:(NoteModel *)model {
    ENNote *noteToSave = [[ENNote alloc] init];
    noteToSave.title = model.title;
    NSString *content1 = model.content;
    ENNoteContent *noteContent = [ENNoteContent noteContentWithString:content1];
    [noteToSave setContent:noteContent];
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [[ENSession sharedSession] uploadNote:noteToSave notebook:nil completion:^(ENNoteRef *noteRef, NSError *uploadNoteError) {
        if (noteRef) {
            [FMDBTool updateNoteSynchedWithIdStr:model.idStr];//更新数据库的同步显示
        }
    }];
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
        
    } else {
        
    }
//    [self updateLoginItem];//更新登陆/登出的状态显示
    [self.data removeAllObjects];
     [self setupArraydata];
    [self.tableView reloadData];
}


@end
