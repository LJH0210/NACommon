//
//  NAAlertView.h
//  NACommon
//
//  Created by ND on 15/8/14.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NASpotlightView.h"

@implementation NASpotlightView

#pragma mark - MDCFocalPointView Overrides

- (id)initWithFocalView:(UIView *)focalView {
    self = [super initWithFocalView:focalView];
    if (self) {
        CGRect focalRect = focalView.frame;

        CGFloat margin = MAX(focalRect.size.width, focalRect.size.height);
        self.frame =
            CGRectMake(focalRect.origin.x - margin / 2, focalRect.origin.y - margin / 2, focalRect.size.width + margin, focalRect.size.height + margin);
    }
    return self;
}

#pragma mark - UIView Overrides

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    CGFloat locations[3] = {0.0f, 0.5f, 1.0f};
    CFArrayRef colors = (__bridge CFArrayRef)
        @[ (__bridge id)[UIColor clearColor].CGColor, (__bridge id)[UIColor clearColor].CGColor, (__bridge id)self.superview.backgroundColor.CGColor ];

    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, colors, locations);

    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    CGFloat radius = MIN(rect.size.width / 2, rect.size.height / 2);
    CGContextDrawRadialGradient(context, gradient, center, 0, center, radius, kCGGradientDrawsAfterEndLocation);

    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

@end
