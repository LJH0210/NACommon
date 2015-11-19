//
//  NAPathButton.h
//  NACommon
//
//  Created by ND on 15/6/4.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^NAPathButtonButtonClickBlock)(NSInteger index, UIButton *button);

typedef NS_ENUM(NSInteger, NAPathButtonStyle) { NAPathButtonDefault, NAPathButtonStyleRight, NAPathButtonStyleLeft };

@interface NAPathButton : UIButton

@property(assign, nonatomic) NAPathButtonStyle style;

/**
 *  点击展开按钮是否自动收缩，默认YES
 */
@property(assign, nonatomic) BOOL autoShrink;
/**
 *  圆半径，默认 40
 */
@property(assign, nonatomic) int radiusR;

/**
 *  创建PathButton
 *
 *  @param frame          frame
 *  @param backimage      PathButton 中央按钮背景图
 *  @param highlightedImg PathButton 中央按钮高亮背景
 *
 *  @return NAPathButton实例
 */
- (NAPathButton *)initWithFrame:(CGRect)frame centerBackgroundImg:(UIImage *)backimage centerHighlightedImg:(UIImage *)highlightedImg;

- (void)addExtendButtons:(NSArray *)buttons extendButtonClick:(NAPathButtonButtonClickBlock)buttonClick;

@end
