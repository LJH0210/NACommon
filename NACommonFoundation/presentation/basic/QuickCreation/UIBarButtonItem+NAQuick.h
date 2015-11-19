//
//  UIBarButtonItem+XXJQuick.h
//  XXJCommon
//
//  Created by ND on 15/5/8.
//  Copyright (c) 2015年 xxjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XXJQuick)

/**
 *  快速创建兼容iOS6 UIBarButtonItem  背景：backgroundImge、 高亮背景：highlightedImage
 *
 *  @param frame            UIBarButtonItem内customView-UIButton frame
 *  @param image            UIBarButtonItem内customView-UIButton 正常状态背景图
 *  @param highlightedImage UIBarButtonItem内customView-UIButton 高亮状态背景图
 *  @param target           UIBarButtonItem内customView-UIButton 响应目标
 *  @param action           UIBarButtonItem内customView-UIButton 响应事件
 *
 *  @return UIBarButtonItem 实例
 */
+ (UIBarButtonItem *)xxj_barButtonItemWithFrame:(CGRect)frame
                                backgroundImage:(UIImage *)image
                               highlightedImage:(UIImage *)highlightedImage
                                         target:(id)target
                                         action:(SEL)action;

/**
 *  快速创建兼容iOS6 UIBarButtonItem  标题：title 标题颜色titleColor 高亮标题：titleHighlightColor
 *
 *  @param frame               UIBarButtonItem内customView-UIButton frame
 *  @param title               UIBarButtonItem内customView-UIButton 标题
 *  @param titlecolor          UIBarButtonItem内customView-UIButton 标题颜色
 *  @param titleHighlightColor UIBarButtonItem内customView-UIButton 高亮标题颜色
 *  @param target              UIBarButtonItem内customView-UIButton 响应目标
 *  @param action              UIBarButtonItem内customView-UIButton 响应事件
 *
 *  @return UIBarButtonItem 实例
 */
+ (UIBarButtonItem *)xxj_barButtonItemWithFrame:(CGRect)frame
                                          title:(NSString *)title
                                     titleColor:(UIColor *)titlecolor
                            titleHighlightColor:(UIColor *)titleHighlightColor
                                         target:(id)target
                                         action:(SEL)action;

/**
 *  快速创建兼容iOS6 UIBarButtonItem ：frame title titlecolor titleHighlightColor image highlightedImage
 *
 *  @param frame               UIBarButtonItem内customView-UIButton frame
 *  @param title               UIBarButtonItem内customView-UIButton 标题
 *  @param titlecolor          UIBarButtonItem内customView-UIButton 正常状态标题颜色
 *  @param titleHighlightColor UIBarButtonItem内customView-UIButton 高亮状态标题颜色
 *  @param image               UIBarButtonItem内customView-UIButton 背景图片
 *  @param highlightedImage    UIBarButtonItem内customView-UIButton 高亮背景图片
 *  @param target              UIBarButtonItem内customView-UIButton 响应目标
 *  @param action              UIBarButtonItem内customView-UIButton 响应事件
 *
 *  @return UIBarButtonItem 实例
 */
+ (UIBarButtonItem *)xxj_barButtonItemWithFrame:(CGRect)frame
                                          title:(NSString *)title
                                     titleColor:(UIColor *)titlecolor
                            titleHighlightColor:(UIColor *)titleHighlightColor
                                backgroundImage:(UIImage *)image
                               highlightedImage:(UIImage *)highlightedImage
                                         target:(id)target
                                         action:(SEL)action;

@end
