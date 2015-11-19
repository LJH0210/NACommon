//
//  UILabel+XXJQuick.h
//  XXJCommon
//
//  Created by ND on 15/5/8.
//  Copyright (c) 2015年 xxjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (XXJQuick)

/**
 *  快速创建UILabel frame textsize alignment
 *
 *  @param frame     UILabel frame
 *  @param size      UILabel文本字体大小
 *  @param alignment UILabel文字对齐方式
 *
 *  @return 系统UILabel实例
 */
+ (UILabel *)xxj_labelWithFrame:(CGRect)frame size:(CGFloat)size alignment:(NSTextAlignment)alignment;

/**
 *  快速创建UILabel frame size color alignment lines
 *
 *  @param frame     UILabel frame
 *  @param size      UILabel文本字体大小
 *  @param color     UILabel文本颜色，默认blackColor
 *  @param alignment UILabel文字对齐方式
 *  @param lines     UILabel行数
 *
 *  @return 系统UILabel实例
 */
+ (UILabel *)xxj_labelWithFrame:(CGRect)frame size:(CGFloat)size color:(UIColor *)color alignment:(NSTextAlignment)alignment lines:(NSInteger)lines;

@end
