//
//  NAUITextField.m
//  NACommon
//
//  Created by ND on 15/5/20.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NATextField.h"

@implementation NATextField

+ (NAMobileTextField *)NA_mobileTextWithFrame:(CGRect)frame seperation:(NSString *)seperate valueChange:(UITextFieldValueDidChangedBlock)valueChanged {
    NAMobileTextField *textField = [[NAMobileTextField alloc] initWithFrame:frame sepertaion:seperate valueChangeBlock:valueChanged];
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [textField setKeyboardType:UIKeyboardTypePhonePad];
    [textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [textField setSecureTextEntry:NO];
    [textField setKeyboardAppearance:UIKeyboardAppearanceDefault];
    return textField;
}

+ (NANumberTextField *)NA_numberTextWithFrame:(CGRect)frame
                                     textLength:(int)textlength
                                  decimalBounds:(int)decimalBounds
                                    valueChange:(UITextFieldValueDidChangedBlock)valueChanged {
    NANumberTextField *field = [[NANumberTextField alloc] initWithFrame:frame textLength:textlength decimalBounds:decimalBounds];
    [field setValueChangeBlock:valueChanged];
    [field setBorderStyle:UITextBorderStyleRoundedRect];
    [field setClearButtonMode:UITextFieldViewModeWhileEditing];
    [field setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [field setSecureTextEntry:NO];
    [field setKeyboardAppearance:UIKeyboardAppearanceDefault];
    return field;
}

@end
