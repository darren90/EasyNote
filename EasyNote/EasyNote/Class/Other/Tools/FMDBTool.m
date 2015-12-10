//
//  FMDBTool.m
//  easytNote
//
//  Created by Fengtf on 15/8/8.
//  Copyright (c) 2015年 ftf. All rights reserved.
//

#import "FMDBTool.h"
#import "FMDB.h"   
#import "NoteModel.h"

@implementation FMDBTool

static FMDatabaseQueue *_queue;
+ (void)initialize
{
    // 0.获得沙盒中的数据库文件名
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"easytNote.sqlite"];
    // 1.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 2.创表
    [_queue inDatabase:^(FMDatabase *db) {
        //idStr title content location addTime
        
        //idStr:主键，唯一不变的量：创建笔记的时间取md5加密后的唯一字符串  isSynched:是否和EverNote同步了
        [db executeUpdate:@"create table if not exists easytNote (id integer primary key autoincrement,idStr text,title text,content text, addTime text,isSynched BOOL);"];
    }];
}

/**
 *  添加笔记
 *
 *  @param model NoteModel
 *  @param idStr 主键
 *
 *  @return 是否添加成功
 */
+(BOOL)addNoteWithNoteModel:(NoteModel *)model idStr:(NSString *)idStr
{
    __block BOOL result;
    [_queue inDatabase:^(FMDatabase *db) {
        // 2.存储数据
        result = [db executeUpdate:@"insert into easytNote (idStr, title, content, addTime,isSynched) values(?,?,?,?,?)",idStr, model.title, model.content,[NSString getTime],@(NO)];
        if (result) {
//            [HUDTools showSuccess:@"保存成功"];
        }else{
            [HUDTools showError:@"保存失败"];
        }
    }];
    return result;
}
/**
 *  删除笔记
 *
 *  @param idStr 主键
 */
+(BOOL)delNoteWithIdStr:(NSString *)idStr
{
    __block BOOL result;
    [_queue inDatabase:^(FMDatabase *db) {
        // 2.存储数据
       result = [db executeUpdate:@"delete from easytNote where idStr = ?", idStr];
    }];
    return result;
}
/**
 *  修改笔记
 *
 *  @param model NoteModel
 *  @param idStr 主键
 *
 *  @return 是否修改成功
 */
+(BOOL)modifyNoteWithNoteModel:(NoteModel *)model idStr:(NSString *)idStr
{
    __block BOOL result;
    [_queue inDatabase:^(FMDatabase *db) {
        // 2.存储数据
//        [db executeQuery:@"delete easytNote where idStr = ?",idStr];
//        
//        result = [db executeUpdate:@"insert into easytNote (idStr, title, content, addTime) values(?,?,?,?)",[NSString idStr], model.title, model.content,[NSString getTime]];

        result = [db executeUpdate:@"update easytNote set title = ?, content = ?,addTime = ? where idStr = ?",  model.title, model.content,[NSString getTime],idStr];
        if (result) {
//            [HUDTools showSuccess:@"保存成功"];
        }else{
            [HUDTools showError:@"保存失败"];
        }
    }];
    return result;
}


/**
 *  更改笔记的同步状态（与EverNote同步）
 *
 *  @param model NoteModel
 *  @param idStr 主键
 *
 *  @return 是否修改成功
 */
+(BOOL)updateNoteSynchedWithIdStr:(NSString *)idStr;
{
    __block BOOL result;
    [_queue inDatabase:^(FMDatabase *db) {
    result = [db executeUpdate:@"update easytNote set isSynched = 1 where idStr = ?",idStr];
        if (result) {
            //            [HUDTools showSuccess:@"保存成功"];
        }else{
            [HUDTools showError:@"保存失败"];
        }
    }];
    return result;
}

/**
 *  取出所有的笔记
 *
 *  @return NoteModel数组
 */
+(NSArray *)getAllNotes
{
    // 1.定义数组
    __block NSMutableArray *array = nil;
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        array = [NSMutableArray array];
        FMResultSet *rs = nil;
        rs = [db executeQuery:@"select * from easytNote order by addTime desc;"];
        while (rs.next) {
            NoteModel *model = [[NoteModel alloc]init];
            model.idStr = [rs stringForColumn:@"idStr"];
            model.title = [rs stringForColumn:@"title"];
            model.content = [rs stringForColumn:@"content"];
            model.addTime = [rs stringForColumn:@"addTime"];
            model.isSynched = [rs boolForColumn:@"isSynched"];
            [array addObject:model];
        }
    }];
    // 3.返回数据
    return array;
}


/**
 *  根据是否登陆取出笔记列表
 *
 *  @param isSynched 是否已经同步过
 *
 *  @return NoteModel数组
 */
+(NSArray *)getNotesWithNoteSynched:(BOOL)isSynched
{
    // 1.定义数组
    __block NSMutableArray *array = nil;
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        array = [NSMutableArray array];
        FMResultSet *rs = nil;
        rs = [db executeQuery:@"select * from easytNote where isSynched = ? order by addTime desc;",@(isSynched)];
        while (rs.next) {
            NoteModel *model = [[NoteModel alloc]init];
            model.idStr = [rs stringForColumn:@"idStr"];
            model.title = [rs stringForColumn:@"title"];
            model.content = [rs stringForColumn:@"content"];
            model.addTime = [rs stringForColumn:@"addTime"];
            model.isSynched = [rs boolForColumn:@"isSynched"];
            [array addObject:model];
        }
    }];
    // 3.返回数据
    return array;
}

 
@end
