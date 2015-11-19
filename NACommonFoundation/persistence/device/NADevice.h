//
//  NADevice.h
//  NACommon
//
//  Created by  on 3/20/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @author , 15-03-25 17:03:06
 *
 *  苹果设备信息管理
 */
@interface NADevice : NSObject

/**
 *  @author , 15-03-25 17:03:54
 *
 *  设备的硬件信息
 *
 *  @return 硬件信息
 */
+ (NSString *)hardwareModel;

/**
 *  @author , 15-03-30 19:03:46
 *
 *  系统版本号
 *
 *  @return 系统版本号
 */
+ (NSString *)versionForOS;

/**
 *  @author , 15-03-25 17:03:02
 *
 *  创建UUID
 *
 *  @return UUID
 */
+ (NSString *)createGUIDStr;

/**
 *  @author , 15-03-25 17:03:28
 *
 *  分配给当前设备的UUID
 *
 *  @return UUID
 */
+ (NSString *)deviceID;

@end
