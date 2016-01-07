//
//  NSData+Base64.m
//  NACommon
//
//  Created by ND on 15/6/17.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NSData+Base64.h"

#pragma GCC diagnostic ignored "-Wselector"

#import <Availability.h>
#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

@implementation NSData (Base64)

+ (NSData *)na_dataWithBase64EncodedString:(NSString *)string {
    if (![string length])
        return nil;

    NSData *decoded = nil;

#if __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_9 || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0

    if (![NSData instancesRespondToSelector:@selector(initWithBase64EncodedString:options:)]) {
        decoded = [[self alloc] initWithBase64Encoding:[string stringByReplacingOccurrencesOfString:@"[^A-Za-z0-9+/=]"
                                                                                         withString:@""
                                                                                            options:NSRegularExpressionSearch
                                                                                              range:NSMakeRange(0, [string length])]];
    } else

#endif

    {
        decoded = [[self alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    }

    return [decoded length] ? decoded : nil;
}

- (NSString *)na_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth {
    if (![self length])
        return nil;

    NSString *encoded = nil;

#if __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_9 || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0

    if (![NSData instancesRespondToSelector:@selector(base64EncodedStringWithOptions:)]) {
        encoded = [self base64Encoding];
    } else

#endif

    {
        switch (wrapWidth) {
        case 64: {
            return [self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        }
        case 76: {
            return [self base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
        }
        default: { encoded = [self base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0]; }
        }
    }

    if (!wrapWidth || wrapWidth >= [encoded length]) {
        return encoded;
    }

    wrapWidth = (wrapWidth / 4) * 4;
    NSMutableString *result = [NSMutableString string];
    for (NSUInteger i = 0; i < [encoded length]; i += wrapWidth) {
        if (i + wrapWidth >= [encoded length]) {
            [result appendString:[encoded substringFromIndex:i]];
            break;
        }
        [result appendString:[encoded substringWithRange:NSMakeRange(i, wrapWidth)]];
        [result appendString:@"\r\n"];
    }

    return result;
}

- (NSString *)na_base64EncodedString {
    return [self na_base64EncodedStringWithWrapWidth:0];
}

@end
