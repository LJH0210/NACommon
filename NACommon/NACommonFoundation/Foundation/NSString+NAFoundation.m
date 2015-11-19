//
//  NSString+NAKit.m
//  Common
//
//  Created by ND on 15/4/30.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import "NSString+NAFoundation.h"

@implementation NSString (NAFoundation)

+ (BOOL)NA_isEmptyString:(NSString *)string {
    if (string == nil || [string isKindOfClass:[NSNull class]])
        return YES;
    NSString *tmp = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([tmp isEqualToString:@""])
        return YES;
    return NO;
}

+ (NSString *)NA_retNotEmptyString:(NSString *)inputString defaultString:(NSString *)defaul {
    return [NSString NA_isEmptyString:inputString] ? defaul : inputString;
}

+ (NSString *)NA_innerVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSString *)NA_outerVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)NA_appDisplayName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

- (BOOL)NA_containString:(NSString *)aString {
    NSRange range = [self rangeOfString:aString];
    if (range.location == NSNotFound) {
        return NO;
    }
    return YES;
}

- (CGSize)NA_commonSizeWithFont:(UIFont *)font containSize:(CGSize)containSize lineBreakMode:(NSLineBreakMode)mode {
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary *attribute = @{NSFontAttributeName : font};
        CGSize size =
            [self boundingRectWithSize:containSize
                               options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                            attributes:attribute
                               context:nil]
                .size;
        return size;
    }
    CGSize size = [self sizeWithFont:font constrainedToSize:containSize lineBreakMode:mode];
    return size;
}

// 正则判断是否是 有效的手机号
- (BOOL)NA_isValidateMobile {
    NSString *emailRegex = @"(13[0-9]|18[0-9]|15[0-9]|17[0-9]|2[8-9][0-9])\\d{8}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (CGFloat)NA_countHeighWithWidth:(int)width font:(UIFont *)font {
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary *attribute = @{NSFontAttributeName : font};
        CGSize size =
            [self boundingRectWithSize:CGSizeMake(width, 5000)
                               options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                            attributes:attribute
                               context:nil]
                .size;
        return size.height + 4;
    } else {
        CGSize size = [self sizeWithFont:font constrainedToSize:CGSizeMake(width, 5000) lineBreakMode:NSLineBreakByTruncatingTail];
        return size.height + 4;
    }
}

- (BOOL)NA_isEmail {
    NSString *emailRegEx = @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
        @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
        @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
        @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";

    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:[self lowercaseString]];
}

+ (BOOL)NA_isEmail:(NSString *)email {
    return [email NA_isEmail];
}

- (BOOL)NA_isContainsEmoji {

    __block BOOL isEomji = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              const unichar hs = [substring characterAtIndex:0];
                              // surrogate pair
                              if (0xd800 <= hs && hs <= 0xdbff) {
                                  if (substring.length > 1) {
                                      const unichar ls = [substring characterAtIndex:1];
                                      const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                      if (0x1d000 <= uc && uc <= 0x1f77f) {
                                          isEomji = YES;
                                      }
                                  }
                              } else if (substring.length > 1) {
                                  const unichar ls = [substring characterAtIndex:1];
                                  if (ls == 0x20e3) {
                                      isEomji = YES;
                                  }
                              } else {
                                  // non surrogate
                                  if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                                      isEomji = YES;
                                  } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                      isEomji = YES;
                                  } else if (0x2934 <= hs && hs <= 0x2935) {
                                      isEomji = YES;
                                  } else if (0x3297 <= hs && hs <= 0x3299) {
                                      isEomji = YES;
                                  } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b ||
                                             hs == 0x2b50 || hs == 0x231a) {
                                      isEomji = YES;
                                  }
                              }
                          }];
    return isEomji;
}

@end
