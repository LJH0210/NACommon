//
//  NAHostConfig.h
//  NACommon
//
//  Created by  on 3/11/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    NAAppTypeDefault = 1
} NAAppType;

typedef enum {
    NAHostTypeOut = 0,         //外网线上服务器
    NAHostTypeSimulate,        //仿真服务器
    NAHostTypeIn,              //内网开发机
    NAHostTypeManual,          //手动设置服务器
    NAHostTypeDefault
} NAHostType;

/**
 *  @author , 15-03-25 20:03:53
 *
 *  系统主机管理
 */
@interface NAHostConfig : NSObject

@property (nonatomic, strong) NSString *manualHost;
@property (nonatomic, strong) NSString *manualWebAppHost;
@property (nonatomic, strong) NSString *manualHostForService;

+ (instancetype)sharedInstance;

/**
 *  @author , 15-04-02 14:04:31
 *
 *  表示具体哪个app，不同app连接的主机可能不同
 */
@property (nonatomic, assign) NAAppType appType;

/**
 *  主机类型描述
 *
 *  @return 描述
 */
+ (NSString *)hostDescription;

/**
 *  通过主机类型获取主机地址
 *
 *  @param type 类型
 *
 *  @return 主机地址
 */
+ (NSString *)hostWithType:(NAHostType)type;

/**
 *  通过主机类型获取web主机地址
 *
 *  @param type 类型
 *
 *  @return web主机地址
 */
+ (NSString *)webhostWithType:(NAHostType)type;

/**
 *  判断主机是否已指定
 *
 *  @return 是否
 */
- (BOOL)hostIsExist;

/**
 *  配置主机类型
 *
 *  @param hostType 主机类型
 */
- (void)setHostType:(NAHostType)hostType;

/**
 *  主机类型
 *
 *  @return 主机类型，未配置默认为外网
 */
- (NAHostType)hostType;

/**
 *  业务主机地址
 *
 *  @return 主机地址字符串
 */
- (NSString *)host;

/**
 *  webapp主机地址
 *
 *  @return 主机地址
 */
- (NSString *)webAppHost;

#pragma mark 公共服务主机
/**
 *  @author , 15-04-02 15:04:56
 *
 *  公共服务主机
 *
 *  @return 公共服务主机
 */
- (NSString *)hostForService;

/**
 *  @author , 15-03-20 15:03:16
 *
 *  用户登录服务主机
 *
 *  @return 用户登录服务主机
 */
- (NSString *)hostForUserLoginService;

/**
 *  图片服务主机
 *
 *  @return 图片服务主机
 */
- (NSString *)hostForPhotoService;

/**
 *  @author , 15-03-31 10:03:13
 *
 *  闪退报告服务主机
 *
 *  @return 闪退报告服务主机
 */
- (NSString *)hostForCrashReporterService;

@end
