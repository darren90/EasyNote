
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
#import "NoteDetailController.h"

@interface NoteListController ()<UICollectionViewDelegate,UICollectionViewDataSource,NoteListCellDelegate,UIAlertViewDelegate>

@property (nonatomic,strong)NSMutableArray * dataArray;

@property (nonatomic,weak)UICollectionView *waterView;

/**
 *  删除的index
 */
//@property (nonatomic,assign)NSUInteger delIndex;

@property (nonatomic,strong)NoteModel * delModel;

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
    
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:[FMDBTool getAllNotes]];
    [self.waterView reloadData];
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
    [waterView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    waterView.backgroundColor = [UIColor whiteColor];
    waterView.delegate = self;
    waterView.dataSource = self;
    self.waterView = waterView;
    waterView.backgroundColor = KColor(245, 245, 245);
    waterView.alwaysBounceVertical = YES;
    
    CGFloat section = 10;
    int imgW = (KWidth - 3*section) / 2;
    int imgH = imgW;
    
    flowLayout.itemSize = CGSizeMake(imgW, imgH);
    flowLayout.minimumLineSpacing = 10;// =70/3
    flowLayout.minimumInteritemSpacing = 7;
    //flowLayout.headerReferenceSize = CGSizeMake(10, 10);
    flowLayout.sectionInset = UIEdgeInsetsMake(section,section,section,section);
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    NSLog(@"size:%@",NSStringFromCGSize(size));
    // 根据屏幕宽度决定列数
//    int cols = (size.width == 1024) ? 3 : 2;
    int cols = 2;
    if (size.width == 480 || size.width == 568 || size.width == 667 || size.width == 736) {
        cols = 3;
    }
    
    // 根据列数计算内边距
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.waterView.collectionViewLayout;
    CGFloat inset = (size.width - cols * layout.itemSize.width) / (cols + 1);
    layout.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    
    // 设置每一行之间的间距
    layout.minimumLineSpacing = inset;
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

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    // 计算一遍内边距
    [self viewWillTransitionToSize:CGSizeMake(self.waterView.frame.size.width, 0) withTransitionCoordinator:nil];
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NoteListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IDENTTFIER forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    cell.delegate = self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NoteDetailController *detailVc = [sb instantiateViewControllerWithIdentifier:@"noteDetailVc"];
    NoteModel *model = self.dataArray[indexPath.row];
    detailVc.model = model;
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark 
-(void)noteListCellDidDeleteThisItem:(NoteModel *)model
{
    self.delModel = model;
//    NSUInteger index = [self.dataArray indexOfObject:model];
//    NSLog(@"---lllll----pp:%lu",(unsigned long)index);
    
    UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:@"删除便签" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
     [alert show];
    //1：删除数据库
//    [FMDBTool delBookWithBookName:bookName];

    //2：更新数据源，刷新表格
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
//    [self.dataArray removeObjectAtIndex:indexPath.row];
//    [self.waterView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSUInteger index = [self.dataArray indexOfObject:self.delModel];
        //1：删除数据库
        [FMDBTool delNoteWithIdStr:self.delModel.idStr];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.waterView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    }
}



- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
