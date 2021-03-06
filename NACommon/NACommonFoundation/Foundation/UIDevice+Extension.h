//
//  UIDevice+Extension.h
//  NACommon
//
//  Created by ND on 15/6/16.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Extension)

/**
 *  获取系统版号
 *
 *  @return 系统版本
 */
+ (NSString *)na_systemVersion;

/**
 *  获取屏幕宽度
 *
 *  @return 宽度
 */
+ (CGFloat)na_screenWidth;

/**
 *  获取屏幕高度
 *
 *  @return 高度
 */
+ (CGFloat)na_screenHeight;

/**
 *  获取系统版本信息
 *  比如: "iPhone3,2"
 *
 *  @return 系统版本信息
 */
+ (NSString *)na_devicePlatform;

/**
 *  检查是否是设备是否是IPad
 *
 *  @return YES：是ipad  NO：不是Ipad
 */
+ (BOOL)na_isiPad;

/**
 *  检查设备是否是设备是否是iPhone
 *
 *  @return Return YES ：是iPhone   NO： 不是iPhone
 */
+ (BOOL)na_isiPhone;

/**
 *  检查设备是否是iPod
 *
 *  @return Return YES ：是iPod  NO：不是iPod
 */
+ (BOOL)na_isiPod;

/**
 *  检查设备是否是模拟器
 *
 *  @return Return YES：是模拟器  NO：不是模拟器
 */
+ (BOOL)na_isSimulator;

/**
 *  检查是否是retina屏
 *
 *  @return Return YES：是retina屏  NO：不是retina屏
 */
+ (BOOL)na_isRetina;

/**
 *  检查是否是retina HD 屏
 *
 *  @return Return YES ：是retina HD屏  NO：不是retina HD屏
 */
+ (BOOL)na_isRetinaHD;

/**
 *  @author , 15-08-26 14:08:55
 *
 *  获取设备的mac地址
 *
 *  @return mac地址
 */
+ (NSString *)na_MACAddress;

/**
 *  @author , 15-08-26 14:08:31
 *
 *  获取设备的IP地址
 *
 *  @return IP地址
 */
+ (NSString *)na_IPAddress;

@end
