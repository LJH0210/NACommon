//
//  UIView+NAKit.h
//  Common
//
//  Created by ND on 15/4/30.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property(nonatomic) CGFloat NA_left;
@property(nonatomic) CGFloat NA_top;
@property(nonatomic) CGFloat NA_right;
@property(nonatomic) CGFloat NA_bottom;
@property(nonatomic) CGFloat NA_width;
@property(nonatomic) CGFloat NA_height;
@property(nonatomic) CGFloat NA_centerX;
@property(nonatomic) CGFloat NA_centerY;
@property(nonatomic, readonly) CGPoint NA_boundCenter;
@property(nonatomic, readonly) CGFloat NA_ttScreenX;
@property(nonatomic, readonly) CGFloat NA_ttScreenY;
@property(nonatomic, readonly) CGFloat NA_screenViewX;
@property(nonatomic, readonly) CGFloat NA_screenViewY;
@property(nonatomic, readonly) CGRect NA_screenFrame;
@property(nonatomic) CGPoint NA_origin;
@property(nonatomic) CGSize NA_size;
@property(nonatomic, readonly) CGFloat NA_orientationWidth;
@property(nonatomic, readonly) CGFloat NA_orientationHeight;

/**
 *  remove uiview's subview with tag
 *
 *  @param tag view tag
 */

- (void)NA_removeTagView:(int)tag;

@end
