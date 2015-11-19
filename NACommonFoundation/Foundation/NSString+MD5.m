//
//  NSString+MD5.m
//  NACommon
//
//  Created by ND on 15/6/10.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NSString+MD5.h"
#import "NSData+MD5.h"

@implementation NSString (MD5)

- (NSString *)NA_md5Hash {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] NA_md5Hash];
}

@end
