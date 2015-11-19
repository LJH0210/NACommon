//
//  NSMutableDictionary+NAKit.m
//  Common
//
//  Created by ND on 15/4/30.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import "NSMutableDictionary+NAFoundation.h"

@implementation NSMutableDictionary (NAFoundation)

- (BOOL)NA_safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (nil == anObject) {
        return NO;
    }

    [self setObject:anObject forKey:aKey];
    return YES;
}

@end
