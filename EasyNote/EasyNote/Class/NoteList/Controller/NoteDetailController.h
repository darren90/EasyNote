//
//  NoteDetailController.h
//  EasyNote
//
//  Created by Tengfei on 15/12/6.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NoteModel;
@interface NoteDetailController : UIViewController

//@property (nonatomic,copy)NSString * noteId;

@property (nonatomic,strong)NoteModel * model;

@end
