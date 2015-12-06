//
//  NSString+Category.h
//  SmartNote
//
//  Created by Tengfei on 15/9/12.
//  Copyright (c) 2015年 ftf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)
/**
 *  加有私钥，更强加密
 *
 *  @return 32位MD5加密结果
 */
- (NSString *)myMD5;

/**
 *  32位MD5加密
 *
 *  @return 32位MD5加密结果
 */
- (NSString *)MD5;

/**
 *  生成本程序中的保存数据库的主键
 *
 *  @return 主键
 */
+(NSString *)idStr;
@end
