//
//  UIAlertView+Input.h
//  91Beauty
//
//  Created by  on 5/20/15.
//  Copyright (c) 2015 NA. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DismissTextInputBLock)(UITextField *tf, int buttonIndex);
typedef void (^DismissBlock)(int buttonIndex);
typedef void (^CancelBlock)();

@interface UIAlertView (Input)

+ (UIAlertView *)alertViewStylePlainTextInputWithTitle:(NSString *)title
                                               message:(NSString *)message
                                          defaultValue:(NSString *)defaultValue
                                     cancelButtonTitle:(NSString *)cancelButtonTitle
                                     otherButtonTitles:(NSArray *)otherButtons
                                             onDismiss:(DismissTextInputBLock)dismissed
                                              onCancel:(CancelBlock)cancelled;

+ (UIAlertView *)alertViewStylePlainTextInputWithTitle:(NSString *)title
                                               message:(NSString *)message
                                           placeholder:(NSString *)placehoder
                                          keyboardType:(UIKeyboardType)keyboardType
                                     cancelButtonTitle:(NSString *)cancelButtonTitle
                                     otherButtonTitles:(NSArray *)otherButtons
                                             onDismiss:(DismissTextInputBLock)dismissed
                                              onCancel:(CancelBlock)cancelled;

+ (UIAlertView *)alertViewStylePlainTextInputWithTitle:(NSString *)title
                                               message:(NSString *)message
                                          defaultValue:(NSString *)defaultValue
                                          keyboardType:(UIKeyboardType)keyboardType
                                     cancelButtonTitle:(NSString *)cancelButtonTitle
                                     otherButtonTitles:(NSArray *)otherButtons
                                             onDismiss:(DismissTextInputBLock)dismissed
                                              onCancel:(CancelBlock)cancelled;

@end
