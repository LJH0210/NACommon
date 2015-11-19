//
//  UITextField+XXJQuick.h
//  XXJCommon
//
//  Created by ND on 15/5/8.
//  Copyright (c) 2015年 xxjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (XXJQuick)

/**
 *  快速创建UITextField frame、size
 *
 *  @param frame       UITextField frame
 *  @param size        UITextField 文本字体大小
 *
 *  @return 系统UITextField实例
 */
+ (UITextField *)xxj_textFieldWithFrame:(CGRect)frame size:(float)size;
/**
 *  快速创建UITextField frame、placeHolder、color、size
 *
 *  @param frame       UITextField frame
 *  @param placeholder UITextField 描述输入值文本
 *  @param color       UITextField 文本颜色
 *  @param size        UITextField 文本字体大小
 *  @param delegate    UITextField 委托
 *
 *  @return 系统UITextField实例
 */
+ (UITextField *)xxj_textFieldWithFrame:(CGRect)frame
                            placeholder:(NSString *)placeholder
                                  color:(UIColor *)color
                                   size:(float)size
                               delegate:(id<UITextFieldDelegate>)delegate;

/**
 *  快速创建UITextField frame placeholder textcolor textsize keyboardType
 *
 *  @param frame        UITextField frame
 *  @param placeholder  UITextField 描述输入值文本
 *  @param color        UITextField 文本颜色
 *  @param size         UITextField 文本字体大小
 *  @param keyboardType UITextField 键盘类型
 *  @param delegate     UITextField 委托
 *
 *  @return 系统UITextField实例
 */
+ (UITextField *)xxj_textFieldWithFrame:(CGRect)frame
                            placeholder:(NSString *)placeholder
                                  color:(UIColor *)color
                                   size:(float)size
                           keyboardType:(UIKeyboardType)keyboardType
                               delegate:(id<UITextFieldDelegate>)delegate;

@end
