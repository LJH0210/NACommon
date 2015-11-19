//
//  NAMobileFormatter.m
//  NACommon
//
//  Created by  on 3/27/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import "NAMobileFormatter.h"

@implementation NAMobileFormatter

+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    /**
     * 手机号码
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-9]|7[0-9]|8[0-9])\\d{8}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestphs evaluateWithObject:mobileNum] == YES)
        )
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
