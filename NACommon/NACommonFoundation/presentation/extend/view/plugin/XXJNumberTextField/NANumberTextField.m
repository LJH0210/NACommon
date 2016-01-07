//
//  NAMoneyTextField.m
//  Common
//
//  Created by ND on 15/5/7.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import "NANumberTextField.h"
#import "NSString+NAFoundation.h"
#import <BlocksKit+UIKit.h>

@interface NANumberTextField ()

@property(nonatomic, strong) UILabel *sepetationLabel;
@property(nonatomic, strong) UILabel *rightSeperationLabel;

@property(nonatomic, assign) __block int numLength;     //长度，包括小数位
@property(nonatomic, assign) __block int decimalBounds; //小数位数，默认0位,如果设置小于0将自动变为0

@end

@implementation NANumberTextField

@synthesize valueChangeBlock = _valueChangeBlock, seperation = _seperation, numLength = _numLength, sepetationLabel = _sepetationLabel;

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (instancetype)initWithFrame:(CGRect)frame
//               leftSeperation:(NSString *)leftseperation
//          leftSeperationColor:(UIColor *)leftseperationColor
//              rightSeperation:(NSString *)rightseperation
//         rightSeperationColor:(UIColor *)rightseperationColor
//                   textLength:(int)numLength
//                decimalBounds:(int)decimalBounds {
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self config];
//        self.seperation = [[NSString alloc] initWithString:leftseperation];
//        _seperationColor = leftseperationColor;
//        self.rightSeperation = [[NSString alloc] initWithString:rightseperation];
//        _rightSeperationColor = rightseperationColor;
//        _numLength = numLength;
//        decimalBounds >= 0 ? (_decimalBounds = decimalBounds) : (_decimalBounds = 0);
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame textLength:(int)numLength decimalBounds:(int)decimalBounds {
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
        _numLength = numLength;
        decimalBounds >= 0 ? (_decimalBounds = decimalBounds) : (_decimalBounds = 0);
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

    _seperationFont = [UIFont systemFontOfSize:8];
    _rightSeperationFont = [UIFont systemFontOfSize:8];

    if (!_sepetationLabel) {
        _sepetationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
    }
    _sepetationLabel.font = _seperationFont;
    _sepetationLabel.textColor = _seperationColor ? _seperationColor : [UIColor lightGrayColor];
    _sepetationLabel.backgroundColor = [UIColor clearColor];
    _sepetationLabel.textAlignment = NSTextAlignmentCenter;

    if (!_rightSeperationLabel) {
        _rightSeperationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
    }
    _rightSeperationLabel.font = _rightSeperationFont;
    _rightSeperationLabel.textColor = _rightSeperationColor ? _rightSeperationColor : [UIColor lightGrayColor];
    _rightSeperationLabel.backgroundColor = [UIColor clearColor];
    _rightSeperationLabel.textAlignment = NSTextAlignmentCenter;

    self.keyboardType = UIKeyboardTypeDecimalPad;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.leftView = _sepetationLabel;
    self.rightViewMode = UITextFieldViewModeAlways;
    self.rightView = _rightSeperationLabel;
    _decimalBounds = 0;

    __weak typeof(self) weakSelf = self;
    self.bk_shouldChangeCharactersInRangeWithReplacementStringBlock = ^(UITextField *textField, NSRange range, NSString *replacement) {
        __block NSString *st = [textField.text stringByReplacingCharactersInRange:range withString:replacement];
        BOOL shouldChange = [NANumberTextField isValidateNumber:st numLength:weakSelf.numLength decimalBounds:weakSelf.decimalBounds];
        if (shouldChange && weakSelf.valueChangeBlock) {
            weakSelf.valueChangeBlock(st);
        }
        return shouldChange;
    };
}
+ (BOOL)isValidateNumber:(NSString *)string numLength:(int)numLength decimalBounds:(int)decimalBounds {
    if (![NANumberTextField isPureInt:string] && ![NANumberTextField isPureFloat:string] && ![string isEqualToString:@""]) {
        return NO;
    }

    if (decimalBounds > 0) {
        if ([string na_containString:@"."]) {
            NSArray *re = [string componentsSeparatedByString:@"."];
            if (re.count == 2) {
                NSString *point = re.firstObject;
                if (point.length > numLength) {
                    return NO;
                }

                point = re.lastObject;
                if (point.length > decimalBounds) {
                    return NO;
                }
            }
        } else {
            if (string.length > numLength) {
                return NO;
            }
        }
    } else {
        if (![NANumberTextField isPureInt:string]) {
            return NO;
        }
        if (string.length > numLength) {
            return NO;
        }
    }
    return YES;
}

+ (BOOL)isPureInt:(NSString *)string {
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString *)string {
    NSScanner *scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _sepetationLabel.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
}

- (NSString *)seperation {
    if (_seperation == nil) {
        return @"";
    }
    return _seperation;
}

- (void)setNumLength:(int)numLength {
    if (numLength > 0) {
        return;
    }
    _numLength = numLength;
}

- (void)setSeperation:(NSString *)seperation {
    _seperation = [[NSString alloc] initWithString:seperation];
    if ([NSString na_isEmptyString:_seperation]) {
        _sepetationLabel.text = _seperation;
        _sepetationLabel.frame = CGRectZero;
    } else {
        _sepetationLabel.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
        _sepetationLabel.text = _seperation;
    }
}

- (void)setSeperationFont:(UIFont *)seperationFont {
    _seperationFont = seperationFont;
    _sepetationLabel.font = _seperationFont;
}

- (void)setRightSeperationFont:(UIFont *)rightSeperationFont {
    _rightSeperationFont = rightSeperationFont;
    _rightSeperationLabel.font = _rightSeperationFont;
}

- (void)setRightSeperation:(NSString *)rightSeperation {
    _rightSeperation = [[NSString alloc] initWithString:rightSeperation];
    if ([NSString na_isEmptyString:_rightSeperation]) {
        _rightSeperationLabel.text = _rightSeperation;
        _rightSeperationLabel.frame = CGRectZero;
    } else {
        _rightSeperationLabel.text = _rightSeperation;
        _rightSeperationLabel.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
    }
}

- (void)setValueChangeBlock:(UITextFieldValueDidChangedBlock)valueChangeBlock {
    if (_valueChangeBlock) {
        return;
    }
    _valueChangeBlock = valueChangeBlock;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(paste:)) {
        return NO;
    } else {
        return [super canPerformAction:action withSender:sender];
    }
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    [super setKeyboardType:UIKeyboardTypeDecimalPad];
}

@end
