//
//  UIScrollView+XXJKit.h
//  Common
//
//  Created by ND on 15/4/30.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (XXJQuick)

/**
 *  快速创建背景为透明的UIScrollView frame contentSize pagingEnable delegate
 *
 *  @param frame                ScrollView's frame
 *  @param contentSize          ScrollView 内容大小
 *  @param pagingEnabled        UIScrollview是否翻页
 *  @param delegate             委托
 *
 *  @return UIScrollView实例
 */
+ (UIScrollView *)xxj_scrollWithFrame:(CGRect)frame
                          contentSize:(CGSize)contentSize
                        pagingEnabled:(BOOL)pagingEnabled
                             delegate:(id<UIScrollViewDelegate>)delegate;

@end
