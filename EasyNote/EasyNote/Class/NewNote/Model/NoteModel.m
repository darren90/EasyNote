//
//  NoteModel.m
//  EasyNote
//
//  Created by Tengfei on 15/12/6.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "NoteModel.h"

@implementation NoteModel
-(instancetype)initWithIdStr:(NSString *)idStr title:(NSString *)title content:(NSString *)content addTime:(NSString *)addTime isSynched:(BOOL)isSynched
{
    if (self = [super init]) {
        self.idStr = idStr;
        self.title = title;
        self.content = content;
        self.addTime = addTime;
        self.isSynched = isSynched;
    }
    return self;
}

+(instancetype)noteWithIdStr:(NSString *)idStr title:(NSString *)title content:(NSString *)content addTime:(NSString *)addTime isSynched:(BOOL)isSynched
{
    return [[self alloc]initWithIdStr:idStr title:title content:content addTime:addTime isSynched:isSynched];
}

+(instancetype)noteWithIdStr:(NSString *)idStr title:(NSString *)title content:(NSString *)content
{
    return [[self alloc]initWithIdStr:idStr title:title content:content addTime:[NSString getTime] isSynched:NO];
}
@end
