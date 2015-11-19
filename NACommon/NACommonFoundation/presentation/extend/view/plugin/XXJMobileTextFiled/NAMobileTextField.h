//
//  NAMobileTextField.h
//  Common
//
//  Created by ND on 15/5/6.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UITextFieldValueDidChangedBlock)(NSString *inputString);

@interface NAMobileTextField : UITextField

@property(nonatomic, copy) UITextFieldValueDidChangedBlock valueChangeBlock; // UITextField 内容变化回调Block，不可重复设置

- (instancetype)initWithFrame:(CGRect)frame sepertaion:(NSString *)seperation valueChangeBlock:(UITextFieldValueDidChangedBlock)valueChangeBlock;

@end
