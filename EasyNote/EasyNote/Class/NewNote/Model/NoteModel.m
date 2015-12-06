//
//  NoteModel.m
//  EasyNote
//
//  Created by Tengfei on 15/12/6.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "NoteModel.h"

@implementation NoteModel
-(instancetype)initWithIdStr:(NSString *)idStr title:(NSString *)title content:(NSString *)content addTime:(NSString *)addTime
{
    if (self = [super init]) {
        self.idStr = idStr;
        self.title = title;
        self.content = content;
        self.addTime = addTime;
    }
    return self;
}

+(instancetype)noteWithIdStr:(NSString *)idStr title:(NSString *)title content:(NSString *)content addTime:(NSString *)addTime
{
    return [[self alloc]initWithIdStr:idStr title:title content:content addTime:addTime];
}
+(instancetype)noteWithIdStr:(NSString *)idStr title:(NSString *)title content:(NSString *)content
{
    return [[self alloc]initWithIdStr:idStr title:title content:content addTime:[NSString getTime]];
}
@end
