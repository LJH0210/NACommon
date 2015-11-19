//
//  UIImage+NAKit.h
//  Common
//
//  Created by ND on 15/5/4.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  创建纯色UIImage
 *
 *  @param color 图片颜色
 *
 *  @return UIImage实例
 */
+ (UIImage *)NA_imageWithColor:(UIColor *)color;

/**
 *  创建纯色UIImage
 *
 *  @param color 图片颜色
 *
 *  @param size 图片大小
 *  @return UIImage实例
 */
+ (UIImage *)NA_imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  创建屏幕截图 UIImage
 *
 *  @return UIImage实例
 */
+ (UIImage *)NA_screenShot;

/**
 *  获取图片位于CGRect坐标内的图片
 *
 *  @param rect 位置坐标
 *
 *  @return UIImage实例
 */
- (UIImage *)NA_imageAtRect:(CGRect)rect;

/**
 *  通过幅度对UIImage实例进行旋转
 *
 *  @param radians 幅度
 *
 *  @return UIImage实例
 */
- (UIImage *)NA_imageRotatedByRadians:(CGFloat)radians;
/**
 *  通过角度旋转UIImage
 *
 *  @param  degrees 角度
 *
 *  @return UIImage实例
 */
- (UIImage *)NA_imageRotatedByDegrees:(CGFloat)degrees;

@end
