//
//  NSObject+AOP.h
//  TOPOA
//
//  Created by Gavin on 2017/6/9.
//  Copyright © 2017年 lamkhun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AOP)

/** 0 未下载  1已下载 **/
@property (nonatomic, strong) NSString *LK_download;
+(NSString*)dateToStringWithDate:(NSDate*)date;
+(NSDate*)stringToDateWithString:(NSString*)dateString;
@end
