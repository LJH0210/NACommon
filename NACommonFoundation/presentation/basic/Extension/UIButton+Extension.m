//
//  UIButton+Extension.m
//  NACommon
//
//  Created by ND on 15/5/8.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>

static char NAButtonAssociatedObjectKey;

@implementation UIButton (Extension)

- (void)dealloc {
    objc_setAssociatedObject(self, &NAButtonAssociatedObjectKey, nil, OBJC_ASSOCIATION_ASSIGN);
}

- (void)NA_setTitleColor:(UIColor *)color highlightedColor:(UIColor *)highlightedColor {
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:highlightedColor forState:UIControlStateHighlighted];
}

- (void)NA_setCornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)bordColor borderWidth:(CGFloat)bordWidth {
    if (cornerRadius > 0) {
        self.layer.cornerRadius = cornerRadius;
    }
    if (bordColor) {
        self.layer.borderColor = bordColor.CGColor;
    }
    if (bordWidth > 0) {
        self.layer.borderWidth = bordWidth;
    }
}

- (void)NA_setNAButtonAssociatedObject:(id)obj {
    objc_setAssociatedObject(self, &NAButtonAssociatedObjectKey, obj, OBJC_ASSOCIATION_ASSIGN);
}

- (id)NA_getNAButtonAssociatedObject {
    return objc_getAssociatedObject(self, &NAButtonAssociatedObjectKey);
}

@end
