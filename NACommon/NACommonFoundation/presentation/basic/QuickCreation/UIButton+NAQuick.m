//
//  UIButton+Quick.m
//  XXJCommon
//
//  Created by ND on 15/5/8.
//  Copyright (c) 2015年 xxjia. All rights reserved.
//

#import "UIButton+XXJQuick.h"
#import "UIImage+Extension.h"

@implementation UIButton (XXJQuick)

+ (UIButton *)xxj_buttonWithFrame:(CGRect)frame backgroundImage:(UIImage *)image highlightBackgroundImage:(UIImage *)highlightImage {
    return [UIButton xxj_buttonWithFrame:frame title:@"" titleColor:nil backgroundImage:image highlightedBackgroundImage:highlightImage];
}

+ (UIButton *)xxj_buttonWithFrame:(CGRect)frame
                            title:(NSString *)title
                  backgroundColor:(UIColor *)backgroundColor
       backgroundHighlightedColor:(UIColor *)highlightedColor {

    return [UIButton xxj_buttonWithFrame:frame
                                   title:title
                              titleColor:[UIColor blackColor]
                         backgroundImage:[UIImage xxj_imageWithColor:backgroundColor]
              highlightedBackgroundImage:[UIImage xxj_imageWithColor:highlightedColor]];
}

+ (UIButton *)xxj_buttonWithFrame:(CGRect)frame
                            title:(NSString *)title
                       titleColor:(UIColor *)titleColor
                  backgroundImage:(UIImage *)backgroundImage
       highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage {

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    if (title)
        [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
    if (titleColor)
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    if (titleColor)
        [button setTitleColor:titleColor forState:UIControlStateHighlighted];

    return button;
}

@end
