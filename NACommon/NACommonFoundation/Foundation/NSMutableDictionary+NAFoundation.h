//
//  NSMutableDictionary+NAKit.h
//  Common
//
//  Created by ND on 15/4/30.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (NAFoundation)

/**
 *  安全模式设置NSMutableDictionary
 *
 *  @param anObject 键值对-值
 *  @param aKey     键值对-键
 *
 *  @return YES：anObject不为空，设置成功   NO：anObject为空，设置失败
 */
- (BOOL)na_safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey;

@end
