//
//  NSString+Base64.m
//  NACommon
//
//  Created by ND on 15/6/17.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NSString+Base64.h"
#import "NSData+Base64.h"

@implementation NSString (Base64)

+ (NSString *)NA_stringWithBase64EncodedString:(NSString *)string {
    NSData *data = [NSData NA_dataWithBase64EncodedString:string];
    if (data) {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSString *)NA_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data NA_base64EncodedStringWithWrapWidth:wrapWidth];
}

- (NSString *)NA_base64EncodedString {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data NA_base64EncodedString];
}

- (NSString *)NA_base64DecodedString {
    return [NSString NA_stringWithBase64EncodedString:self];
}

- (NSData *)NA_base64DecodedData {
    return [NSData NA_dataWithBase64EncodedString:self];
}

@end
