//
//  NSMutableArray+NAKit.m
//  Common
//
//  Created by ND on 15/4/30.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import "NSMutableArray+NAFoundation.h"
#import "NSArray+NAFoundation.h"
#import "NSIndexSet+NAFoundation.h"

@implementation NSMutableArray (NAFoundation)

- (void)na_removeSafeObjectAtIndex:(NSUInteger)index {
    if ([self count] > 0 && [self count] > index) {
        [self removeObjectAtIndex:index];
    }
}

- (void)na_removeSafeObjectsAtIndexes:(NSIndexSet *)indexes {
    if ([self count] > 0 && [self count] > indexes.maxIndex) {
        [self removeObjectsAtIndexes:indexes];
    } else {
        NSMutableIndexSet *indexsCopy = [[NSMutableIndexSet alloc] init];
        [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([self count] > 0 && [self count] > idx)
                [indexsCopy addIndex:idx];

        }];
        [self removeObjectsAtIndexes:indexsCopy];
    }
}

- (void)na_objectFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex != toIndex && self.count > fromIndex && self.count > toIndex) {
        id obj = [self na_objectSafeAtIndex:fromIndex];
        id obj2 = [self objectAtIndex:toIndex];
        if (obj && obj2) {
            [self replaceObjectAtIndex:fromIndex withObject:obj2];
            [self replaceObjectAtIndex:toIndex withObject:obj];
        }
    }
}

+ (NSMutableArray *)na_sortArrayByKey:(NSString *)key array:(NSMutableArray *)array ascending:(BOOL)ascending {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    [tempArray addObjectsFromArray:array];
    NSSortDescriptor *brandDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:brandDescriptor, nil];
    NSArray *sortedArray = [tempArray sortedArrayUsingDescriptors:sortDescriptors];
    tempArray = [[NSMutableArray alloc] initWithArray:sortedArray];
    return tempArray;
}

@end
