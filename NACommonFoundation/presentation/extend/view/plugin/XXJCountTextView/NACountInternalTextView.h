//
//  NACountInternalTextView.h
//  NACommon
//
//  Created by giggity on 15/5/19.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NACountInternalTextView : UITextView

@property(nonatomic, strong) NSString *placeholder;
@property(nonatomic) int placeholderSize;
@property(nonatomic, strong) UIColor *placeholderColor;
@property(nonatomic) BOOL displayPlaceHolder;

@end
