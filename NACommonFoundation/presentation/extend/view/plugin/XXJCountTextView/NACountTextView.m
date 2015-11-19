//
//  NACountTextView.m
//  NACommon
//
//  Created by ND on 15/5/11.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NACountTextView.h"

@interface NACountTextView () <UITextViewDelegate> {
    NSInteger _maxCount;
    NSString *_placeHolder;
    int _placeHolderSize;
    UIColor *_placeHolderColor;
    BOOL _displayPlaceHolder;
}

@end

@implementation NACountTextView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame
                  placeHolder:(NSString *)placeHolder
              placeHolderSize:(int)placeHolderSize
             placeHolderColor:(UIColor *)placeHolderColor
             valueChangeBlock:(UITextViewValueDidChangedBlock)valueChangeBlock {
    self = [super initWithFrame:frame];
    if (self) {
        _maxCount = 0;
        _placeHolder = placeHolder;
        _valueChangeBlock = valueChangeBlock;
        _placeHolderSize = placeHolderSize;
        _placeHolderColor = placeHolderColor;
        [self config];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                  placeHolder:(NSString *)placeHolder
              placeHolderSize:(int)placeHolderSize
             placeHolderColor:(UIColor *)placeHolderColor
                     maxCount:(NSInteger)maxCount
             valueChangeBlock:(UITextViewValueDidChangedBlock)valueChangeBlock {
    self = [super initWithFrame:frame];
    if (self) {
        _maxCount = maxCount;
        _placeHolder = placeHolder;
        _valueChangeBlock = valueChangeBlock;
        _placeHolderSize = placeHolderSize;
        _placeHolderColor = placeHolderColor;
        [self config];
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

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

- (void)config {
    self.delegate = self;
    _displayPlaceHolder = YES;
    CGRect frame = self.frame;
    frame.origin = CGPointMake(1, 1);
    _internalTextView = [[NACountInternalTextView alloc] initWithFrame:frame];
    _internalTextView.delegate = self;
    _internalTextView.scrollEnabled = YES;
    _internalTextView.font = [UIFont fontWithName:@"Helvetica" size:_placeHolderSize];
    _internalTextView.contentInset = UIEdgeInsetsZero;
    _internalTextView.showsHorizontalScrollIndicator = NO;
    _internalTextView.showsVerticalScrollIndicator = NO;
    _internalTextView.placeholder = _placeHolder;
    _internalTextView.placeholderColor = _placeHolderColor;
    _internalTextView.placeholderSize = _placeHolderSize;
    _internalTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _internalTextView.secureTextEntry = NO;
    _internalTextView.displayPlaceHolder = _displayPlaceHolder;
    _internalTextView.keyboardAppearance = UIKeyboardAppearanceDefault;
    [self addSubview:_internalTextView];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

- (void)textViewDidChange:(UITextView *)textView {

    NSString *toBeString = [NSString stringWithFormat:@"%@", textView.text];
    NSArray *currentar = [UITextInputMode activeInputModes];
    UITextInputMode *current = [currentar firstObject];
    if ([current.primaryLanguage isEqualToString:@"zh-Hans"]) {
        // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > _maxCount) {
                textView.text = [toBeString substringToIndex:_maxCount];
                //                    NSRange range;
                //                    range.location = textView.text.length;
                //                    range.length = 0;
                //                    textView.selectedRange = range;
                //此方法是我引入的第三方警告框.读者可以自己完成警告弹窗.
            }
        } // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else {
        }
    } // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else {
        if (toBeString.length > _maxCount) {
            textView.text = [toBeString substringToIndex:_maxCount];
        }
    }

    if (textView.text.length <= 0) {
        _internalTextView.displayPlaceHolder = YES;
        [_internalTextView setNeedsDisplay];
    } else {
        _internalTextView.displayPlaceHolder = NO;
        [_internalTextView setNeedsDisplay];
    }

    if (_valueChangeBlock) {
        _valueChangeBlock(_maxCount - textView.text.length);
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (_maxCount == 0) {
        return YES;
    }

    if (text.length + textView.text.length > _maxCount) {
        return NO;
    }

    return YES;
}

- (void)setDelegate:(id<UITextViewDelegate>)delegate {
    //    if (!self.delegate) {
    //        [super setDelegate:delegate];
    //    }
}

- (void)setValueChangeBlock:(UITextViewValueDidChangedBlock)valueChangeBlock {
    if (_valueChangeBlock) {
        return;
    }
    _valueChangeBlock = valueChangeBlock;
}

@end
