//
//  NSObject+AOP.m
//  TOPOA
//
//  Created by Gavin on 2017/6/9.
//  Copyright © 2017年 Gavin. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+AOP.h"

@implementation NSObject (AOP)

#pragma mark 运行中增加对象属性
- (NSString *)LK_download {
    return  objc_getAssociatedObject(self, @selector(LK_download));
}

- (void)setLK_download:(NSString *)LK_download {
    objc_setAssociatedObject(self, @selector(LK_download), LK_download, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+(NSString*)dateToStringWithDate:(NSDate*)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    NSString  *time = [recommendTalentsModel.submitdate substringToIndex:19];
    //传入的time一定要大于等于19位,否则不能解析
    //    NSDate *date = [NSDate date];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
//    NSDate *date = [formatter dateFromString:time];
    NSString *str = [formatter stringFromDate:date];
    return str;
}

+(NSDate*)stringToDateWithString:(NSString*)dateString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSLog(@"长度是是%ld",dateString.length);
        NSString  *time = [dateString substringToIndex:19];
    //传入的time一定要大于等于19位,否则不能解析
    //    NSDate *date = [NSDate date];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        NSDate *date = [formatter dateFromString:time];
//    NSString *str = [formatter stringFromDate:date];
    return date;
}

@end
