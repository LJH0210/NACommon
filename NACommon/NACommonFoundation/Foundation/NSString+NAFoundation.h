//
//  NSString+NAKit.h
//  Common
//
//  Created by ND on 15/4/30.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (NAFoundation)

/**
 *  判断NSString对象是否为空：nil、@""、NSNull
 *
 *  @param NSString对象
 *
 *  @return YES：string为空 NO：不为空
 */
+ (BOOL)NA_isEmptyString:(NSString *)string;

/**
 *  字符串为空时显示默认值
 *
 *  @param inputString 判定字符串
 *  @param defaul      默认显示字符串
 *
 *  @return 返回判定后显示的字符串
 */
+ (NSString *)NA_retNotEmptyString:(NSString *)inputString defaultString:(NSString *)defaul;

/**
 *  判断NSString对象self是否有包含astring，系统containString为iOS8 SDK
 *
 *  @param aString
 *
 *  @return YES：包含字符串astring NO:不包含
 */
- (BOOL)NA_containString:(NSString *)aString;
/**
 *  判断是否是合法手机号
 *
 *  @return YES：满足手机号格式  NO：不满足
 */
- (BOOL)NA_isValidateMobile;

/**
 *  根据字体和宽度计算NSString展示高度
 *
 *  @param width 限制宽度
 *  @param font  限制字体
 *
 *  @return 限制高度
 */
- (CGFloat)NA_countHeighWithWidth:(int)width font:(UIFont *)font;
/**
 *  计算大小
 *
 *  @param font        字体
 *  @param containSize 容器大小
 *  @param mode        分隔模式
 *
 *  @return 字体面积
 */
- (CGSize)NA_commonSizeWithFont:(UIFont *)font containSize:(CGSize)containSize lineBreakMode:(NSLineBreakMode)mode;

/**
 *  判断self是否满足email格式
 *
 *  @return Return YES ：是email  NO：不是email
 */
- (BOOL)NA_isEmail;

/**
 *  判断输入string是否满足email格式
 *
 *  @param email 输入字符串
 *
 *  @return Return YES if it's an email, NO if not
 */
+ (BOOL)NA_isEmail:(NSString *)email;

/**
 *  是否包含emoji表情符号
 *
 *
 *  @return YES：包含emoji表情
 */
- (BOOL)NA_isContainsEmoji;

#pragma mark APP INFO
/**
 *  @author , 15-04-07 16:04:32
 *
 *  iOS App内部版本号
 *
 *  @return 内部版本号
 */
+ (NSString *)NA_innerVersion;

/**
 *  @author , 15-04-07 16:04:48
 *
 *  iOS App外部版本号
 *
 *  @return 外部版本号
 */
+ (NSString *)NA_outerVersion;

/**
 *  @author , 15-08-24 18:08:09
 *
 *  iOS App显示名称
 *
 *  @return app显示名称
 */
+ (NSString *)NA_appDisplayName;

@end
