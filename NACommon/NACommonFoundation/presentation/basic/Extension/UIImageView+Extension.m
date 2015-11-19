//
//  UIImageView+Extension.m
//  NACommon
//
//  Created by ND on 15/6/16.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)

- (void)NA_setImageShadowColor:(UIColor *)color radius:(CGFloat)radius offset:(CGSize)offset opacity:(CGFloat)opacity {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowRadius = radius;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.clipsToBounds = NO;
}

@end
