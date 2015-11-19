//
//  NSAttributedString+NAFoundation.m
//  NACommon
//
//  Created by ND on 15/6/12.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NSAttributedString+NAFoundation.h"
#import "NSString+NAFoundation.h"

@implementation NSAttributedString (NAFoundation)

+ (NSAttributedString *)NA_attribuedStringWithleftIndentify:(NSString *)leftIndentify
                                                    leftFont:(UIFont *)leftFont
                                                   leftColor:(UIColor *)leftColor
                                                      String:(NSString *)string
                                                  stringFont:(UIFont *)stringFont
                                                 stringColor:(UIColor *)stringColor {
    return [NSAttributedString NA_attribuedStringWithLeftIndentify:leftIndentify
                                                           leftFont:leftFont
                                                          leftColor:leftColor
                                                             string:string
                                                         stringFont:stringFont
                                                        stringColor:stringColor
                                                     rightIndentify:nil
                                                          rightFont:nil
                                                         rightColor:nil];
}

+ (NSAttributedString *)NA_attribuedStringWithLeftIndentify:(NSString *)leftIndentify
                                                    leftFont:(UIFont *)leftFont
                                                   leftColor:(UIColor *)leftColor
                                                      string:(NSString *)string
                                                  stringFont:(UIFont *)stringFont
                                                 stringColor:(UIColor *)stringColor
                                              rightIndentify:(NSString *)rightIndentify
                                                   rightFont:(UIFont *)rightFont
                                                  rightColor:(UIColor *)rightColor {

    NSString *left = [NSString NA_retNotEmptyString:leftIndentify defaultString:@""];
    NSString *cente = [NSString NA_retNotEmptyString:string defaultString:@""];
    NSString *right = [NSString NA_retNotEmptyString:rightIndentify defaultString:@""];

    NSMutableAttributedString *mattributedstring =
        [[NSMutableAttributedString alloc] initWithString:[[NSString alloc] initWithFormat:@"%@%@%@", left, cente, right]];

    if (leftColor && leftFont)
        [mattributedstring addAttributes:@{ NSFontAttributeName : leftFont, NSForegroundColorAttributeName : leftColor } range:NSMakeRange(0, left.length)];

    if (stringColor && stringFont)
        [mattributedstring addAttributes:@{
            NSFontAttributeName : stringFont,
            NSForegroundColorAttributeName : stringColor
        } range:NSMakeRange(left.length, string.length)];
    if (rightColor && rightFont)
        [mattributedstring addAttributes:@{
            NSFontAttributeName : rightFont,
            NSForegroundColorAttributeName : rightColor
        } range:NSMakeRange(left.length + cente.length, right.length)];
    return [[NSAttributedString alloc] initWithAttributedString:mattributedstring];
}

@end
