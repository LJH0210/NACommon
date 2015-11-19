//
//  NSIndexSet+NAKit.m
//  Common
//
//  Created by ND on 15/4/30.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import "NSIndexSet+NAFoundation.h"

@implementation NSIndexSet (NAFoundation)

- (NSUInteger)maxIndex {
    __block NSUInteger maxInd;
    [self enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        if (idx > maxInd) maxInd = idx;
    }];
    return maxInd;
}

@end
