//
//  NSArray+NAKit.h
//  Common
//
//  Created by ND on 15/4/29.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (NAFoundation)

/**
 *  获取NSArray数组内对象，越界返回nil
 *
 *  @param index 需要获取的位置
 *
 *  @return 获取的数组对象，越界返回nil
 */
- (id)na_objectSafeAtIndex:(NSUInteger)index;

@end
