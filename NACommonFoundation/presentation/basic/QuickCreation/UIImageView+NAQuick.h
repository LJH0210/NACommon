//
//  UIImageView+XXJQuick.h
//  XXJCommon
//
//  Created by ND on 15/5/8.
//  Copyright (c) 2015年 xxjia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^XXJImageViewOnTappedBlock)();

@interface UIImageView (XXJQuick)

/**
 *  根据URL快速创建可点击UIImageView  图片地址：imageUrlString  默认图片：placeHolderImage 点击事件：onTappedBlock
 *
 *  @param frame            frame description
 *  @param imageUrlString   imageUrlString 图片地址
 *  @param placeholderImage placeholderImage 默认图片
 *  @param onTappedBlock    点击图片响应block
 *
 *  @return 系统UIImageView实例
 */
+ (UIImageView *)xxj_imageViewWithFrame:(CGRect)frame
                         imageUrlString:(NSString *)imageUrlString
                       placeholderImage:(UIImage *)placeholderImage
                          onTappedBlock:(XXJImageViewOnTappedBlock)onTappedBlock;

/**
 *  根据UIImage创建可点击的UIImageView 图片：image 点击事件：onTappedBlock
 *
 *  @param frame         frame description
 *  @param image         图片
 *  @param onTappedBlock 点击图片响应block
 *
 *  @return 系统UIImageView实例
 */
+ (UIImageView *)xxj_imageViewWithFrame:(CGRect)frame image:(UIImage *)image onTappedBlock:(XXJImageViewOnTappedBlock)onTappedBlock;

/**
 *  可点击的纯色UIImageView 背景颜色：backgroundColor 点击事件：onTappedBlock
 *
 *  @param frame           frame description
 *  @param backgroundColor UIImageView背景颜色
 *  @param onTappedBlock   点击图片响应block
 *
 *  @return 系统UIImageView实例
 */
+ (UIImageView *)xxj_imageViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor onTappedBlock:(XXJImageViewOnTappedBlock)onTappedBlock;

/**
 *  可点击的UIImageView image backgroundColor
 *
 *  @param frame           frame description
 *  @param image           图片
 *  @param backgroundColor 背景颜色
 *  @param onTappedBlock   点击图片响应block
 *
 *  @return 系统UIImageView实例
 */
+ (UIImageView *)xxj_imageViewWithFrame:(CGRect)frame
                                  image:(UIImage *)image
                        backgroundColor:(UIColor *)backgroundColor
                          onTappedBlock:(XXJImageViewOnTappedBlock)onTappedBlock;

@end
