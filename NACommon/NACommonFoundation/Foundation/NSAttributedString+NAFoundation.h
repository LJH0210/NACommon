//
//  NSAttributedString+NAFoundation.h
//  NACommon
//
//  Created by ND on 15/6/12.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (NAFoundation)

/**
 *  创建二段式NSAttributedString
 *
 *  @param leftIndentify 左侧字符串
 *  @param leftFont      左侧字符串字体
 *  @param leftColor     左侧字符串颜色
 *  @param string        右侧字符串
 *  @param stringFont    右侧字符串字体
 *  @param stringColor   右侧字符串颜色
 *
 *  @return NSAttributedString对象
 */
+ (NSAttributedString *)na_attribuedStringWithleftIndentify:(NSString *)leftIndentify
                                                    leftFont:(UIFont *)leftFont
                                                   leftColor:(UIColor *)leftColor
                                                      String:(NSString *)string
                                                  stringFont:(UIFont *)stringFont
                                                 stringColor:(UIColor *)stringColor;

/**
 *  创建三段式NSAttributedString
 *
 *  @param leftIndentify 左侧字符串
 *  @param leftFont      左侧字符串字体
 *  @param leftColor     左侧字符串颜色
 *  @param string        中间字符串
 *  @param stringFont    中间字符串字体
 *  @param stringColor   中间字符串颜色
 *  @param rightIndentify 右侧字符串
 *  @param rightFont      右侧字符串字体
 *  @param rightColor     右侧字符串颜色
 *
 *  @return NSAttributedString
 */
+ (NSAttributedString *)na_attribuedStringWithLeftIndentify:(NSString *)leftIndentify
                                                    leftFont:(UIFont *)leftFont
                                                   leftColor:(UIColor *)leftColor
                                                      string:(NSString *)string
                                                  stringFont:(UIFont *)stringFont
                                                 stringColor:(UIColor *)stringColor
                                              rightIndentify:(NSString *)rightIndentify
                                                   rightFont:(UIFont *)rightFont
                                                  rightColor:(UIColor *)rightColor;

@end
