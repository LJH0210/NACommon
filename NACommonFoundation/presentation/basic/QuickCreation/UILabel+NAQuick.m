//
//  UILabel+XXJQuick.m
//  XXJCommon
//
//  Created by ND on 15/5/8.
//  Copyright (c) 2015年 xxjia. All rights reserved.
//

#import "UILabel+XXJQuick.h"

@implementation UILabel (XXJQuick)

+ (UILabel *)xxj_labelWithFrame:(CGRect)frame size:(CGFloat)size alignment:(NSTextAlignment)alignment {
    return [UILabel xxj_labelWithFrame:frame size:size color:[UIColor blackColor] alignment:alignment lines:1];
}

+ (UILabel *)xxj_labelWithFrame:(CGRect)frame size:(CGFloat)size color:(UIColor *)color alignment:(NSTextAlignment)alignment lines:(NSInteger)lines {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setFont:[UIFont systemFontOfSize:size]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:color];
    [label setTextAlignment:alignment];
    [label setNumberOfLines:lines];
    [label setBackgroundColor:[UIColor clearColor]];
    return label;
}

@end
