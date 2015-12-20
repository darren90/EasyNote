//
//  EasyNoteTools.m
//  EasyNote
//
//  Created by Tengfei on 15/12/20.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "EasyNoteTools.h"
#import "FMDBTool.h"

@implementation EasyNoteTools

+(BOOL)isHadNewVersion
{
    //取出沙盒中存储的上一次使用的版本号
    //    NSString *key = @"CFBundleVersion";//build
    NSString *key = @"CFBundleShortVersionString";//version
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    
    //获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if([currentVersion isEqualToString:lastVersion]){
        
        return NO;
    }else{//新版本
        
        //存储新版本
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
        
        return YES;
    }
}

+(void)isNewVersion
{
    //取出沙盒中存储的上一次使用的版本号
    //    NSString *key = @"CFBundleVersion";//build
    NSString *key = @"CFBundleShortVersionString";//version
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    
    //获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if([currentVersion isEqualToString:lastVersion]){
        
    }else{//新版本
        
        //存储新版本
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
}



+(void)deleCompatible
{
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask , YES) firstObject];
    NSString* path = [NSString stringWithFormat:@"%@/Downloads",cachesPath];
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    path = [NSString stringWithFormat:@"%@/rrmj.sqlite",cachesPath];
    BOOL result = [mgr fileExistsAtPath:path];
    if (result) {
        [FMDBTool getAllNotes];
    }
}




@end
