//
//  FMDBTool.h
//  SmartNote
//
//  Created by Fengtf on 15/8/8.
//  Copyright (c) 2015年 ftf. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NoteModel,NoteMarkModel;

@interface FMDBTool : NSObject

/********* 笔记 *************/
+(BOOL)addNoteWithNoteModel:(NoteModel *)model idStr:(NSString *)idStr;
+(void)delNoteWithIdStr:(NSString *)idStr;
+(BOOL)modifyNoteWithNoteModel:(NoteModel *)model idStr:(NSString *)idStr;
+(NSArray *)getNoteWithDate:(NSString *)dateStr;
+(NSArray *)getAllNote;
+(int)getAllNoteCount;
+(int)getAllNoteCollectedCount;
/** 得到全部的笔记，是否收藏：YES:收藏，NO： */
+(NSArray *)getAllNoteIfCollect:(BOOL)isCollect;

+(NSArray *)getAllLocations;

/********* 标签 *************/
+(BOOL)addNoteMarkWithNoteModel:(NoteMarkModel *)model idStr:(NSString *)idStr;;
+(void)delNoteMarkWithIdStr:(NSString *)idStr mark:(NSString *)mark;
+(void)modifyNoteMarkWithNoteModel:(NoteMarkModel *)model;
+(NSArray *)getAllNoteMarks;
+(int)getAllNoteMarksCount;


/********* 笔记本 *************/
+(BOOL)addBookWithBookName:(NSString *)bookName;
+(void)delBookWithBookName:(NSString *)bookName;
+(void)modifyBookWithBookName:(NSString *)bookName;
+(NSArray *)getAllBooks;
+(int)getAllBooksCount;;
@end
