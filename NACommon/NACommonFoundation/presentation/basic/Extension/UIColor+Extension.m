//
//  UIColor+NAKit.m
//  Common
//
//  Created by ND on 15/4/30.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (UIColor *)NA_colorWithHexString:(NSString *)hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
    case 3: // #RGB
        alpha = 1.0f;
        red = [self NA_colorComponentFrom:colorString start:0 length:1];
        green = [self NA_colorComponentFrom:colorString start:1 length:1];
        blue = [self NA_colorComponentFrom:colorString start:2 length:1];
        break;
    case 4: // #ARGB
        alpha = [self NA_colorComponentFrom:colorString start:0 length:1];
        red = [self NA_colorComponentFrom:colorString start:1 length:1];
        green = [self NA_colorComponentFrom:colorString start:2 length:1];
        blue = [self NA_colorComponentFrom:colorString start:3 length:1];
        break;
    case 6: // #RRGGBB
        alpha = 1.0f;
        red = [self NA_colorComponentFrom:colorString start:0 length:2];
        green = [self NA_colorComponentFrom:colorString start:2 length:2];
        blue = [self NA_colorComponentFrom:colorString start:4 length:2];
        break;
    case 8: // #AARRGGBB
        alpha = [self NA_colorComponentFrom:colorString start:0 length:2];
        red = [self NA_colorComponentFrom:colorString start:2 length:2];
        green = [self NA_colorComponentFrom:colorString start:4 length:2];
        blue = [self NA_colorComponentFrom:colorString start:6 length:2];
        break;
    default:
        [NSException raise:@"Invalid color value"
                    format:@"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
        break;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (CGFloat)NA_colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat:@"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];

    return hexComponent / 255.0;
}

+ (id)NA_colorWithHex:(unsigned int)hex {
    return [UIColor NA_colorWithHex:hex alpha:1.0];
}

+ (id)NA_colorWithHex:(unsigned int)hex alpha:(float)alpha {
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hex & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hex & 0xFF)) / 255.0
                           alpha:alpha];
}

+ (UIColor *)NA_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
}

@end
