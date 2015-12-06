//
//  NoteListCell.h
//  EasyNote
//
//  Created by Tengfei on 15/12/6.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NoteModel;

@protocol NoteListCellDelegate <NSObject>

@optional
-(void)noteListCellDidDeleteThisItem:(NoteModel *)model;

@end


@interface NoteListCell : UICollectionViewCell

@property (nonatomic,strong)NoteModel * model;


@property (nonatomic,weak)id<NoteListCellDelegate> delegate;

@end
