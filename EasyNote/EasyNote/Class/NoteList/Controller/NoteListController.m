
//
//  NoteListController.m
//  EasyNote
//
//  Created by Tengfei on 15/12/6.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "NoteListController.h"
#import "NoteListCell.h"
#import "NewNoteController.h"
#import "NoteModel.h"
#import "SettingController.h"
#import "BaseNavigationController.h"

@interface NoteListController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)NSMutableArray * dataArray;

@property (nonatomic,weak)UICollectionView *waterView;
@end

@implementation NoteListController

static NSString *const IDENTTFIER = @"notelist";

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"Page_便签列表"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"Page_便签列表"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollToTop)];
    [self.navigationController.navigationBar addGestureRecognizer:tap];
    
    [self initWaterView];
    [self initNavBar];
}
-(void)initNavBar
{
    self.view.backgroundColor = KColor(245, 245, 245);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewNote)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"setting"] style:UIBarButtonItemStyleDone target:self action:@selector(jumpToSeeting)];
}

-(void)initWaterView
{
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);//减去顶部NavBar64，底部TabBar49
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView * waterView = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:flowLayout];
    [waterView registerNib:[UINib nibWithNibName:@"NoteListCell" bundle:nil] forCellWithReuseIdentifier:IDENTTFIER];
    [self.view addSubview:waterView];
    
    waterView.backgroundColor = [UIColor whiteColor];
    waterView.delegate = self;
    waterView.dataSource = self;
    self.waterView = waterView;
    waterView.backgroundColor = KColor(245, 245, 245);
    
    CGFloat section = 10;
    int imgW = (KWidth - 3*section) / 2;
    int imgH = imgW;
    
    flowLayout.itemSize = CGSizeMake(imgW, imgH);
    flowLayout.minimumLineSpacing = 10;// =70/3
    flowLayout.minimumInteritemSpacing = 7;
    //flowLayout.headerReferenceSize = CGSizeMake(10, 10);
    flowLayout.sectionInset = UIEdgeInsetsMake(section,section,0,section);
}

-(void)jumpToSeeting
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SettingController *newVc = [sb instantiateViewControllerWithIdentifier:@"setingVc"];
//    SettingController *newVc = [[SettingController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:newVc];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)addNewNote
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewNoteController *newVc = [sb instantiateViewControllerWithIdentifier:@"newNoteVc"];
//    NoteModel *model = self.dataArray[inde ];
//    newVc.noteId = self.
    [self.navigationController pushViewController:newVc animated:YES];
}

#pragma - mark 滚到顶部
- (void)scrollToTop
{
    [self.waterView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}
  #pragma  - mark 视频搜索界面
- (void)rightBtnClick
{
    [self performSegueWithIdentifier:@"movieSearch" sender:self];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;//self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NoteListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IDENTTFIER forIndexPath:indexPath];
//    cell.model = self.dataArray[indexPath.item];
//    cell.backgroundColor = [UIColor grayColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    MovieHome *model = self.dataArray[indexPath.item];
//    MovieDetailViewController *detailVc = [[MovieDetailViewController alloc]init];
//    detailVc.seasonId = model.ID;
//    detailVc.topTitle = model.title;
//    self.navigationController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:detailVc animated:YES];
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
