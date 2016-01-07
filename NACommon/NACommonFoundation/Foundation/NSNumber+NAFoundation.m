//
//  NSNumber+NAKit.m
//  Common
//
//  Created by ND on 15/4/30.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import "NSNumber+NAFoundation.h"

@implementation NSNumber (NAFoundation)

#if __cplusplus
extern "C" {
#endif
CGFloat na_degreesToRadians(CGFloat degrees) { return degrees * M_PI / 180; };
CGFloat na_radiansToDegrees(CGFloat radians) { return radians * 180 / M_PI; };
#if _cplusplus
}
#endif

@end
