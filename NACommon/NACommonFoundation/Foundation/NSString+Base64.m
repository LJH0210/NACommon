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

+ (NSString *)na_stringWithBase64EncodedString:(NSString *)string {
    NSData *data = [NSData na_dataWithBase64EncodedString:string];
    if (data) {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSString *)na_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data na_base64EncodedStringWithWrapWidth:wrapWidth];
}

- (NSString *)na_base64EncodedString {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data na_base64EncodedString];
}

- (NSString *)na_base64DecodedString {
    return [NSString na_stringWithBase64EncodedString:self];
}

- (NSData *)na_base64DecodedData {
    return [NSData na_dataWithBase64EncodedString:self];
}

@end
