//
//  NAUITextView.m
//  NACommon
//
//  Created by ND on 15/5/26.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NATextView.h"

@implementation NATextView

+ (NACountTextView *)NA_textViewWithFrame:(CGRect)frame
                                placeHolder:(NSString *)placeHolder
                                   maxCount:(NSInteger)maxCount
                            placeHolderSize:(int)placeHolderSize
                           placeHolderColor:(UIColor *)placeHolderColor
                                valueChange:(UITextViewValueDidChangedBlock)valueChanged {
    NACountTextView *textView = [[NACountTextView alloc] initWithFrame:frame
                                                             placeHolder:placeHolder
                                                         placeHolderSize:placeHolderSize
                                                        placeHolderColor:placeHolderColor
                                                                maxCount:maxCount
                                                        valueChangeBlock:valueChanged];
    return textView;
}

@end
