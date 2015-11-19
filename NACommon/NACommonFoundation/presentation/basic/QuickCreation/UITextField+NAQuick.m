//
//  UITextField+XXJQuick.m
//  XXJCommon
//
//  xxj_initd by ND on 15/5/8.
//  Copyright (c) 2015年 xxjia. All rights reserved.
//

#import "UITextField+XXJQuick.h"

@implementation UITextField (XXJQuick)

+ (UITextField *)xxj_textFieldWithFrame:(CGRect)frame
                                   size:(float)size{
    return [UITextField xxj_textFieldWithFrame:frame placeholder:@"" color:[UIColor blackColor] size:size delegate:nil];
}

+ (UITextField *)xxj_textFieldWithFrame:(CGRect)frame
                            placeholder:(NSString *)placeholder
                                  color:(UIColor *)color
                                   size:(float)size
                               delegate:(id<UITextFieldDelegate>)delegate {
    return [UITextField xxj_textFieldWithFrame:frame
                                   placeholder:placeholder
                                         color:color
                                          size:size
                                    returnType:UIReturnKeyDefault
                                  keyboardType:UIKeyboardTypeDefault
                                        secure:NO
                                   borderStyle:UITextBorderStyleRoundedRect
                            autoCapitalization:UITextAutocapitalizationTypeNone
                            keyboardAppearance:UIKeyboardAppearanceDefault
                 enablesReturnKeyAutomatically:NO
                               clearButtonMode:UITextFieldViewModeWhileEditing
                            autoCorrectionType:UITextAutocorrectionTypeDefault
                                      delegate:delegate];
}

+ (UITextField *)xxj_textFieldWithFrame:(CGRect)frame
                            placeholder:(NSString *)placeholder
                                  color:(UIColor *)color
                                   size:(float)size
                           keyboardType:(UIKeyboardType)keyboardType
                               delegate:(id<UITextFieldDelegate>)delegate {
    return [UITextField xxj_textFieldWithFrame:frame
                                   placeholder:placeholder
                                         color:color
                                          size:size
                                    returnType:UIReturnKeyDefault
                                  keyboardType:keyboardType
                                        secure:NO
                                   borderStyle:UITextBorderStyleRoundedRect
                            autoCapitalization:UITextAutocapitalizationTypeNone
                            keyboardAppearance:UIKeyboardAppearanceDefault
                 enablesReturnKeyAutomatically:NO
                               clearButtonMode:UITextFieldViewModeWhileEditing
                            autoCorrectionType:UITextAutocorrectionTypeDefault
                                      delegate:delegate];
}

+ (UITextField *)xxj_textFieldWithFrame:(CGRect)frame
                            placeholder:(NSString *)placeholder
                                  color:(UIColor *)color
                                   size:(float)size
                             returnType:(UIReturnKeyType)returnType
                           keyboardType:(UIKeyboardType)keyboardType
                                 secure:(BOOL)secure
                            borderStyle:(UITextBorderStyle)borderStyle
                     autoCapitalization:(UITextAutocapitalizationType)capitalization
                     keyboardAppearance:(UIKeyboardAppearance)keyboardAppearence
          enablesReturnKeyAutomatically:(BOOL)enablesReturnKeyAutomatically
                        clearButtonMode:(UITextFieldViewMode)clearButtonMode
                     autoCorrectionType:(UITextAutocorrectionType)autoCorrectionType
                               delegate:(id<UITextFieldDelegate>)delegate {
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    [textField setBorderStyle:borderStyle];
    [textField setAutocorrectionType:autoCorrectionType];
    [textField setClearButtonMode:clearButtonMode];
    [textField setKeyboardType:keyboardType];
    [textField setAutocapitalizationType:capitalization];
    [textField setPlaceholder:placeholder];
    [textField setTextColor:color];
    [textField setReturnKeyType:returnType];
    [textField setEnablesReturnKeyAutomatically:enablesReturnKeyAutomatically];
    [textField setSecureTextEntry:secure];
    [textField setKeyboardAppearance:keyboardAppearence];
    [textField setFont:[UIFont systemFontOfSize:size]];
    [textField setDelegate:delegate];

    return textField;
}

@end
