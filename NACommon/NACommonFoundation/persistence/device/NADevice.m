//
//  NADevice.m
//  NACommon
//
//  Created by  on 3/20/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import "NADevice.h"
#include <sys/sysctl.h>
#import <UIKit/UIKit.h>
#import "UIDevice+Extension.h"

@implementation NADevice

+ (NSString *)hardwareModel {
    return [UIDevice NA_devicePlatform];
}

+ (NSString *)versionForOS {
    return [NSString stringWithFormat:@"%@ %@", [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion];
}

+ (NSString *)createGUIDStr {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef stringGUID = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge_transfer NSString *)stringGUID;
}

+ (NSString *)deviceID {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *strdeviceid = [defaults objectForKey:@"kNAdeviceid"];
    if (strdeviceid == nil) {
        strdeviceid = [NADevice createGUIDStr];
        [defaults setObject:strdeviceid forKey:@"kNAdeviceid"];
        [defaults synchronize];
    }

    return strdeviceid;
}

@end
