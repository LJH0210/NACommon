//
//  NAUISegmentedControl.h
//  NACommon
//
//  Created by ND on 15/5/26.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMSegmentedControl.h"

@interface NASegmentedControl : NSObject

/**
 *  创建自定义的选择器，样式为：显示有颜色的indicator选择条
 *
 *  @param frame           control frame
 *  @param titles          titles
 *  @param titleColor      titles color
 *  @param backgroundcolor background color
 *  @param indicatorColor  选择条颜色
 *  @param font            font 字体大小
 *  @param action          action 响应UIControlStatesValueChanged
 *
 *  @return  uicontrol instance
 */
+ (HMSegmentedControl *)NA_segmentedWithFrame:(CGRect)frame
                                        titles:(NSArray *)titles
                                    titleColor:(UIColor *)titleColor
                               backgroundColor:(UIColor *)backgroundcolor
                                indicatorColor:(UIColor *)indicatorColor
                                        target:(id)target
                                        action:(SEL)action;

/**
 *  创建自定义的选择器，样式为：选中底色变化
 *
 *  @param frame                 control frame
 *  @param titles                titles
 *  @param titleColor            默认颜色
 *  @param highlightColor        选中后颜色
 *  @param backgroundcolor       背景颜色
 *  @param backhightlightedColor 选中后背景颜色
 *  @param font                  font
 *  @param action                action 响应UIControlStatesValueChanged
 *
 *  @return uicontrol instance
 */
+ (HMSegmentedControl *)NA_segmentedWithFrame:(CGRect)frame
                                        titles:(NSArray *)titles
                                    titleColor:(UIColor *)titleColor
                              highlightedColor:(UIColor *)highlightColor
                               backgroundColor:(UIColor *)backgroundcolor
                    backgroundHighlightedColor:(UIColor *)backhightlightedColor
                                        target:(id)target
                                        action:(SEL)action;
@end
