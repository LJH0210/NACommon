//
//  NSNumber+NAKit.h
//  Common
//
//  Created by ND on 15/4/30.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@import Foundation;
@import CoreGraphics;

@interface NSNumber (NAFoundation)

#if __cplusplus
extern "C" {
#endif
/**
 *  角度 转 弧度
 *
 *  @param 角度
 *
 *  @return 弧度
 */
CGFloat NA_degreesToRadians(CGFloat degrees);
/**
 *  弧度 转 角度
 *
 *  @param 弧度
 *
 *  @return 角度
 */
CGFloat NA_radiansToDegrees(CGFloat radians);
#if _cplusplus
}
#endif

@end
