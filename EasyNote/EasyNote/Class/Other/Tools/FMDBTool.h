//
//  FMDBTool.h
//  SmartNote
//
//  Created by Fengtf on 15/8/8.
//  Copyright (c) 2015年 ftf. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NoteModel;

@interface FMDBTool : NSObject

/********* 笔记 *************/

/**
*  添加笔记
*
*  @param model NoteModel
*  @param idStr 主键
*
*  @return 是否添加成功
*/
+(BOOL)addNoteWithNoteModel:(NoteModel *)model idStr:(NSString *)idStr;
/**
 *  删除笔记
 *
 *  @param idStr 主键
 */
+(BOOL)delNoteWithIdStr:(NSString *)idStr;
/**
 *  修改笔记
 *
 *  @param model NoteModel
 *  @param idStr 主键
 *
 *  @return 是否修改成功
 */
+(BOOL)modifyNoteWithNoteModel:(NoteModel *)model idStr:(NSString *)idStr;

/**
 *  更改笔记的同步状态（与EverNote同步）
 *
 *  @param model NoteModel
 *  @param idStr 主键
 *
 *  @return 是否修改成功
 */
+(BOOL)updateNoteSynchedWithIdStr:(NSString *)idStr;

/**
 *  取出所有的笔记
 *
 *  @return NoteModel数组
 */
+(NSArray *)getAllNotes;

/**
 *  根据是否登陆取出笔记列表
 *
 *  @param isSynched 是否已经同步过
 *
 *  @return NoteModel数组
 */
+(NSArray *)getNotesWithNoteSynched:(BOOL)isSynched;
 
@end










