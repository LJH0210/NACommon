//
//  NAAlertView.h
//  NACommon
//
//  Created by ND on 15/8/14.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIAlertView+Input.h"

@interface NAAlertView : NSObject

+ (UIAlertView *)NA_alertViewStylePlainTextInputWithTitle:(NSString *)title
                                                   message:(NSString *)message
                                              defaultValue:(NSString *)defaultValue
                                         cancelButtonTitle:(NSString *)cancelButtonTitle
                                         otherButtonTitles:(NSArray *)otherButtons
                                                 onDismiss:(DismissTextInputBLock)dismissed
                                                  onCancel:(CancelBlock)cancelled;

+ (UIAlertView *)NA_alertViewStylePlainTextInputWithTitle:(NSString *)title
                                                   message:(NSString *)message
                                               placeholder:(NSString *)placehoder
                                              keyboardType:(UIKeyboardType)keyboardType
                                         cancelButtonTitle:(NSString *)cancelButtonTitle
                                         otherButtonTitles:(NSArray *)otherButtons
                                                 onDismiss:(DismissTextInputBLock)dismissed
                                                  onCancel:(CancelBlock)cancelled;

+ (UIAlertView *)NA_alertViewStylePlainTextInputWithTitle:(NSString *)title
                                                   message:(NSString *)message
                                              defaultValue:(NSString *)defaultValue
                                              keyboardType:(UIKeyboardType)keyboardType
                                         cancelButtonTitle:(NSString *)cancelButtonTitle
                                         otherButtonTitles:(NSArray *)otherButtons
                                                 onDismiss:(DismissTextInputBLock)dismissed
                                                  onCancel:(CancelBlock)cancelled;

@end
