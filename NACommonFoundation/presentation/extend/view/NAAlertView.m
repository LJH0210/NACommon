//
//  NAAlertView.m
//  NACommon
//
//  Created by ND on 15/8/14.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NAAlertView.h"

@implementation NAAlertView

+ (UIAlertView *)NA_alertViewStylePlainTextInputWithTitle:(NSString *)title
                                                   message:(NSString *)message
                                              defaultValue:(NSString *)defaultValue
                                         cancelButtonTitle:(NSString *)cancelButtonTitle
                                         otherButtonTitles:(NSArray *)otherButtons
                                                 onDismiss:(DismissTextInputBLock)dismissed
                                                  onCancel:(CancelBlock)cancelled {
    return [UIAlertView alertViewStylePlainTextInputWithTitle:title
                                                      message:message
                                                 defaultValue:defaultValue
                                            cancelButtonTitle:cancelButtonTitle
                                            otherButtonTitles:otherButtons
                                                    onDismiss:dismissed
                                                     onCancel:cancelled];
}

+ (UIAlertView *)NA_alertViewStylePlainTextInputWithTitle:(NSString *)title
                                                   message:(NSString *)message
                                               placeholder:(NSString *)placehoder
                                              keyboardType:(UIKeyboardType)keyboardType
                                         cancelButtonTitle:(NSString *)cancelButtonTitle
                                         otherButtonTitles:(NSArray *)otherButtons
                                                 onDismiss:(DismissTextInputBLock)dismissed
                                                  onCancel:(CancelBlock)cancelled {
    return [UIAlertView alertViewStylePlainTextInputWithTitle:title
                                                      message:message
                                                  placeholder:placehoder
                                                 keyboardType:keyboardType
                                            cancelButtonTitle:cancelButtonTitle
                                            otherButtonTitles:otherButtons
                                                    onDismiss:dismissed
                                                     onCancel:cancelled];
}

+ (UIAlertView *)NA_alertViewStylePlainTextInputWithTitle:(NSString *)title
                                                   message:(NSString *)message
                                              defaultValue:(NSString *)defaultValue
                                              keyboardType:(UIKeyboardType)keyboardType
                                         cancelButtonTitle:(NSString *)cancelButtonTitle
                                         otherButtonTitles:(NSArray *)otherButtons
                                                 onDismiss:(DismissTextInputBLock)dismissed
                                                  onCancel:(CancelBlock)cancelled {
    return [UIAlertView alertViewStylePlainTextInputWithTitle:title
                                                      message:message
                                                 defaultValue:defaultValue
                                                 keyboardType:keyboardType
                                            cancelButtonTitle:cancelButtonTitle
                                            otherButtonTitles:otherButtons
                                                    onDismiss:dismissed
                                                     onCancel:cancelled];
}

@end
