//
//  NACommonDefine.h
//  NACommon
//
//  Created by  on 3/14/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>

//----------------------------------颜色--------------------------------------{
#define fRgbColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define fRgbaColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define fHexColor(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 \
                                      green:((float)((hex & 0xFF00) >> 8)) / 255.0 \
                                       blue:((float)(hex & 0xFF)) / 255.0 \
                                      alpha:1]
//----------------------------------颜色--------------------------------------}


//----------------------------------设备判断-----------------------------------{
#define kNADeviceiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//----------------------------------设备判断-----------------------------------}


//----------------------------------分辨率--------------------------------------{
// 设备屏宽
#define kNADeviceWidth [[UIScreen mainScreen] applicationFrame].size.width
// 设备屏高
#define kNADeviceHeight [[UIScreen mainScreen] applicationFrame].size.height
// 设备全屏高
#define kNADeviceFullHeight [[UIScreen mainScreen] bounds].size.height
// 设备全屏宽
#define kNADeviceFullWidth [[UIScreen mainScreen] bounds].size.width

//ios版本首位数字 比如5.01 -> 5
#define kNAiOSVersionFirstValue ([[[UIDevice currentDevice] systemVersion] intValue])

#define kNANavBarHeight (kNAiOSVersionFirstValue >= 7 ? 64 : 44)
#define kNAStatusBarHeight (kNAiOSVersionFirstValue >= 7 ? 0 : 20)
//----------------------------------分辨率--------------------------------------}

//----------------------------------浮点型运算-----------------------------------{
#define fFequal(a,b) (fabs((a) - (b)) < FLT_EPSILON)
#define fFequalZero(a) (fabs(a) < FLT_EPSILON)
//----------------------------------浮点型运算-----------------------------------}

@interface NACommonDefine : NSObject

@end
