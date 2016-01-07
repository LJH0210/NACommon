//
//  NSData+Base64.h
//  NACommon
//
//  Created by ND on 15/6/17.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Base64)

/**
 *  使用base64加密输入字符串
 *
 *  @param string 需要加密的字符串
 *
 *  @return 加密后NSData对象
 */
+ (NSData *)na_dataWithBase64EncodedString:(NSString *)string;
/**
 *  使用base64加密self
 *
 *  @param wrapWidth 加密宽度
 *
 *  @return 加密后NSString对象
 */
- (NSString *)na_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
/**
 *  使用base64加密self
 *
 *  @return 加密后的NSString对象
 */
- (NSString *)na_base64EncodedString;

@end
