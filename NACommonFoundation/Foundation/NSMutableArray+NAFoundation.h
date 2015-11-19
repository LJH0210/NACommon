//
//  NSMutableArray+NAKit.h
//  Common
//
//  Created by ND on 15/4/30.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (NAFoundation)

/**
 *  安全移除NSMutableArray数组元素，越界不响应
 *
 *  @param index 需要获取元素索引
 *
 */

- (void)NA_removeSafeObjectAtIndex:(NSUInteger)index;

/**
 *  安全移除NSIndexSet对应NSMutableArray内的元素集，删除未越界索引对应元素
 *
 *  @param indexs 需要删除的元素索引集
 *
 */

- (void)NA_removeSafeObjectsAtIndexes:(NSIndexSet *)indexes;

/**
 *  根据索引交换元素位置，越界不操作
 *
 *  @param fromIndex 索引
 *  @param toIndex   交换元素的索引
 */

- (void)NA_objectFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

/**
 *  使用NSSortDescriptor对NSMutableArray进行排序
 *
 *  @param key       排序关键字
 *  @param array     需要排序的数组
 *  @param ascending YES：升序  NO：降序
 *
 *  @return 使用NSSortDescriptor排序后的数组
 */

+ (NSMutableArray *)NA_sortArrayByKey:(NSString *)key array:(NSMutableArray *)array ascending:(BOOL)ascending;

@end
