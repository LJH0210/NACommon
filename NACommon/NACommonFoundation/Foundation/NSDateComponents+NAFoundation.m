//
//  NSDateComponents+NAFoundation.m
//  NACommon
//
//  Created by ND on 15/6/16.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NSDateComponents+NAFoundation.h"

@implementation NSDateComponents (NAFoundation)

+ (NSDateComponents *)na_calendarWithDate:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    return comps;
}

@end
