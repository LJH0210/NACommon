//
//  InvalidAfterClickedButton.h
//  zxl_new
//  点击之后， x秒内不能再次点击的按钮(时间 持久保存)
//  Created by csj on 13-8-20.
//  Copyright (c) 2013年 eu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NAInvalidAfterClickedButton : UIButton {
}

@property(retain, nonatomic) UIColor *textWarmColor;
@property(retain, nonatomic) UIColor *textWarmHighlightedColor;

// disable状态下的标题
- (void)setAttributeTitle:(NSAttributedString *)enableTitle
              enableImage:(NSString *)enableImage
             disableImage:(NSString *)disableImage
             disableTitle:(NSString *)disableTitle;

- (void)setEnableTitle:(NSString *)enableTitle enableImage:(NSString *)enableImage disableImage:(NSString *)disableImage disableTitle:(NSString *)disableTitle;
//开始计时
- (void)startTimer;

@end
