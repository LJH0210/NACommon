//
//  NSDate+NAKit.h
//  Common
//
//  Created by ND on 15/4/30.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import <Foundation/Foundation.h>

struct NADateInformation {
    NSInteger day;
    NSInteger month;
    NSInteger year;
    NSInteger weekday;
    NSInteger minute;
    NSInteger hour;
    NSInteger second;
};
typedef struct NADateInformation NADateInformation;

@interface NSDate (NAFoundation)

/**
 *  返回当前月一共有几周(可能为4,5,6)
 */
- (int)NA_getWeekNumOfMonth;

/**
 *  返回day天后的日期(若day为负数,则为|day|天前的日期)
 *
 *  @param day 返回day天后的日期(若day为负数,则为|day|天前的日期)
 *
 */
- (NSDate *)NA_dateAfterDay:(int)day;

/**
 *  获取昨天日期NSDate对象
 *
 *  @return 昨天NSDate对象
 */
+ (NSDate *)NA_yesterday;

/**
 *  NSString 转 NSDate
 *
 *  @param stringDate 日期string
 *  @param format     日期格式
 *
 *  @return NSDate
 */
+ (NSDate *)NA_dateWithSting:(NSString *)stringDate dateFormat:(NSString *)format;

/**
 *  NSDate 转 NSString
 *
 *  @param date   nsdate日期
 *  @param format 返回日期格式
 *
 *  @return return value description
 */
+ (NSString *)NA_stingWithDate:(NSDate *)date dateFormat:(NSString *)format;

/**
 *  判断self和anotherDate是否是同一天
 *
 *  @param anotherDate 需要比较的日期
 *
 *  @return yes:同一天  no：不同天
 */

- (BOOL)NA_isSameDay:(NSDate *)anotherDate;

/**
 *  判断self 是否是今天
 *
 *  @return
 */
- (BOOL)NA_isToday;

/**
 *  获取self的NADateInformation信息结构体
 *
 *  @return NADateInformation
 */
- (NADateInformation)NA_dateInformation;

@end
