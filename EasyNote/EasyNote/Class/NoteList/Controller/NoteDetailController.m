//
//  NoteDetailController.m
//  EasyNote
//
//  Created by Tengfei on 15/12/6.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "NoteDetailController.h"
#import "PlaceholderTextView.h"
#import "NoteModel.h"

@interface NoteDetailController ()
@property (nonatomic,weak)PlaceholderTextView * textView;

@end

@implementation NoteDetailController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"Page_新建便签"];
    [self.textView becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"Page_新建便签"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back_me_h"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    // Do any additional setup after loading the view.
    PlaceholderTextView *textView = [[PlaceholderTextView alloc]init];
    self.textView = textView;
    textView.frame = self.view.bounds;
    textView.placeholder = @"输入文字，添加新笔记";
    [self.view addSubview:textView];
    textView.font = [UIFont systemFontOfSize:18];
    textView.text = self.model.content;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textHadhage) name:UITextViewTextDidChangeNotification object:nil];
}
-(void)back
{
    NSString *content = self.textView.text;
    if ([content stringByReplacingOccurrencesOfString:@" " withString:@""].length > 0 && ![content isEqualToString:self.model.content]) {
        //去掉首部空格，作为标题
        NSString *title = [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (title.length > 30) {
            title = [title substringToIndex:30];
        }
        NoteModel *m = [NoteModel noteWithIdStr:self.model.idStr title:title content:content];
//        self.model.title = title;
//        self.model.content = content;
        [FMDBTool modifyNoteWithNoteModel:m idStr:self.model.idStr];
        NSLog(@"content:%@",content);
    }
    
    [self.navigationController popViewControllerAnimated:YES];;
}

-(void)textHadhage
{
    
}


@end
