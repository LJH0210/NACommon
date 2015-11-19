//
//  UIButton+Extension.h
//  NACommon
//
//  Created by ND on 15/5/8.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIButton (Extension)
/**
 *  设置UIButton 正常状态title颜色  高亮状态title颜色
 *
 *  @param color            正常状态title颜色
 *  @param highlightedColor 高亮状态title颜色
 */
- (void)NA_setTitleColor:(UIColor *)color highlightedColor:(UIColor *)highlightedColor;

/**
 *  设置UIButton 圆角 边框宽度 边框颜色
 *
 *  @param cornerRadius 圆角幅度  <=0时不设置
 *  @param bordColor    边框颜色
 *  @param bordWidth    边框宽度
 */
- (void)NA_setCornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)bordColor borderWidth:(CGFloat)bordWidth;

/**
 *  设置UIButton关联OBJC对象
 *
 *  @param obj OBJC对象
 */
- (void)NA_setNAButtonAssociatedObject:(id)obj;

/**
 *  返回UIButton关联对象
 *
 *  @return return OBJC对象
 */
- (id)NA_getNAButtonAssociatedObject;

@end
