//
//  NoteListCell.m
//  EasyNote
//
//  Created by Tengfei on 15/12/6.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "NoteListCell.h"
#import "NoteModel.h"

@interface NoteListCell()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation NoteListCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel.backgroundColor = [UIColor lightGrayColor];
}


-(void)setModel:(NoteModel *)model
{
    _model = model;
    
    self.timeLabel.text = model.addTime;
    self.titleLabel.text = model.title;
}

@end
