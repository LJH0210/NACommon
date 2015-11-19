//
//  NACountInternalTextView.m
//  NACommon
//
//  Created by giggity on 15/5/19.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NACountInternalTextView.h"

@implementation NACountInternalTextView

- (void)setText:(NSString *)text {
    BOOL originalValue = self.scrollEnabled;
    [self setScrollEnabled:YES];
    [super setText:text];
    [self setScrollEnabled:originalValue];
}

- (void)setScrollable:(BOOL)isScrollable {
    [super setScrollEnabled:isScrollable];
}

- (void)setContentOffset:(CGPoint)s {
    if (self.tracking || self.decelerating) {
        UIEdgeInsets insets = self.contentInset;
        insets.bottom = 0;
        insets.top = 0;
        self.contentInset = insets;
    } else {
        float bottomOffset = (self.contentSize.height - self.frame.size.height + self.contentInset.bottom);
        if (s.y < bottomOffset && self.scrollEnabled) {
            UIEdgeInsets insets = self.contentInset;
            insets.bottom = 8;
            insets.top = 0;
            self.contentInset = insets;
        }
    }
    [super setContentOffset:s];
}

- (void)setContentInset:(UIEdgeInsets)s {
    UIEdgeInsets insets = s;
    if (s.bottom > 8)
        insets.bottom = 0;
    insets.top = 0;
    [super setContentInset:insets];
}

- (void)setContentSize:(CGSize)contentSize {
    if (self.contentSize.height > contentSize.height) {
        UIEdgeInsets insets = self.contentInset;
        insets.bottom = 0;
        insets.top = 0;
        self.contentInset = insets;
    }
    [super setContentSize:contentSize];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (_displayPlaceHolder && _placeholder && _placeholderColor) {
        [_placeholderColor set];
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:_placeholderSize], NSFontAttributeName,
                                                                              _placeholderColor, NSForegroundColorAttributeName, nil];
        CGRect frame = CGRectMake(8.0f, 8.0f, self.frame.size.width - 16.0f, self.frame.size.height - 16.0f);
        [_placeholder drawInRect:frame withAttributes:attributes];
    }
}

@end
