//
//  UIView+NAKit.m
//  Common
//
//  Created by ND on 15/4/30.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (CGFloat)NA_left {
    return self.frame.origin.x;
}

- (void)setNA_left:(CGFloat)NA_left {
    CGRect frame = self.frame;
    frame.origin.x = NA_left;
    self.frame = frame;
}

- (CGFloat)NA_top {
    return self.frame.origin.y;
}

- (void)setNA_top:(CGFloat)NA_top {
    CGRect frame = self.frame;
    frame.origin.y = NA_top;
    self.frame = frame;
}

- (CGFloat)NA_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setNA_right:(CGFloat)NA_right {
    CGRect frame = self.frame;
    frame.origin.x = NA_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)NA_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setNA_bottom:(CGFloat)NA_bottom {
    CGRect frame = self.frame;
    frame.origin.y = NA_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)NA_centerX {
    return self.center.x;
}

- (void)setNA_centerX:(CGFloat)NA_centerX {
    self.center = CGPointMake(NA_centerX, self.center.y);
}

- (CGFloat)NA_centerY {
    return self.center.y;
}

- (void)setNA_centerY:(CGFloat)NA_centerY {
    self.center = CGPointMake(self.center.x, NA_centerY);
}

- (CGFloat)NA_width {
    return self.frame.size.width;
}

- (void)setNA_width:(CGFloat)NA_width {
    CGRect frame = self.frame;
    frame.size.width = NA_width;
    self.frame = frame;
}

- (CGFloat)NA_height {
    return self.frame.size.height;
}

- (void)setNA_height:(CGFloat)NA_height {
    CGRect frame = self.frame;
    frame.size.height = NA_height;
    self.frame = frame;
}

- (CGPoint)NA_boundCenter {
    return CGPointMake(self.NA_width / 2.0, self.NA_height / 2.0);
}

- (CGFloat)NA_ttScreenX {
    CGFloat x = 0;
    for (UIView *view = self; view; view = view.superview) {
        x += view.NA_left;
    }
    return x;
}

- (CGFloat)NA_ttScreenY {
    CGFloat y = 0;
    for (UIView *view = self; view; view = view.superview) {
        y += view.NA_top;
    }
    return y;
}

- (CGFloat)NA_screenViewX {
    CGFloat x = 0;
    for (UIView *view = self; view; view = view.superview) {
        x += view.NA_left;

        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)view;
            x -= scrollView.contentOffset.x;
        }
    }

    return x;
}

- (CGFloat)NA_screenViewY {
    CGFloat y = 0;
    for (UIView *view = self; view; view = view.superview) {
        y += view.NA_top;

        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}

- (CGRect)NA_screenFrame {
    return CGRectMake(self.NA_screenViewX, self.NA_screenViewY, self.NA_width, self.NA_height);
}

- (CGPoint)NA_origin {
    return self.frame.origin;
}

- (void)setNA_origin:(CGPoint)NA_origin {
    CGRect frame = self.frame;
    frame.origin = NA_origin;
    self.frame = frame;
}

- (CGSize)NA_size {
    return self.frame.size;
}

- (void)setNA_size:(CGSize)NA_size {
    CGRect frame = self.frame;
    frame.size = NA_size;
    self.frame = frame;
}

- (CGFloat)NA_orientationWidth {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? self.NA_height : self.NA_width;
}

- (CGFloat)NA_orientationHeight {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? self.NA_width : self.NA_height;
}

- (void)NA_removeTagView:(int)tag {
    for (UIView *vi in self.subviews) {
        if (vi.tag == tag) {
            [vi removeFromSuperview];
        }
    }
}

@end
