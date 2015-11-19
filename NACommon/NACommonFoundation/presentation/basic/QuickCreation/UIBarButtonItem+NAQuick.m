//
//  UIBarButtonItem+XXJQuick.m
//  XXJCommon
//
//  Created by ND on 15/5/8.
//  Copyright (c) 2015年 xxjia. All rights reserved.
//

#import "UIBarButtonItem+XXJQuick.h"

@implementation UIBarButtonItem (XXJQuick)

+ (UIBarButtonItem *)xxj_barButtonItemWithFrame:(CGRect)frame
                                          title:(NSString *)title
                                     titleColor:(UIColor *)titlecolor
                            titleHighlightColor:(UIColor *)titleHighlightColor
                                backgroundImage:(UIImage *)image
                               highlightedImage:(UIImage *)highlightedImage
                                         target:(id)target
                                         action:(SEL)action {
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (image)
        [bt setBackgroundImage:image forState:UIControlStateNormal];
    if (highlightedImage)
        [bt setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    title ? [bt setTitle:title forState:UIControlStateNormal] : [bt setTitle:@"" forState:UIControlStateNormal];
    if (titlecolor)
        [bt setTitleColor:titlecolor forState:UIControlStateNormal];
    if (titleHighlightColor)
        [bt setTitleColor:titleHighlightColor forState:UIControlStateHighlighted];
    bt.frame = frame;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:bt];
    return item;
}

+ (UIBarButtonItem *)xxj_barButtonItemWithFrame:(CGRect)frame
                                backgroundImage:(UIImage *)image
                               highlightedImage:(UIImage *)highlightedImage
                                         target:(id)target
                                         action:(SEL)action {
    return [UIBarButtonItem xxj_barButtonItemWithFrame:frame
                                                 title:nil
                                            titleColor:nil
                                   titleHighlightColor:nil
                                       backgroundImage:image
                                      highlightedImage:highlightedImage
                                                target:target
                                                action:action];
}

+ (UIBarButtonItem *)xxj_barButtonItemWithFrame:(CGRect)frame
                                          title:(NSString *)title
                                     titleColor:(UIColor *)titlecolor
                            titleHighlightColor:(UIColor *)titleHighlightColor
                                         target:(id)target
                                         action:(SEL)action {
    return [UIBarButtonItem xxj_barButtonItemWithFrame:frame
                                                 title:title
                                            titleColor:titlecolor
                                   titleHighlightColor:titleHighlightColor
                                       backgroundImage:nil
                                      highlightedImage:nil
                                                target:target
                                                action:action];
}

@end
