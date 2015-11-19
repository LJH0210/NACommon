//
//  NAHttpRequestConfig.m
//  XXJCommon
//
//  Created by LJH on 15/11/18.
//  Copyright © 2015年 xxjia. All rights reserved.
//

#import "NAHttpRequestConfig.h"

@implementation NAHttpRequestConfig

/**
 *  @author , 15-03-25 20:03:51
 *
 *  Access Token,支持重载
 *
 *  @return Token
 */
+ (NSData *)accessTokenData{
    return nil;
}

/**
 *  @author , 15-03-25 20:03:51
 *
 *  Access Token,支持重载
 *
 *  @return Token
 */
+ (NSString *)accessTokenString{
    return nil;
}


/**
 *  @author , 15-03-25 20:03:51
 *
 *
 *  @return Token
 */
+ (NSString *)appendToUrl:(NSString *)url{
    return url;
}

+ (NSString *)msgWithError:(NSError *)error {
    NSString *strerror = nil;
    switch (error.code) {
        case 1:
            strerror = @"网络连接失败";
            break;
        case 2:
            strerror = @"网络请求超时";
            break;
        case 3:
            strerror = @"网络认证失败";
            break;
        case 4:
            strerror = @"网络请求已取消";
            break;
        case 5:
            strerror = @"无法创建网络请求，非法的URL？";
            break;
            
        default:
            break;
    }
    
    if (!strerror.length) {
        strerror = error.userInfo[@"NSLocalizedDescription"];
        if (!strerror.length) {
            strerror = @"网络请求失败，请检查网络是否正常";
        }
    }
    
    return strerror;
}


@end
