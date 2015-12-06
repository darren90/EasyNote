//
//  NewNoteController.m
//  EasyNote
//
//  Created by Tengfei on 15/12/6.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "NewNoteController.h"
#import "PlaceholderTextView.h"

@interface NewNoteController ()

@property (nonatomic,weak)PlaceholderTextView * textView;

@end

@implementation NewNoteController

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
}
-(void)back
{
    //    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];;
}


@end
