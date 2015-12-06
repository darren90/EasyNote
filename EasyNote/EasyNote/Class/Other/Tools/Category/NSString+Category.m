//
//  NSString+Category.m
//  SmartNote
//
//  Created by Tengfei on 15/9/12.
//  Copyright (c) 2015年 ftf. All rights reserved.
//

#import "NSString+Category.h"

#import <CommonCrypto/CommonDigest.h>

//私钥，更强加密
static NSString *token = @"sdf@@asdasdasd@%%%sdf";

@implementation NSString (Category)

- (NSString *)myMD5
{
    NSString *str = [NSString stringWithFormat:@"%@%@", self, token];
    
    return [str MD5];
}

#pragma mark 使用MD5加密字符串
- (NSString *)MD5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

+(NSString *)idStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *strDate = [dateFormatter stringFromDate:[NSDate new]];
    NSString *idStr = [strDate myMD5];
    
    return idStr;
}

+(NSString *)getTime
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *addTime = [fmt stringFromDate:[NSDate new]];
    return addTime;
}

@end
