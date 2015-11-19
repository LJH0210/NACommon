//
//  NAHostConfig.m
//  NACommon
//
//  Created by  on 3/11/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import "NAHostConfig.h"
#import "NSString+NAFoundation.h"

#define kNAHostTypeConfig @"kNAHostTypeConfig"
#define kNAManualHostConfig @"kNAManualHostConfig"
#define kNAManualWebHostConfig @"kNAManualWebHostConfig"
#define kNAManualHostForServiceConfig @"kNAManualHostForServiceConfig"

@implementation NAHostConfig

+ (instancetype)sharedInstance {
  static NAHostConfig *gHostConfig = nil;
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    gHostConfig = [[self alloc] init];
  });
  return gHostConfig;
}

+ (NSString *)keyForAppHostTypeConfig {
  return [NSString stringWithFormat:@"%@_%@", kNAHostTypeConfig,
                                    [[NSBundle mainBundle] bundleIdentifier]];
}

+ (NSString *)keyForAppManualHostConfig {
  return [NSString stringWithFormat:@"%@_%@", kNAManualHostConfig,
                                    [[NSBundle mainBundle] bundleIdentifier]];
}

+ (NSString *)keyForAppManualWebHostConfig {
  return [NSString stringWithFormat:@"%@_%@", kNAManualWebHostConfig,
                                    [[NSBundle mainBundle] bundleIdentifier]];
}

+ (NSString *)keyForAppManualHostForServiceConfig {
  return [NSString stringWithFormat:@"%@_%@", kNAManualHostForServiceConfig,
                                    [[NSBundle mainBundle] bundleIdentifier]];
}

+ (NSString *)hostDescription {
  NSString *desc = nil;
  if ([[NAHostConfig sharedInstance] hostType] == NAHostTypeOut) {
    desc = @"外网";
  } else if ([[NAHostConfig sharedInstance] hostType] == NAHostTypeSimulate) {
    desc = @"仿真";
  } else if ([[NAHostConfig sharedInstance] hostType] == NAHostTypeIn) {
    desc = @"开发";
  } else if ([[NAHostConfig sharedInstance] hostType] == NAHostTypeManual) {
    desc = @"手动";
  } else if ([[NAHostConfig sharedInstance] hostType] == NAHostTypeDefault) {
    desc = @"默认";
  } else {
    desc = @"仿真";
  }

  return desc;
}

+ (NSString *)hostWithType:(NAHostType)type {
  switch ([NAHostConfig sharedInstance].appType) {
    case NAAppTypeDefault:
      if (type == NAHostTypeDefault) {
        return @"http://api.map.baidu.com";
      } else if (type == NAHostTypeOut) {
        return @"https://api.NAia.cn/";
      } else if (type == NAHostTypeSimulate) {
        return @"https://simulateapi.NAia.cn/";
      } else if (type == NAHostTypeManual) {
        return [[self sharedInstance] manualHost];
      } else if (type == NAHostTypeIn) {
        return @"http://00api.hair.192.168.94.26.xip.io/";
      } else {
        return @"https://simulateapi.NAia.cn/";
      }
      break;
  }
  return @"";
}

+ (NSString *)webhostWithType:(NAHostType)type {
  switch ([NAHostConfig sharedInstance].appType) {
    case NAAppTypeDefault:
      if (type == NAHostTypeOut) {
        return @"";
      } else if (type == NAHostTypeSimulate) {
        return @"";
      } else if (type == NAHostTypeIn) {
        return @"";
      } else if (type == NAHostTypeManual) {
        return @"";
      } else {
        return @"";
      }
      break;
  }
  return @"";
}

- (BOOL)hostIsExist {
  if ([[NSUserDefaults standardUserDefaults]
          objectForKey:[NAHostConfig keyForAppHostTypeConfig]]) {
    return TRUE;
  }
  return FALSE;
}

/**
 *  配置主机类型
 *
 *  @param hostType 主机类型
 */
- (void)setHostType:(NAHostType)hostType {
  [[NSUserDefaults standardUserDefaults]
      setObject:@(hostType)
         forKey:[NAHostConfig keyForAppHostTypeConfig]];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  主机类型
 *
 *  @return 主机类型，DEBUG下未配置默认为仿真
 */
- (NAHostType)hostType {
#if DEBUG
  if (![[NSUserDefaults standardUserDefaults]
          objectForKey:[NAHostConfig keyForAppHostTypeConfig]]) {
    return NAHostTypeSimulate;
  }
  return [[[NSUserDefaults standardUserDefaults]
      objectForKey:[NAHostConfig keyForAppHostTypeConfig]] intValue];
#else
  if (![[NSUserDefaults standardUserDefaults]
          objectForKey:[NAHostConfig keyForAppHostTypeConfig]]) {
    return NAHostTypeOut;
  }
  return [[[NSUserDefaults standardUserDefaults]
      objectForKey:[NAHostConfig keyForAppHostTypeConfig]] intValue];
#endif
}

//业务主机地址
- (NSString *)host {
  return [NAHostConfig hostWithType:[self hostType]];
}

/**
 *  webapp主机地址
 *
 *  @return 主机地址
 */
- (NSString *)webAppHost {
  return [NAHostConfig webhostWithType:[self hostType]];
}

- (NSString *)hostForService {
  if ([self hostType] == NAHostTypeOut) {
    return @"http://serviceapi.NAia.cn/";
  } else if ([self hostType] == NAHostTypeSimulate) {
    return @"http://simulateserviceapi.NAia.cn/";
  } else if ([self hostType] == NAHostTypeManual) {
    return [self manualHostForService];
  } else if ([self hostType] == NAHostTypeIn) {
    return @"http://service.192.168.94.26.xip.io/";
  } else {
    return @"http://simulateapi.NAia.cn/";
  }
}

/**
 *  @author , 15-03-20 15:03:16
 *
 *  用户登录服务主机
 *
 *  @return 用户登录服务主机
 */
- (NSString *)hostForUserLoginService {
  NSString *host = [self hostForService];
  if ([self hostType] == NAHostTypeOut ||
      [self hostType] == NAHostTypeSimulate) {
    host = [host stringByReplacingOccurrencesOfString:@"http://"
                                           withString:@"https://"];
  }
  return host;
}

/**
 *  图片服务主机
 *
 *  @return 图片服务主机
 */
- (NSString *)hostForPhotoService {
  return [self hostForService];
}

- (NSString *)hostForCrashReporterService {
  if ([self hostType] == NAHostTypeOut) {
    return @"http://api.NAia.cn/";
  } else if ([self hostType] == NAHostTypeSimulate) {
    return @"http://simulateapi.NAia.cn/";
  } else if ([self hostType] == NAHostTypeManual) {
    return @"http://simulateapi.NAia.cn/";
  } else if ([self hostType] == NAHostTypeIn) {
    return @"http://simulateapi.NAia.cn/";
  } else {
    return @"http://simulateapi.NAia.cn/";
  }
}

#pragma mark 手动配置信息
- (NSString *)manualHost {
  return [[NSUserDefaults standardUserDefaults]
      objectForKey:[NAHostConfig keyForAppManualHostConfig]];
}

- (void)setManualHost:(NSString *)manualHost {
  if (manualHost) {
    [[NSUserDefaults standardUserDefaults]
        setObject:manualHost
           forKey:[NAHostConfig keyForAppManualHostConfig]];
    [[NSUserDefaults standardUserDefaults] synchronize];
  }
}

- (NSString *)manualWebAppHost {
  return [[NSUserDefaults standardUserDefaults]
      objectForKey:[NAHostConfig keyForAppManualWebHostConfig]];
}

- (void)setManualWebAppHost:(NSString *)manualWebAppHost {
  if (manualWebAppHost) {
    [[NSUserDefaults standardUserDefaults]
        setObject:manualWebAppHost
           forKey:[NAHostConfig keyForAppManualWebHostConfig]];
    [[NSUserDefaults standardUserDefaults] synchronize];
  }
}

- (NSString *)manualHostForService {
  return [[NSUserDefaults standardUserDefaults]
      objectForKey:[NAHostConfig keyForAppManualHostForServiceConfig]];
}

- (void)setManualHostForService:(NSString *)manualHost {
  if (manualHost) {
    [[NSUserDefaults standardUserDefaults]
        setObject:manualHost
           forKey:[NAHostConfig keyForAppManualHostForServiceConfig]];
    [[NSUserDefaults standardUserDefaults] synchronize];
  }
}

@end
