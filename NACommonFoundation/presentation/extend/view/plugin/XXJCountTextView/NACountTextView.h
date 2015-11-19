//
//  NACountTextView.h
//  NACommon
//
//  Created by ND on 15/5/11.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NACountInternalTextView.h"

typedef void (^UITextViewValueDidChangedBlock)(NSInteger remain);

@interface NACountTextView : UIView <UITextViewDelegate> {
    NACountInternalTextView *_internalTextView;
}

@property(nonatomic, copy) UITextViewValueDidChangedBlock valueChangeBlock;

- (instancetype)initWithFrame:(CGRect)frame
                  placeHolder:(NSString *)placeHolder
              placeHolderSize:(int)placeHolderSize
             placeHolderColor:(UIColor *)placeHolderColor
             valueChangeBlock:(UITextViewValueDidChangedBlock)valueChangeBlock;

- (instancetype)initWithFrame:(CGRect)frame
                  placeHolder:(NSString *)placeHolder
              placeHolderSize:(int)placeHolderSize
             placeHolderColor:(UIColor *)placeHolderColor
                     maxCount:(NSInteger)maxCount
             valueChangeBlock:(UITextViewValueDidChangedBlock)valueChangeBlock;

@end
