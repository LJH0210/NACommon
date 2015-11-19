//
//  NAMoneyTextField.h
//  Common
//
//  Created by ND on 15/5/7.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UITextFieldValueDidChangedBlock)(NSString *inputString);

@interface NANumberTextField : UITextField <UITextFieldDelegate>

@property(nonatomic, copy) UITextFieldValueDidChangedBlock valueChangeBlock;
@property(nonatomic, strong) NSString *seperation;
@property(nonatomic, strong) UIColor *seperationColor;
@property(nonatomic, strong) UIFont *seperationFont;
@property(nonatomic, strong) NSString *rightSeperation;
@property(nonatomic, strong) UIColor *rightSeperationColor;
@property(nonatomic, strong) UIFont *rightSeperationFont;

/**
 *  UITextField 左侧显示seperation
 *
 *  @param frame           frame description
 *  @param seperation      左侧标识符
 *  @param seperationColor 标识符颜色
 *  @param numLength       numLength 输入长度
 *  @param decimalBounds   decimalBounds 小数位长度
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame textLength:(int)numLength decimalBounds:(int)decimalBounds;

+ (BOOL)isValidateNumber:(NSString *)string numLength:(int)numLength decimalBounds:(int)decimalBounds;

@end
