//
//  UIColor+NAKit.h
//  Common
//
//  Created by ND on 15/4/30.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

/**
 *  根据十六进制字符串创建UIColor ： #36a9e0
 *
 *  @param hexString HEX string
 *
 *  @return UIColor实例
 */
+ (UIColor *)NA_colorWithHexString:(NSString *)hexString;

/**
 *  根据十六进制创建UIColor ：0xE23400
 *
 *  @param hex HEX value
 *
 *  @return UIColor实例
 */
+ (UIColor *)NA_colorWithHex:(unsigned int)hex;

/**
 *  根据十六进制创建具有透明度的UIColor ：0xE23400
 *
 *  @param hex   HEX value
 *  @param alpha Alpha 透明度
 *
 *  @return UIColor实例
 */
+ (UIColor *)NA_colorWithHex:(unsigned int)hex alpha:(float)alpha;

/**
 *  根据RGB原色创建UIColor ： red/255.0
 *
 *  @param red    原色原子，既 red/255.0
 *  @param green  原色原子，既 green/255.0
 *  @param blue   原色原子，既 blue/255.0
 *  @param alpha
 *  @return UIColor实例
 */
+ (UIColor *)NA_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

@end
