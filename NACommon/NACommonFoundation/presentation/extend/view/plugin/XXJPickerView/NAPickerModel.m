//
//  NAPickerModel.m
//  NACommon
//
//  Created by giggity on 15/6/3.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NAPickerModel.h"

@implementation NAPickerModel

- (id)copyWithZone:(NSZone *)zone {
    NAPickerModel *result = [[[self class] alloc] init];
    result.key = [self.key copyWithZone:zone];
    result.value = [self.value copyWithZone:zone];
    return result;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:self.class] && [((NAPickerModel *)object).key isEqualToString:self.key]) {
        return YES;
    }
    return NO;
}

- (NSUInteger)hash {
    return 0;
}

@end
