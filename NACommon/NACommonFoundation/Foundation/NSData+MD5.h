//
//  NSData+MD5.h
//  NACommon
//
//  Created by ND on 15/6/10.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (MD5)

/**
 *  使用MD5加密nsdata对象
 *
 *  @return 加密后NSData对象
 */
- (NSString *)NA_md5Hash;

@end
