//
//  UITextField+Extension.m
//  NACommon
//
//  Created by ND on 15/5/8.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)

- (NSRange)NA_selectedRange {
    UITextPosition *beginning = self.beginningOfDocument;

    UITextRange *selectedRange = self.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd = selectedRange.end;

    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];

    return NSMakeRange(location, length);
}

- (void)NA_setSelectedRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;

    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];

    [self setSelectedTextRange:selectionRange];
}

@end
