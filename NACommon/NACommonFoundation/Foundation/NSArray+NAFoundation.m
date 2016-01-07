//
//  NSArray+NAKit.m
//  Common
//
//  Created by ND on 15/4/29.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import "NSArray+NAFoundation.h"

@implementation NSArray (NAFoundation)

- (id)na_objectSafeAtIndex:(NSUInteger)index {
    if ([self count] > 0 && [self count] > index)
        return [self objectAtIndex:index];
    else
        return nil;
}

- (NSArray *)objectFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) {
        if ([self na_objectSafeAtIndex:fromIndex])
            return [NSArray arrayWithObject:[self na_objectSafeAtIndex:fromIndex]];
        else
            return nil;
    } else if (fromIndex > toIndex) {
        NSMutableArray *ar = [[NSMutableArray alloc] init];
        for (NSUInteger i = fromIndex; i >= toIndex; i--) {
            if ([self na_objectSafeAtIndex:i])
                [ar addObject:[self na_objectSafeAtIndex:i]];
        }
        return [ar copy];
    } else {
        NSMutableArray *ar = [[NSMutableArray alloc] init];
        for (NSUInteger i = fromIndex; i <= toIndex; i++) {
            if ([self na_objectSafeAtIndex:i])
                [ar addObject:[self na_objectSafeAtIndex:i]];
        }
        return [ar copy];
    }
}

@end
