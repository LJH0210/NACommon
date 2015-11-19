//
//  UIButton+Quick.h
//  XXJCommon
//
//  Created by ND on 15/5/8.
//  Copyright (c) 2015年 xxjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (XXJQuick)

/**
 *  创建UIButton 背景图：backgroundImage 高亮背景图hightlightImage
 *
 *  @param frame          UIButton位置坐标
 *  @param image          UIButton正常状态下背景图片
 *  @param highlightImage UIButton高亮状态下背景图片
 *
 *  @return return 系统UIButton实例
 */
+ (UIButton *)xxj_buttonWithFrame:(CGRect)frame backgroundImage:(UIImage *)image highlightBackgroundImage:(UIImage *)highlightImage;

/**
 *  快速创建文字背景色UIButton  标题：title 背景颜色：backgroundColor 高亮背景色：backgroundHighlightedColor
 *
 *  @param frame          UIButton位置坐标
 *  @param title            UIButton标题，默认颜色：blackColor
 *  @param backgroundColor            UIButton背景颜色
 *  @param highlightedColor UIButton高亮背景颜色
 *
 *  @return return 系统UIButton实例
 */
+ (UIButton *)xxj_buttonWithFrame:(CGRect)frame
                            title:(NSString *)title
                  backgroundColor:(UIColor *)backgroundColor
       backgroundHighlightedColor:(UIColor *)highlightedColor;

/**
 *  快速创建文字背景图UIButton 标题：title 标题颜色：color 背景图：backgroundimage 高亮背景：backgoundhighlighted
 *
 *  @param frame          UIButton位置坐标
 *  @param title                      UIButton标题，默认颜色：blackColor
 *  @param color                       UIButton 正常状态下标题颜色
 *  @param backgroundImage            UIButton 正常状态下背景图片
 *  @param highlightedBackgroundImage Button 高亮状态背景图片
 *  @return return 系统UIButton实例
 */
+ (UIButton *)xxj_buttonWithFrame:(CGRect)frame
                            title:(NSString *)title
                       titleColor:(UIColor *)color
                  backgroundImage:(UIImage *)backgroundImage
       highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage;

@end
