//
//  BaseSettingViewController.m
//  EasyNote
//
//  Created by Tengfei on 15/12/6.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "BaseSettingViewController.h"
#import "SettingArrowItem.h"
#import "SettingSwitchItem.h"
#import "SettingGroup.h"
#import "SettingCell.h"
@interface BaseSettingViewController ()

@end

@implementation BaseSettingViewController

- (id)init
{
    return [super initWithStyle:UITableViewStylePlain];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStylePlain];
}

- (NSArray *)data
{
    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    return _data;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SettingGroup *group = self.data[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    SettingCell *cell = [SettingCell cellWithTableView:tableView];
    
    // 2.给cell传递模型数据
    SettingGroup *group = self.data[indexPath.section];
    cell.item = group.items[indexPath.row];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    // 3.返回cell
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.取消选中这行
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 2.模型数据
    SettingGroup *group = self.data[indexPath.section];
    SettingItem *item = group.items[indexPath.row];
    
    if (item.option) { // block有值(点击这个cell,.有特定的操作需要执行)
        item.option();
    } else if ([item isKindOfClass:[SettingArrowItem class]]) { // 箭头
        SettingArrowItem *arrowItem = (SettingArrowItem *)item;
        
        // 如果没有需要跳转的控制器
        if (arrowItem.destVcClass == nil) return;
        
        UIViewController *vc = [[arrowItem.destVcClass alloc] init];
        vc.title = arrowItem.title;
        [self.navigationController pushViewController:vc  animated:YES];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    
    CGSize footerSize = [sectionTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15, 8, footerSize.width, footerSize.height);
    label.numberOfLines=0;
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:12];
    label.text = sectionTitle;
    
    UIView *view = [[UIView alloc] init];
    [view addSubview:label];
    view.backgroundColor = KColor(239, 239, 239);
    
    return view;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SettingGroup *group = self.data[section];
    return group.header;
}
//设置尾部字体格式
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSString *sectionTitle = [self tableView:tableView titleForFooterInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    
    CGSize footerSize = [sectionTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}];;//
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake((self.view.frame.size.width-footerSize.width)/2, 8, footerSize.width, footerSize.height);
    label.numberOfLines=0;
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:11];
    label.text = sectionTitle;
    
    UIView *view = [[UIView alloc] init];
    [view addSubview:label];
    view.backgroundColor =  KColor(239, 239, 239);
    
    return view;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    SettingGroup *group = self.data[section];
    return group.footer;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    SettingGroup *group = self.data[section];
    return group.header.length > 0 ? 30 : 0.00000001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    SettingGroup *group = self.data[section];
    return group.footer.length > 0 ? 30 : 0.00000001;
}

@end
