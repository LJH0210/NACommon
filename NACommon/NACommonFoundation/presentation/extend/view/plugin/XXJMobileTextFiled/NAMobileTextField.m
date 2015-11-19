//
//  NAMobileTextField.m
//  Common
//
//  Created by ND on 15/5/6.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import "NAMobileTextField.h"
#import "NSString+NAFoundation.h"
#import <BlocksKit+UIKit.h>

@interface NAMobileTextField () <UITextFieldDelegate> {

    NSInteger _count;
    NSRange _currentRange;
    NSMutableString *_oldString;
}

@property(nonatomic, strong) NSString *seperation; //电话号码分隔符，默认无分隔符,不可重复设置

@end

@implementation NAMobileTextField

@synthesize seperation = _seperation, valueChangeBlock = _valueChangeBlock, delegate = _delegate;

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame sepertaion:(NSString *)seperation valueChangeBlock:(UITextFieldValueDidChangedBlock)valueChangeBlock {
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
        _seperation = [[NSString alloc] initWithString:seperation];
        _valueChangeBlock = valueChangeBlock;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self config];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self config];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

- (void)config {
    [self addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    _seperation = @"";
    _count = 0;
    _oldString = [[NSMutableString alloc] init];
    self.bk_shouldChangeCharactersInRangeWithReplacementStringBlock = ^(UITextField *textField, NSRange range, NSString *replacement) {
        if (textField.text.length > 12 && ![replacement isEqualToString:@""]) {
            return NO;
        } else {
            _currentRange = range;
            return YES;
        }
    };
}

- (void)textFieldValueChanged:(UITextField *)field {
    NSMutableString *str = [NSMutableString stringWithFormat:@"%@", field.text];

    if (_count > field.text.length) {
        //删除
        //        if ((count == 5 || count == 10) && [field.text rangeOfString:self.seperation].length == 2) {
        //            NSMutableString *str = [NSMutableString stringWithFormat:@"%@",field.text];
        //            field.text = [str substringToIndex:count - 2];
        //        }
        //删除的是空格
        if ([[_oldString stringByReplacingOccurrencesOfString:self.seperation withString:@""]
                isEqualToString:[field.text stringByReplacingOccurrencesOfString:self.seperation withString:@""]]) {
            [str replaceCharactersInRange:NSMakeRange(_currentRange.location - 1, 1) withString:@""];
            str = [[str stringByReplacingOccurrencesOfString:self.seperation withString:@""] mutableCopy];
            if (str.length >= 3)
                [str insertString:self.seperation atIndex:3];
            if (str.length >= 8)
                [str insertString:self.seperation atIndex:8];
            field.text = str;
            UITextPosition *beginning = field.beginningOfDocument;

            UITextPosition *startPosition = [field positionFromPosition:beginning offset:_currentRange.location - 1];

            UITextRange *selectionRange = [field textRangeFromPosition:startPosition toPosition:startPosition];

            [field setSelectedTextRange:selectionRange];
            _oldString = str;

        } else {
            str = [[str stringByReplacingOccurrencesOfString:self.seperation withString:@""] mutableCopy];
            if (str.length >= 3)
                [str insertString:self.seperation atIndex:3];
            if (str.length >= 8)
                [str insertString:self.seperation atIndex:8];
            field.text = str;
            UITextPosition *beginning = field.beginningOfDocument;

            UITextPosition *startPosition = [field positionFromPosition:beginning offset:_currentRange.location];

            UITextRange *selectionRange = [field textRangeFromPosition:startPosition toPosition:startPosition];

            [field setSelectedTextRange:selectionRange];

            _oldString = [[str stringByReplacingOccurrencesOfString:self.seperation withString:@""] mutableCopy];
        }

    } else if (_count < field.text.length) {
        //增加

        if (_currentRange.location == 2 || _currentRange.location == 7) {

            str = [[str stringByReplacingOccurrencesOfString:self.seperation withString:@""] mutableCopy];

            NSInteger offset = _currentRange.location + 2;
            if (str.length > 11) {
                offset -= 1;
                str = [[str stringByReplacingCharactersInRange:NSMakeRange(_currentRange.location - 1, 1) withString:@""] mutableCopy];
            }
            if (str.length >= 3)
                [str insertString:self.seperation atIndex:3];
            if (str.length >= 8)
                [str insertString:self.seperation atIndex:8];

            field.text = str;
            UITextPosition *beginning = field.beginningOfDocument;

            UITextPosition *startPosition = [field positionFromPosition:beginning offset:offset];

            UITextRange *selectionRange = [field textRangeFromPosition:startPosition toPosition:startPosition];

            [field setSelectedTextRange:selectionRange];
        } else {
            str = [[str stringByReplacingOccurrencesOfString:self.seperation withString:@""] mutableCopy];
            if (str.length >= 3)
                [str insertString:self.seperation atIndex:3];
            if (str.length >= 8)
                [str insertString:self.seperation atIndex:8];

            field.text = str;
            UITextPosition *beginning = field.beginningOfDocument;

            UITextPosition *startPosition = [field positionFromPosition:beginning offset:_currentRange.location + 1];

            UITextRange *selectionRange = [field textRangeFromPosition:startPosition toPosition:startPosition];

            [field setSelectedTextRange:selectionRange];
        }
        _oldString = str;
    }

    //通过count的值和当前的textField内容的长度比较，如果count大那么证明是删除，反之增加
    _count = field.text.length;
    if (_valueChangeBlock) {
        NSString *st = [NSString NA_retNotEmptyString:str defaultString:@""];
        _valueChangeBlock(st);
    }
}

- (NSRange)selectedRange:(UITextField *)field {
    UITextPosition *beginning = field.beginningOfDocument;
    UITextRange *selectedRange = field.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd = selectedRange.end;

    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];

    return NSMakeRange(location, length);
}

- (void)setSelectedRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;

    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];

    [self setSelectedTextRange:selectionRange];
}

- (BOOL)isPureInt:(NSString *)string {
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (void)paste:(id)sender {
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    NSString *str = [pboard string];
    unsigned long long num = [self findNumFromStr:str];
    pboard.string = [NSString stringWithFormat:@"%llu", num];
    [super paste:sender];
    [self textFieldValueChanged:self];
}

- (unsigned long long)findNumFromStr:(NSString *)originalString {
    // Intermediate
    NSMutableString *numberString = [[NSMutableString alloc] init];
    NSString *tempStr;
    NSScanner *scanner = [NSScanner scannerWithString:originalString];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];

    while (![scanner isAtEnd]) {
        // Throw away characters before the first number.
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        // Collect numbers.
        [scanner scanCharactersFromSet:numbers intoString:&tempStr];
        [numberString appendString:tempStr];
        tempStr = @"";
    }
    // Result.
    long long number = [numberString longLongValue];
    return number;
}

#pragma mark - getter setter
- (NSString *)seperation {
    if (_seperation == nil) {
        return @"";
    }
    return _seperation;
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate {
    if (!delegate) {
        [super setDelegate:delegate];
    }
}

- (void)setSeperation:(NSString *)seperation {
    if (_seperation) {
        return;
    }
    _seperation = [[NSString alloc] initWithString:seperation];
}

- (void)setValueChangeBlock:(UITextFieldValueDidChangedBlock)valueChangeBlock {
    if (_valueChangeBlock) {
        return;
    }
    _valueChangeBlock = valueChangeBlock;
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    [super setKeyboardType:UIKeyboardTypePhonePad];
}

@end
