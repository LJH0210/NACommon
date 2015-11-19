//
//  UITextView+XXJQuick.m
//  XXJCommon
//
//  Created by ND on 15/5/8.
//  Copyright (c) 2015年 xxjia. All rights reserved.
//

#import "UITextView+XXJQuick.h"

@implementation UITextView (XXJQuick)

+ (UITextView *)xxj_textViewWithFrame:(CGRect)frame
                                 size:(float)size
                            alignment:(NSTextAlignment)alignment
                           returnType:(UIReturnKeyType)returnType
                             delegate:(id<UITextViewDelegate>)delegate {
    return [UITextView xxj_lazyWithFrame:frame
                                   color:[UIColor blackColor]
                                    size:size
                               alignment:alignment
                       dataDetectorTypes:UIDataDetectorTypeNone
                                editable:YES
                              selectable:YES
                              returnType:returnType
                            keyboardType:UIKeyboardTypeDefault
                                  secure:NO
                      autoCapitalization:UITextAutocapitalizationTypeNone
                      keyboardAppearance:UIKeyboardAppearanceDefault
           enablesReturnKeyAutomatically:YES
                      autoCorrectionType:UITextAutocorrectionTypeDefault
                                delegate:delegate];
}

+ (UITextView *)xxj_lazyWithFrame:(CGRect)frame
                            color:(UIColor *)color
                             size:(float)size
                        alignment:(NSTextAlignment)alignment
                dataDetectorTypes:(UIDataDetectorTypes)dataDetectorTypes
                         editable:(BOOL)editable
                       selectable:(BOOL)selectable
                       returnType:(UIReturnKeyType)returnType
                     keyboardType:(UIKeyboardType)keyboardType
                           secure:(BOOL)secure
               autoCapitalization:(UITextAutocapitalizationType)capitalization
               keyboardAppearance:(UIKeyboardAppearance)keyboardAppearence
    enablesReturnKeyAutomatically:(BOOL)enablesReturnKeyAutomatically
               autoCorrectionType:(UITextAutocorrectionType)autoCorrectionType
                         delegate:(id<UITextViewDelegate>)delegate {
    UITextView *textView = [[UITextView alloc] initWithFrame:frame];
    [textView setAutocorrectionType:autoCorrectionType];
    [textView setTextAlignment:alignment];
    [textView setKeyboardType:keyboardType];
    [textView setAutocapitalizationType:capitalization];
    [textView setTextColor:color];
    [textView setReturnKeyType:returnType];
    [textView setEnablesReturnKeyAutomatically:enablesReturnKeyAutomatically];
    [textView setSecureTextEntry:secure];
    [textView setKeyboardAppearance:keyboardAppearence];
    [textView setFont:[UIFont systemFontOfSize:size]];
    [textView setDelegate:delegate];
    [textView setDataDetectorTypes:dataDetectorTypes];
    [textView setEditable:editable];
    [textView setSelectable:selectable];

    return textView;
}

@end
