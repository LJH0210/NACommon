//
//  UIAlertView+Input.m
//  91Beauty
//
//  Created by  on 5/20/15.
//  Copyright (c) 2015 NA. All rights reserved.
//

#import "UIAlertView+Input.h"

static DismissBlock _dismissBlock;
static CancelBlock _cancelBlock;
static DismissTextInputBLock _textInputDismissBlock;

@implementation UIAlertView (Input)

+ (UIAlertView *)alertViewStylePlainTextInputWithTitle:(NSString *)title
                                               message:(NSString *)message
                                          defaultValue:(NSString *)defaultValue
                                     cancelButtonTitle:(NSString *)cancelButtonTitle
                                     otherButtonTitles:(NSArray *)otherButtons
                                             onDismiss:(DismissTextInputBLock)dismissed
                                              onCancel:(CancelBlock)cancelled {

    return [UIAlertView alertViewStylePlainTextInputWithTitle:title
                                                      message:message
                                                 defaultValue:defaultValue
                                                 keyboardType:UIKeyboardTypeDefault
                                            cancelButtonTitle:cancelButtonTitle
                                            otherButtonTitles:otherButtons
                                                    onDismiss:dismissed
                                                     onCancel:cancelled];
}

+ (UIAlertView *)alertViewStylePlainTextInputWithTitle:(NSString *)title
                                               message:(NSString *)message
                                           placeholder:(NSString *)placehoder
                                          keyboardType:(UIKeyboardType)keyboardType
                                     cancelButtonTitle:(NSString *)cancelButtonTitle
                                     otherButtonTitles:(NSArray *)otherButtons
                                             onDismiss:(DismissTextInputBLock)dismissed
                                              onCancel:(CancelBlock)cancelled {

    _cancelBlock = cancelled;

    _textInputDismissBlock = [dismissed copy];

    UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:title message:message delegate:(id)[self class] cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert textFieldAtIndex:0].placeholder = placehoder;
    [alert textFieldAtIndex:0].keyboardType = keyboardType;

    for (NSString *buttonTitle in otherButtons)
        [alert addButtonWithTitle:buttonTitle];

    [alert show];
    return alert;
}

+ (UIAlertView *)alertViewStylePlainTextInputWithTitle:(NSString *)title
                                               message:(NSString *)message
                                          defaultValue:(NSString *)defaultValue
                                          keyboardType:(UIKeyboardType)keyboardType
                                     cancelButtonTitle:(NSString *)cancelButtonTitle
                                     otherButtonTitles:(NSArray *)otherButtons
                                             onDismiss:(DismissTextInputBLock)dismissed
                                              onCancel:(CancelBlock)cancelled {

    _cancelBlock = cancelled;

    _textInputDismissBlock = [dismissed copy];

    UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:title message:message delegate:(id)[self class] cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert textFieldAtIndex:0].text = defaultValue;
    [alert textFieldAtIndex:0].keyboardType = keyboardType;

    for (NSString *buttonTitle in otherButtons)
        [alert addButtonWithTitle:buttonTitle];

    [alert show];
    return alert;
}

+ (void)releaseBlock {
    _cancelBlock = ^() {
    };
    _dismissBlock = ^(int btnidx) {
    };
    _textInputDismissBlock = ^(UITextField *tf, int buttonIndex) {
    };
}

+ (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView.alertViewStyle == UIAlertViewStylePlainTextInput) {
        if (buttonIndex == [alertView cancelButtonIndex]) {
            if (_cancelBlock) {
                _cancelBlock();
            }
        } else {
            if (_textInputDismissBlock) {
                _textInputDismissBlock([alertView textFieldAtIndex:0], buttonIndex - 1); // cancel button is button 0
            }
        }
        [UIAlertView releaseBlock];
        return;
    }

    if (buttonIndex == [alertView cancelButtonIndex]) {
        if (_cancelBlock) {
            _cancelBlock();
        }
    } else {
        if (_dismissBlock) {
            _dismissBlock(buttonIndex - 1); // cancel button is button 0
        }
    }

    [UIAlertView releaseBlock];
}

@end
