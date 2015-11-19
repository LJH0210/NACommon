//
//  NAHttpRequestConfig.h
//  XXJCommon
//
//  Created by LJH on 15/11/18.
//  Copyright © 2015年 xxjia. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NAHttpRequestConfig : NSObject 

/**
 *  @author , 15-03-25 20:03:51
 *
 *  Access Token,支持重载
 *
 *  @return Token
 */
+ (NSData *)accessTokenData;

/**
 *  @author , 15-03-25 20:03:51
 *
 *  Access Token,支持重载
 *
 *  @return Token
 */
+ (NSString *)accessTokenString;


/**
 *  @author , 15-03-25 20:03:51
 *
 *
 *  @return Token
 */
+ (NSString *)appendToUrl:(NSString *)url;

@end
