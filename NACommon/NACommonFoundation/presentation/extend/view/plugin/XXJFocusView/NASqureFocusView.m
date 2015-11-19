//
//  NASqureFocusView.m
//  NACommon
//
//  Created by ND on 15/8/25.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NASqureFocusView.h"
#import "NAFocusView.h"

@implementation NASqureFocusView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [[UIColor colorWithRed:0 green:0 blue:0 alpha:.8] set];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, 0);
    for (UIView *focus in super.focii) {

        CGPathAddRect(path, &transform, CGRectMake(focus.frame.origin.x, focus.frame.origin.y, focus.frame.size.width, focus.frame.size.height));
    }
    CGPathAddRect(path, &transform, self.frame);
    CGContextAddPath(context, path);
    CGContextEOFillPath(context);
}

@end
