//
//  NAUITextField.h
//  NACommon
//
//  Created by ND on 15/5/20.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NAMobileTextField.h"
#import "NANumberTextField.h"

@interface NATextField : NSObject

/**
 *  手机号码输入框  seperation：分隔符 格式：3-4-4
 *
 *  @param seperate     自定义分隔符
 *  @param frame        frame description
 *  @param placeholder  placeholder description
 *  @param color        color description
 *  @param size         size description
 *  @param valueChanged 输入变化时变化block
 *
 *  @return NAMobileTextField实例
 */
+ (NAMobileTextField *)na_mobileTextWithFrame:(CGRect)frame seperation:(NSString *)seperate valueChange:(UITextFieldValueDidChangedBlock)valueChanged;

/**
 *  数字输入框  NANumberTextField.seperation  左侧标识符  NANumberTextField.rightSeperation 右侧标识符
 *
 *  @param frame         frame description
 *  @param textlength    小数点前位数
 *  @param decimalBounds 小数点后位数
 *  @param valueChanged  值变化block
 *
 *  @return NANumberTextField实例
 */

+ (NANumberTextField *)na_numberTextWithFrame:(CGRect)frame
                                     textLength:(int)textlength
                                  decimalBounds:(int)decimalBounds
                                    valueChange:(UITextFieldValueDidChangedBlock)valueChanged;

@end
