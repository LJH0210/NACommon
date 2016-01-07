//
//  NSDate+NAKit.m
//  Common
//
//  Created by ND on 15/4/30.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import "NSDate+NAFoundation.h"

@implementation NSDate (NAFoundation)

//返回当前天的年月日.
- (NSDate *)beginningOfDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)fromDate:self];
    return [calendar dateFromComponents:components];
}

+ (NSDate *)na_yesterday {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond)fromDate:[NSDate date]];
    [components setHour:-[components hour]];
    [components setMinute:-[components minute]];
    [components setSecond:-[components second]];
    NSDate *today = [cal dateByAddingComponents:components
                                         toDate:[[NSDate alloc] init]
                                        options:0]; // This variable should now be pointing at a date object that is the start of today (midnight);
    [components setHour:-24];
    [components setMinute:0];
    [components setSecond:0];
    NSDate *yesterday = [cal dateByAddingComponents:components toDate:today options:0];
    return yesterday;
}

//返回当前月一共有几周(可能为4,5,6)
- (int)na_getWeekNumOfMonth {
    return [[self endOfMonth] getWeekOfYear] - [[self beginningOfMonth] getWeekOfYear] + 1;
}

//该日期是该年的第几周
- (int)getWeekOfYear {
    int i;
    int year = [self getYear];
    NSDate *date = [self endOfWeek];
    for (i = 1;[[date na_dateAfterDay:-7 * i] getYear] == year; i++) {
    }
    return i;
}

//返回当前周的周末
- (NSDate *)endOfWeek {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    [componentsToAdd setDay:(7 - [weekdayComponents weekday])];
    NSDate *endOfWeek = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];

    return endOfWeek;
}

//获取日
- (int)getDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit)fromDate:self];
    return (int)[dayComponents day];
}

//获取年
- (int)getYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit)fromDate:self];
    return (int)[dayComponents year];
}

//该月的最后一天
- (NSDate *)endOfMonth {
    return [[[self beginningOfMonth] dateafterMonth:1] na_dateAfterDay:-1];
}

//返回该月的第一天
- (NSDate *)beginningOfMonth {
    return [self na_dateAfterDay:-[self getDay] + 1];
}

//返回day天后的日期(若day为负数,则为|day|天前的日期)
- (NSDate *)na_dateAfterDay:(int)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    // NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    [componentsToAdd setDay:day];
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    return dateAfterDay;
}

+ (NSDate *)na_dateWithSting:(NSString *)stringDate dateFormat:(NSString *)format {
    if ((nil == stringDate) || (0 == stringDate.length) || format == nil || format.length == 0) {
        return nil;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:format];

    NSDate *date = [dateFormatter dateFromString:stringDate];
    return date;
}

+ (NSString *)na_stingWithDate:(NSDate *)date dateFormat:(NSString *)format {
    if (nil == date || nil == format) {
        return nil;
    }

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:format];

    NSString *stringDate = [dateFormatter stringFromDate:date];
    return stringDate;
}

- (BOOL)na_isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)fromDate:anotherDate];
    return ([components1 year] == [components2 year] && [components1 month] == [components2 month] && [components1 day] == [components2 day]);
}

- (BOOL)na_isToday {
    return [self na_isSameDay:[NSDate date]];
}

- (NADateInformation)_dateInformation {
    NADateInformation info;

    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [gregorian components:(NSCalendarUnitMonth | NSCalendarUnitMinute | NSCalendarUnitYear | NSCalendarUnitDay |
                                                    NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitSecond)
                                          fromDate:self];
    info.day = [comp day];
    info.month = [comp month];
    info.year = [comp year];

    info.hour = [comp hour];
    info.minute = [comp minute];
    info.second = [comp second];

    info.weekday = [comp weekday];

    return info;
}

// month个月后的日期
- (NSDate *)dateafterMonth:(int)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];

    return dateAfterMonth;
}
@end
