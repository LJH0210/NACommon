//
//  NAAlertView.h
//  NACommon
//  正方形聚焦
//  Created by ND on 15/8/14.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NAFocusView : UIView

@property(nonatomic, assign, getter=isFocused) BOOL focused;
@property(nonatomic, assign) Class focalPointViewClass;
@property(nonatomic, assign) NSTimeInterval focusDuration;
@property(nonatomic, strong) NSArray *focii;

- (CGRect)focusOnView:(UIView *)view;
- (NSArray *)focus:(UIView *)views, ... NS_REQUIRES_NIL_TERMINATION;
- (NSArray *)focusOnViews:(NSArray *)views;
- (void)dismiss:(void (^)())completion;
//相对位置失败后自定义位置
- (CGRect)focus:(UIView *)view center:(CGPoint)center;
- (CGRect)focusWithView:(UIView *)view rect:(CGRect)rect;
@end
