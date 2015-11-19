//
//  NADataFormatter.m
//  NACommon
//
//  Created by  on 3/14/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import "NAMoneyFormatter.h"

@implementation NAMoneyFormatter

+ (double)moneyWithCGFloat:(double)fvalue {
    return [[NSString stringWithFormat:@"%.2f",fvalue] doubleValue];
}

+ (double)moneyWithNSString:(NSString *)string {
    return [[NSString stringWithFormat:@"%.2f",[string doubleValue]] doubleValue];
}

+ (NSString *)stringOfMoneyWithCGFloat:(double)fvalue {
    return [NSString stringWithFormat:@"%.2f",fvalue];
}

+ (NSString *)stringOfMoneyWithNSString:(NSString *)string {
    return [NSString stringWithFormat:@"%.2f",[string doubleValue]];
}

+ (NSString *)symbolWithType:(NAMoneySymbolType)type {
    NSString *symbol = @"";
    switch (type) {
        case NAMoneySymbolTypeRMB:
            symbol = @"¥";
            break;
            
        case NAMoneySymbolTypeDollar:
            symbol = @"$";
            break;
            
        default:
            break;
    }
    
    return symbol;
}

+ (NSString *)symbol {
    return [self symbolWithType:NAMoneySymbolTypeRMB];
}

+ (NSString *)stringOfMoneySymbolWithCGFloat:(double)fvalue {
    return [NSString stringWithFormat:@"%@%.2f",[self symbol],fvalue];
}

+ (NSString *)stringOfMoneySymbolWithNSString:(NSString *)string {
    return [NSString stringWithFormat:@"%@%.2f",[self symbol],[string doubleValue]];
}

+ (NSString *)stringOfMoneyRMBInEndWithCGFloat:(double)fvalue {
    return [NSString stringWithFormat:@"%.2f元",fvalue];
}

+ (NSString *)stringOfMoneyRMBInEndWithNSString:(NSString *)string {
    return [NSString stringWithFormat:@"%.2f元",[string doubleValue]];
}

@end
