//
//  UIImageView+Extension.h
//  NACommon
//
//  Created by ND on 15/6/16.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)

/**
 *  为UIImageView添加阴影
 *
 *  @param color   阴影颜色
 *  @param radius  阴影幅度
 *  @param offset  shadowOffset阴影偏移,x向右偏移4，y向下偏移4
 *  @param opacity 阴影透明度
 */
- (void)NA_setImageShadowColor:(UIColor *)color radius:(CGFloat)radius offset:(CGSize)offset opacity:(CGFloat)opacity;

@end
