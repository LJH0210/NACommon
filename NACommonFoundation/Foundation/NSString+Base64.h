//
//  NSString+Base64.h
//  NACommon
//
//  Created by ND on 15/6/17.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)

/**
 *  使用Base64加密输入字符串
 *
 *  @param string 需要加密的字符串
 *
 *  @return 加密后字符串
 */
+ (NSString *)NA_stringWithBase64EncodedString:(NSString *)string;
/**
 *  使用base64加密输入字符串
 *
 *  @param wrapWidth 需要加密的宽度
 *
 *  @return 加密后字符串
 */
- (NSString *)NA_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
/**
 *  使用base64加密self字符串
 *
 *  @return 加密后字符串
 */
- (NSString *)NA_base64EncodedString;
/**
 *  解密base64字符串
 *
 *  @return 解密后base64字符串
 */
- (NSString *)NA_base64DecodedString;

/**
 *  解密base64字符串
 *
 *  @return 解密后的NSData对象
 */
- (NSData *)NA_base64DecodedData;

@end
