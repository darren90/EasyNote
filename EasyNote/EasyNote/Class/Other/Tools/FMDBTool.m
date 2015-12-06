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
//#import "NoteMarkModel.h"
//#import "NoteBookModel.h"

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
        //idStr title content location addTime lastModifyTime --markArray
        
        //idStr:主键，唯一不变的量：创建笔记的时间取md5加密后的唯一字符串
        [db executeUpdate:@"create table if not exists easytNote (id integer primary key autoincrement,idStr text,title text,content text,collect BOOLEAN, addTime text);"];
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
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd";
        NSString *addTime = [fmt stringFromDate:[NSDate date]];
        result = [db executeUpdate:@"insert into easytNote (idStr, title, content, addTime) values(?,?,?,?)",idStr, model.title, model.content,addTime];
        if (result) {
            [HUDTools showSuccess:@"保存成功"];
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
       result = [db executeUpdate:@"delete easytNote where idStr = ?", idStr];
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
        result = [db executeUpdate:@"update easytNote set title = ?, content = ?addTime = ?  where idStr = ?",  model.title, model.content,model.addTime,idStr];
        if (result) {
            [HUDTools showSuccess:@"保存成功"];
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
        rs = [db executeQuery:@"select * from easytNote order by id desc;"];
        while (rs.next) {
            NoteModel *model = [[NoteModel alloc]init];
            model.idStr = [rs stringForColumn:@"idStr"];
            model.title = [rs stringForColumn:@"title"];
            model.content = [rs stringForColumn:@"content"];
            model.addTime = [rs stringForColumn:@"addTime"];
            [array addObject:model];
        }
    }];
    // 3.返回数据
    return array;
}



#if 0
+(BOOL)addNoteWithNoteModel:(NoteModel *)model idStr:(NSString *)idStr
{
    __block BOOL result;
    [_queue inDatabase:^(FMDatabase *db) {
        // 2.存储数据
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd";
        NSString *addTime = [fmt stringFromDate:[NSDate new]];
        result = [db executeUpdate:@"insert into easytNote (idStr, title, content, addTime) values(?,?,?,?)",idStr, model.title, model.content,addTime];
        if (result) {
            [HUDTools showSuccess:@"保存成功"];
        }else{
            [HUDTools showError:@"保存失败"];
        }
    }];
    return result;
}
+(void)delNoteWithIdStr:(NSString *)idStr
{
    [_queue inDatabase:^(FMDatabase *db) {
        // 2.存储数据
        [db executeUpdate:@"delete easytNote where idStr = ?", idStr];
    }];
}
+(NSArray *)getNoteWithDate:(NSString *)dateStr
{
    // 1.定义数组
    __block NSMutableArray *array = nil;
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        array = [NSMutableArray array];
        
        FMResultSet *rs = nil;
 
        rs = [db executeQuery:@"select * from easytNote where addTime = ? order by id desc;",dateStr];
        while (rs.next) {
//            idStr text,title text,content text,book text,location text,collect integer, addTime timestamp, modifyTime timestamp
            NoteModel *model = [[NoteModel alloc]init];
            NSString *idStr = [rs stringForColumn:@"idStr"];
            NSString *title = [rs stringForColumn:@"title"];
            NSString *content = [rs stringForColumn:@"content"];
            NSString *book = [rs stringForColumn:@"book"];
            NSString *location = [rs stringForColumn:@"location"];
            BOOL collect = [rs boolForColumn:@"collect"];
            NSString *addTime = [rs stringForColumn:@"addTime"];
            NSString *modifyTime = [rs stringForColumn:@"modifyTime"];
            model.idStr = idStr ;
            model.title = title;
            model.content = content;
            model.book = book;
            model.location = location;
            model.collect = collect;
            model.addTime = addTime;
            model.modifyTime = modifyTime;
            [array addObject:model];
         }
    }];
    // 3.返回数据
    return array;
}
+(NSArray *)getAllNote
{
    // 1.定义数组
    __block NSMutableArray *array = nil;
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        array = [NSMutableArray array];
        
        FMResultSet *rs = nil;
        
        rs = [db executeQuery:@"select * from easytNote order by id desc;"];
        while (rs.next) {
            //            idStr text,title text,content text,book text,location text,collect integer, addTime timestamp, modifyTime timestamp
            NoteModel *model = [[NoteModel alloc]init];
            NSString *idStr = [rs stringForColumn:@"idStr"];
            NSString *title = [rs stringForColumn:@"title"];
            NSString *content = [rs stringForColumn:@"content"];
            NSString *book = [rs stringForColumn:@"book"];
            NSString *location = [rs stringForColumn:@"location"];
            BOOL collect = [rs boolForColumn:@"collect"];
            NSString *addTime = [rs stringForColumn:@"addTime"];
            NSString *modifyTime = [rs stringForColumn:@"modifyTime"];
            model.idStr = idStr ;
            model.title = title;
            model.content = content;
            model.book = book;
            model.location = location;
            model.collect = collect;
            model.addTime = addTime;
            model.modifyTime = modifyTime;
            [array addObject:model];
        }
    }];
    // 3.返回数据
    return array;
}

+(int)getAllNoteCount
{
    __block int count = 0;
    [_queue inDatabase:^(FMDatabase *db) {
       count = [db intForQuery:@"select count(idStr) from easytNote "];
    }];
    return count  ;
}
+(int)getAllNoteCollectedCount
{
    __block int count = 0;
    [_queue inDatabase:^(FMDatabase *db) {
        count = [db intForQuery:@"select count(idStr) from easytNote where collect = 1 "];
    }];
    return count ;
}

+(NSArray *)getAllLocations
{
    __block NSMutableArray *array = nil;
    [_queue inDatabase:^(FMDatabase *db) {
        array = [NSMutableArray array];
        FMResultSet *rs = nil;
        rs = [db executeQuery:@"select distinct location from easytNote order by id desc;"];
        while (rs.next) {
            NSString *location = [rs stringForColumn:@"location"];
            if (location != nil) {
                [array addObject:location];
            }
        }
    }];
    // 3.返回数据
    return array;
}

+(NSArray *)getAllNoteIfCollect:(BOOL)isCollect
{
    __block NSMutableArray *array = nil;
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        array = [NSMutableArray array];
        
        FMResultSet *rs = nil;
        
        rs = [db executeQuery:@"select * from easytNote where collect = ? order by id desc;",@(isCollect)];
        while (rs.next) {
            //            idStr text,title text,content text,book text,location text,collect integer, addTime timestamp, modifyTime timestamp
            NoteModel *model = [[NoteModel alloc]init];
            NSString *idStr = [rs stringForColumn:@"idStr"];
            NSString *title = [rs stringForColumn:@"title"];
            NSString *content = [rs stringForColumn:@"content"];
            NSString *book = [rs stringForColumn:@"book"];
            NSString *location = [rs stringForColumn:@"location"];
            BOOL collect = [rs boolForColumn:@"collect"];
            NSString *addTime = [rs stringForColumn:@"addTime"];
            NSString *modifyTime = [rs stringForColumn:@"modifyTime"];
            model.idStr = idStr ;
            model.title = title;
            model.content = content;
            model.book = book;
            model.location = location;
            model.collect = collect;
            model.addTime = addTime;
            model.modifyTime = modifyTime;
            [array addObject:model];
        }
    }];
    // 3.返回数据
    return array;

}

+(BOOL)modifyNoteWithNoteModel:(NoteModel *)model idStr:(NSString *)idStr
{
    __block BOOL result;
    [_queue inDatabase:^(FMDatabase *db) {
        // 2.存储数据
        NSLog(@"date:%@",[NSDate new]);
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd";
 
        NSString *addTime = [fmt stringFromDate:[NSDate new]];
        result = [db executeUpdate:@"update easytNote set title = ?, content = ?,book = ?,collect = ?,location=?, addTime = ?  where idStr = ?",  model.title, model.content,model.book,@(model.collect),model.location,addTime,idStr];
        if (result) {
            [HUDTools showSuccess:@"保存成功"];
        }else{
            [HUDTools showError:@"保存失败"];
        }
    }];
    return result;
}

+(BOOL)addNoteMarkWithNoteModel:(NoteMarkModel *)model idStr:(NSString *)idStr
{
    __block BOOL result;
    [_queue inDatabase:^(FMDatabase *db) {
        // 2.存储数据
 
        //拆分mark
        NSString *marks = model.mark;
        NSMutableArray *markArray = [NSMutableArray array];
        if ([marks containsString:@","]) {
           NSArray *array = [marks componentsSeparatedByString:@","];
            [markArray addObjectsFromArray:array];
        }
        for (NSString *mark in markArray) {
            result = [db executeUpdate:@"insert into smartMark (idStr,mark) values(?,?)",idStr, mark];
        }
        if (result) {
            [HUDTools showSuccess:@"保存成功"];
        }else{
            [HUDTools showError:@"保存失败"];
        }
    }];
    return result;
}
+(void)delNoteMarkWithIdStr:(NSString *)idStr mark:(NSString *)mark
{
    [_queue inDatabase:^(FMDatabase *db) {
        // 2.存储数据
        [db executeUpdate:@"delete smartMark where idStr = ? and mark = ?",idStr, mark];
    }];
}
+(void)modifyNoteMarkWithNoteModel:(NoteMarkModel *)model
{

}

+(NSArray *)getAllNoteMarks
{
    __block NSMutableArray *array = nil;
    [_queue inDatabase:^(FMDatabase *db) {
        array = [NSMutableArray array];
        FMResultSet *rs = nil;
        rs = [db executeQuery:@"select distinct mark from smartMark order by id desc;"];
        while (rs.next) {
            NSString *mark = [rs stringForColumn:@"mark"];
            [array addObject:mark];
        }
    }];
    return array;
}
+(int)getAllNoteMarksCount
{
    __block int count = 0;
    [_queue inDatabase:^(FMDatabase *db) {
        count = [db intForQuery:@"select count(idStr) from smartMark;"];
    }];
    return count  ;
}

/********* 笔记本 *************/
+(BOOL)addBookWithBookName:(NSString *)bookName
{
    __block BOOL result;
    [_queue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:@"insert into smartBook (bookName) values(?)",bookName];
        if (result) {
//            [HUDTools showSuccess:@"保存成功"];
        }else{
            [HUDTools showError:@"新建笔记本失败"];
        }
    }];
    return result;

}
+(void)delBookWithBookName:(NSString *)bookName
{
    [_queue inDatabase:^(FMDatabase *db) {
        // 2.存储数据
        [db executeUpdate:@"delete from smartBook where bookName = ?",bookName];
        
        //笔记easytNote表更新
        BOOL result =[db executeUpdate:@"update easytNote set book = '' where book = ?;",bookName];
        NSLog(@"---");
    }];
}
+(void)modifyBookWithBookName:(NSString *)bookName
{

}
 
+(NSArray *)getAllBooks
{
    __block NSMutableArray *array = nil;
    
    [_queue inDatabase:^(FMDatabase *db) {
        array = [NSMutableArray array];
        FMResultSet *rs = nil;
        rs = [db executeQuery:@"select * from smartBook order by id asc;"];
        while (rs.next) {
            NSString *bookName = [rs stringForColumn:@"bookName"];
            int bookCount = [db intForQuery:@"select count(book) from easytNote where book = ?;",bookName];
            NoteBookModel *model = [NoteBookModel noteBookWithBookName:bookName bookCount:bookCount];
            [array addObject:model];
        }
    }];
    return array;
}

+(int)getAllBooksCount
{
    __block int count = 0;
    [_queue inDatabase:^(FMDatabase *db) {
        count = [db intForQuery:@"select count(bookName) from smartBook;"];
    }];
    return count  ;
}
#endif

@end
