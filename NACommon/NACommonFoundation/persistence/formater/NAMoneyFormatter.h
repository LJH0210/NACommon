//
//  NADataFormatter.h
//  NACommon
//
//  Created by  on 3/14/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 货币类型
 */
typedef NS_ENUM(NSInteger, NAMoneySymbolType) {
    NAMoneySymbolTypeRMB = 1,
    NAMoneySymbolTypeDollar
};

/**
 *  @author , 15-03-27 11:03:12
 *
 *  金额格式化
 */
@interface NAMoneyFormatter : NSObject

/**
 *  @author , 15-03-25 16:03:13
 *
 *  保留金额的小数点后两位
 *
 *  @param fvalue 金额
 *
 *  @return 金额
 */
+ (double)moneyWithCGFloat:(double)fvalue;
+ (double)moneyWithNSString:(NSString *)string;
+ (NSString *)stringOfMoneyWithCGFloat:(double)fvalue;
+ (NSString *)stringOfMoneyWithNSString:(NSString *)string;
+ (NSString *)symbolWithType:(NAMoneySymbolType)type;
+ (NSString *)symbol;
+ (NSString *)stringOfMoneySymbolWithCGFloat:(double)fvalue;
+ (NSString *)stringOfMoneySymbolWithNSString:(NSString *)string;
+ (NSString *)stringOfMoneyRMBInEndWithCGFloat:(double)fvalue;
+ (NSString *)stringOfMoneyRMBInEndWithNSString:(NSString *)string;

@end
