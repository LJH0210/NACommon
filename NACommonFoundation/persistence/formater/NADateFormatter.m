//
//  NADateFormatter.m
//  NACommon
//
//  Created by  on 3/27/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import "NADateFormatter.h"

@implementation NADateFormatter

+ (NSString *)stringWithDate:(NSDate *)date {
    if (nil == date) {
        return nil;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *stringDate = [dateFormatter stringFromDate:date];
    return stringDate;
}

+ (NSString *)stringWithDate:(NSDate *)date withFormat:(NSString *)format
{
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    [formater setDateFormat:format];
    NSString *strdate = [formater stringFromDate:date];
    return strdate;
}

+ (NSString *)stringFriendlyWithDate:(NSDate *)date {
    if (nil == date) {
        return nil;
    }
    
    NSString *retString = nil;
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:unitFlags fromDate:date];
    NSDateComponents *todayComponents = [[NSCalendar currentCalendar] components:unitFlags fromDate:[NSDate date]];
    
    if ([dateComponents day] == [todayComponents day] &&
        [dateComponents month] == [todayComponents month] &&
        [dateComponents year] == [todayComponents year]) {
        retString = [NSString stringWithFormat:@"%02ld:%02ld", (long)[dateComponents hour], (long)[dateComponents minute]];
    } else {
        if ([dateComponents year] != [todayComponents year]) {
            retString = [NSString stringWithFormat:@"%ld年%ld月%ld日", (long)[dateComponents year], (long)[dateComponents month], (long)[dateComponents day]];
        } else {
            retString = [NSString stringWithFormat:@"%ld月%ld日 %02ld:%02ld", (long)[dateComponents month], (long)[dateComponents day], (long)[dateComponents hour], (long)[dateComponents minute]];
        }
    }
    
    return retString;
}

+ (NSString*)stringFriendlyWeekWithDate:(NSDate *)date {
    if (nil == date) {
        return nil;
    }
    
    NSString* retString = nil;
    unsigned unitFlags = NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:unitFlags fromDate:date];
    NSDateComponents *todayComponents = [[NSCalendar currentCalendar] components:unitFlags fromDate:[NSDate date]];
    
    if ([dateComponents day] == [todayComponents day] &&
        [dateComponents month] == [todayComponents month] &&
        [dateComponents year] == [todayComponents year]) {
        retString = [NSString stringWithFormat:@"%02ld:%02ld", (long)[dateComponents hour], (long)[dateComponents minute]];
    }
    else if ([self inThisWeekWithDate:date]){
        if (fabs([date timeIntervalSinceDate:[NSDate date]]) < 24*60*60) {
            retString = [NSString stringWithFormat:@"昨天"];
        }else{
            switch ([dateComponents weekday]) {
                case 1:
                    retString = [NSString stringWithFormat:@"星期天"];
                    break;
                case 2:
                    retString = [NSString stringWithFormat:@"星期一"];
                    break;
                case 3:
                    retString = [NSString stringWithFormat:@"星期二"];
                    break;
                case 4:
                    retString = [NSString stringWithFormat:@"星期三"];
                    break;
                case 5:
                    retString = [NSString stringWithFormat:@"星期四"];
                    break;
                case 6:
                    retString = [NSString stringWithFormat:@"星期五"];
                    break;
                case 7:
                    retString = [NSString stringWithFormat:@"星期六"];
                    break;
                default:
                    break;
            }
        }
        retString = [retString stringByAppendingFormat:@" %02ld:%02ld", (long)[dateComponents hour], (long)[dateComponents minute]];
    }
    else {
        if ([dateComponents year] != [todayComponents year]) {
            retString = [NSString stringWithFormat:@"%ld年%ld月%ld日", (long)[dateComponents year], (long)[dateComponents month], (long)[dateComponents day]];
        } else {
            retString = [NSString stringWithFormat:@"%ld月%ld日", (long)[dateComponents month], (long)[dateComponents day]];
        }
    }
    
    return retString;
}

+ (NSString *)stringFriendly2WeekWithDate:(NSDate *)date {
    if (nil == date) {
        return nil;
    }
    
    NSString* retString = nil;
    unsigned unitFlags = NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:unitFlags fromDate:date];
    NSDateComponents *todayComponents = [[NSCalendar currentCalendar] components:unitFlags fromDate:[NSDate date]];
    
    if ([dateComponents day] == [todayComponents day] &&
        [dateComponents month] == [todayComponents month] &&
        [dateComponents year] == [todayComponents year]) {
        retString = @"今天";
    }
    else  {
        NSTimeInterval timeInterval = [date timeIntervalSinceDate:[NSDate date]];
        if (timeInterval > -24*60*60*2 && timeInterval < -24*60*60) {
            retString = [NSString stringWithFormat:@"昨天"];
        }else if (timeInterval>0 && timeInterval < 24*60*60) {
            retString = [NSString stringWithFormat:@"明天"];
        }else{
            switch ([dateComponents weekday]) {
                case 1:
                    retString = [NSString stringWithFormat:@"星期天"];
                    break;
                case 2:
                    retString = [NSString stringWithFormat:@"星期一"];
                    break;
                case 3:
                    retString = [NSString stringWithFormat:@"星期二"];
                    break;
                case 4:
                    retString = [NSString stringWithFormat:@"星期三"];
                    break;
                case 5:
                    retString = [NSString stringWithFormat:@"星期四"];
                    break;
                case 6:
                    retString = [NSString stringWithFormat:@"星期五"];
                    break;
                case 7:
                    retString = [NSString stringWithFormat:@"星期六"];
                    break;
                default:
                    break;
            }
        }
    }
    
    return retString;
}

+ (NSString *)stringTimeWithSecondCount:(int)secondCount {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *offsetComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                                     fromDate:[NSDate date]];
    NSDate *midnight = [calendar dateFromComponents:offsetComponents];
    NSDate *dateRet = [[NSDate alloc]initWithTimeInterval:secondCount sinceDate:midnight];
    return [self stringWithDate:dateRet withFormat:@"HH:mm"];
}

+ (NSDate *)dateWithString:(NSString *)string {
    if (0 == string.length){
        return nil;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [dateFormatter dateFromString:string];
    return date;
}

+ (NSDate *)dateWithString:(NSString *)string format:(NSString *)format {
    if (0 == string.length){
        return nil;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    NSDate *date = [dateFormatter dateFromString:string];
    return date;
}

+ (int)daysBetweenDate1:(NSDate *)date1 andDate2:(NSDate *)date2 {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned int unitFlags = NSCalendarUnitDay;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date1 toDate:date2 options:0];
    
    return (int)[comps day];
}

+ (BOOL)inThisWeekWithDate:(NSDate *)date {
    NSDate *start;
    NSTimeInterval extends;
    
    NSCalendar *cal=[NSCalendar currentCalendar];
    NSDate *today=[NSDate date];
    
    BOOL success= [cal rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&start interval: &extends forDate:today];
    
    if(!success)
        return NO;
    
    NSTimeInterval dateInSecs = [date timeIntervalSinceReferenceDate];
    NSTimeInterval dayStartInSecs= [start timeIntervalSinceReferenceDate];
    
    if(dateInSecs > dayStartInSecs && dateInSecs < (dayStartInSecs+extends)){
        return YES;
    }
    else {
        return NO;
    }
}

@end
