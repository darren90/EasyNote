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
//    self.titleLabel.backgroundColor = [UIColor lightGrayColor];
    
    self.userInteractionEnabled = YES;
    
    UIGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didDelSelf:)];
    [self addGestureRecognizer:longTap];
}

-(void)didDelSelf:(UIGestureRecognizer *)gesture
{
//    NSLog(@"-state-:%ld",(long)gesture.state);
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        if ([self.delegate respondsToSelector:@selector(noteListCellDidDeleteThisItem:)]) {
            [self.delegate noteListCellDidDeleteThisItem:self.model];
        }
    }
}

-(void)setModel:(NoteModel *)model
{
    _model = model;
    
    self.timeLabel.text = model.addTime;
    self.titleLabel.text = model.title;
}

@end
