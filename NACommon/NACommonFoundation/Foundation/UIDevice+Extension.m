//
//  UIDevice+Extension.m
//  NACommon
//
//  Created by ND on 15/6/16.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "UIDevice+Extension.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

static NSString *const BFUniqueIdentifierDefaultsKey = @"BFUniqueIdentifier";

/**
 *  Get the iOS version
 */
#define IOS_VERSION [UIDevice currentDevice].systemVersion

/**
 *  Get the screen width and height
 */
#define SCREEN_WIDTH                                                                                                                                           \
    ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) ||                                                            \
      ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown))                                                    \
         ? [[UIScreen mainScreen] bounds].size.width                                                                                                           \
         : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT                                                                                                                                          \
    ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) ||                                                            \
      ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown))                                                    \
         ? [[UIScreen mainScreen] bounds].size.height                                                                                                          \
         : [[UIScreen mainScreen] bounds].size.width)

/**
 *  Macros to compare system versions
 *
 *  @param v Version, like @"8.0"
 *
 *  @return Return a BOOL
 */
#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@implementation UIDevice (Extension)

+ (NSString *)na_systemVersion {
    return [UIDevice currentDevice].systemVersion;
}

+ (CGFloat)na_screenWidth {
    return SCREEN_WIDTH;
}

+ (CGFloat)na_screenHeight {
    return SCREEN_HEIGHT;
}

+ (NSString *)na_devicePlatform {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

+ (NSString *)devicePlatformString {
    NSString *platform = [self na_devicePlatform];
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"])
        return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"])
        return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])
        return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])
        return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])
        return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])
        return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])
        return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])
        return @"iPhone 5 (CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])
        return @"iPhone 5C (GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])
        return @"iPhone 5C (Global)";
    if ([platform isEqualToString:@"iPhone6,1"])
        return @"iPhone 5S (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])
        return @"iPhone 5S (Global)";
    if ([platform isEqualToString:@"iPhone7,1"])
        return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])
        return @"iPhone 6";
    // iPod
    if ([platform isEqualToString:@"iPod1,1"])
        return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])
        return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])
        return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])
        return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])
        return @"iPod Touch 5G";
    // iPad
    if ([platform isEqualToString:@"iPad1,1"])
        return @"iPad 1";
    if ([platform isEqualToString:@"iPad2,1"])
        return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])
        return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])
        return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])
        return @"iPad 2 (32nm)";
    if ([platform isEqualToString:@"iPad2,5"])
        return @"iPad mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])
        return @"iPad mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])
        return @"iPad mini (CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])
        return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])
        return @"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])
        return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])
        return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])
        return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])
        return @"iPad 4 (CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])
        return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])
        return @"iPad Air (Cellular)";
    if ([platform isEqualToString:@"iPad4,3"])
        return @"iPad Air (China)";
    if ([platform isEqualToString:@"iPad5,3"])
        return @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])
        return @"iPad Air 2 (Cellular)";
    // iPad mini
    if ([platform isEqualToString:@"iPad4,4"])
        return @"iPad mini 2 (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])
        return @"iPad mini 2 (Cellular)";
    if ([platform isEqualToString:@"iPad4,6"])
        return @"iPad mini 2 (China)";
    if ([platform isEqualToString:@"iPad4,7"])
        return @"iPad mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])
        return @"iPad mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad4,9"])
        return @"iPad mini 3 (China)";
    // Simulator
    if ([platform isEqualToString:@"i386"])
        return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])
        return @"Simulator";
    return platform;
}

+ (BOOL)na_isiPad {
    if ([[[self na_devicePlatform] substringToIndex:4] isEqualToString:@"iPad"])
        return YES;
    else
        return NO;
}

+ (BOOL)na_isiPhone {
    if ([[[self na_devicePlatform] substringToIndex:6] isEqualToString:@"iPhone"])
        return YES;
    else
        return NO;
}

+ (BOOL)na_isiPod {
    if ([[[self na_devicePlatform] substringToIndex:4] isEqualToString:@"iPod"])
        return YES;
    else
        return NO;
}

+ (BOOL)na_isSimulator {
    if ([[self na_devicePlatform] isEqualToString:@"i386"] || [[self na_devicePlatform] isEqualToString:@"x86_64"])
        return YES;
    else
        return NO;
}

+ (BOOL)na_isRetina {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
        ([UIScreen mainScreen].scale == 2.0 || [UIScreen mainScreen].scale == 3.0))
        return YES;
    else
        return NO;
}

+ (BOOL)na_isRetinaHD {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 3.0))
        return YES;
    else
        return NO;
}

+ (NSInteger)iOSVersion {
    return [[[UIDevice currentDevice] systemVersion] integerValue];
}

+ (NSUInteger)getSysInfo:(uint)typeSpecifier {
    size_t size = sizeof(int);
    int results;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &results, &size, NULL, 0);
    return (NSUInteger)results;
}

+ (NSUInteger)cpuFrequency {
    return [self getSysInfo:HW_CPU_FREQ];
}

+ (NSUInteger)busFrequency {
    return [self getSysInfo:HW_BUS_FREQ];
}

+ (NSUInteger)ramSize {
    return [self getSysInfo:HW_MEMSIZE];
}

+ (NSUInteger)cpuNumber {
    return [self getSysInfo:HW_NCPU];
}

+ (NSUInteger)totalMemory {
    return [self getSysInfo:HW_PHYSMEM];
}

+ (NSUInteger)userMemory {
    return [self getSysInfo:HW_USERMEM];
}

+ (NSNumber *)totalDiskSpace {
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemSize];
}

+ (NSNumber *)freeDiskSpace {
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemFreeSize];
}

+ (NSString *)na_MACAddress {
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;

    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;

    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }

    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }

    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. Rrror!\n");
        return NULL;
    }

    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }

    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X", *ptr, *(ptr + 1), *(ptr + 2), *(ptr + 3), *(ptr + 4), *(ptr + 5)];
    // NSString *outstring = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X",
    //                       *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);

    return outstring;
}

+ (NSString *)na_IPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if (temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

@end
