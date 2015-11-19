//
//  NADateFormatter.h
//  NACommon
//
//  Created by  on 3/27/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @author , 15-03-27 11:03:42
 *
 *  日期格式化
 */
@interface NADateFormatter : NSObject

/**
 *  @author , 15-03-27 11:03:16
 *
 *  格式化(yyyy-MM-dd)日期为字符串
 *
 *  @param date 日期
 *
 *  @return 字符串
 */
+ (NSString *)stringWithDate:(NSDate *)date;
/**
 *  @author , 15-03-27 11:03:45
 *
 *  通过制定的格式格式化日期
 *
 *  @param date   日期
 *  @param format 格式
 *
 *  @return 字符串
 */
+ (NSString *)stringWithDate:(NSDate *)date withFormat:(NSString *)format;
/**
 *  @author , 15-03-27 11:03:40
 *
 *  格式化日期为友好格式，当天显示时间，本年显示月、日，时间，跨年显示年、月、日
 *
 *  @param date 日期
 *
 *  @return 字符串
 */
+ (NSString *)stringFriendlyWithDate:(NSDate *)date;
/**
 *  @author , 15-03-27 13:03:02
 *
 *  格式化日期为友好格式，分别为当天时间、昨天、星期几、月日、年月日
 *
 *  @param date 日期
 *
 *  @return 字符串
 */
+ (NSString*)stringFriendlyWeekWithDate:(NSDate *)date;
/**
 *  @author , 15-03-27 13:03:02
 *
 *  格式化日期为友好格式，分别为当天时间、昨天、星期几、月日、年月日
 *
 *  @param date 日期
 *
 *  @return 字符串
 */
+ (NSString*)stringFriendly2WeekWithDate:(NSDate *)date;
/**
 *  @author , 15-03-27 20:03:49
 *
 *  根据距离0点0分的秒数计算时分字符串，如08:00
 *
 *  @param secondCount 秒数
 *
 *  @return 字符串
 */
+ (NSString *)stringTimeWithSecondCount:(int)secondCount;
/**
 *  @author , 15-03-27 11:03:22
 *
 *  转化(yyyy-MM-dd)字符串为日期
 *
 *  @param string (yyyy-MM-dd)字符串
 *
 *  @return 日期
 */
+ (NSDate *)dateWithString:(NSString *)string;
/**
 *  @author , 15-03-27 11:03:17
 *
 *  转化指定格式的字符串为日期
 *
 *  @param string 字符串
 *  @param format 格式
 *
 *  @return 日期
 */
+ (NSDate *)dateWithString:(NSString *)string format:(NSString *)format;
/**
 *  @author , 15-03-27 11:03:13
 *
 *  获取两个日期间的间隔天数
 *
 *  @param date1 日期1
 *  @param date2 日期2
 *
 *  @return 天数
 */
+ (int)daysBetweenDate1:(NSDate *)date1 andDate2:(NSDate *)date2;
/**
 *  @author , 15-03-27 11:03:52
 *
 *  判断日期是否在本周
 *
 *  @param date 日期
 *
 *  @return 是否
 */
+ (BOOL)inThisWeekWithDate:(NSDate *)date;

@end
