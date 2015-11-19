//
//  UITextView+XXJQuick.h
//  XXJCommon
//
//  Created by ND on 15/5/8.
//  Copyright (c) 2015年 xxjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (XXJQuick)

/**
 *  快速创建UITextView frame size NSTextAlignment UIReturnKeyType
 *
 *  @param frame      frame
 *  @param size       size 字体大小
 *  @param alignment  alignment 对齐方式
 *  @param returnType returnType 返回键类型
 *  @param delegate   delegate 委托
 *
 *  @return UITextView实例
 */

+ (UITextView *)xxj_textViewWithFrame:(CGRect)frame
                                 size:(float)size
                            alignment:(NSTextAlignment)alignment
                           returnType:(UIReturnKeyType)returnType
                             delegate:(id<UITextViewDelegate>)delegate;

@end
