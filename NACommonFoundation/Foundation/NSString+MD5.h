//
//  NSString+MD5.h
//  NACommon
//
//  Created by ND on 15/6/10.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

/**
 *  使用MD5加密self字符串
 *
 *  @return 加密后字符串
 */
- (NSString *)NA_md5Hash;

@end
