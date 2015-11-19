//
//  NAAlertView.h
//  NACommon
//
//  Created by ND on 15/8/14.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NAFocusView.h"

#import "NAFocalPointView.h"
#import "NASpotlightView.h"

@interface NAFocusView ()

@end

@implementation NAFocusView

#pragma mark - Object Initialization

- (id)init {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    self = [super initWithFrame:keyWindow.frame];
    if (self) {
        _focusDuration = 0.5;
        _focalPointViewClass = [NAFocalPointView class];

        self.userInteractionEnabled = NO;
        self.opaque = NO;
        self.alpha = 0.0f;

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onApplicationDidChangeStatusBarOrientationNotification:)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

#pragma mark - UIView Overrides

- (void)drawRect:(CGRect)rect {
    [[UIColor clearColor] setFill];

    for (UIView *focus in self.focii) {
        UIRectFill(CGRectIntersection(focus.frame, rect));
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    for (NAFocalPointView *focus in self.focii) {
        if (CGRectContainsPoint(focus.frame, point)) {
            return focus.focalView;
        }
    }

    return self.isFocused ? self : nil;
}

#pragma mark - Public Interface

- (CGRect)focusOnView:(UIView *)view {
    if (view) {
        NSArray *ar = [self focusOnViews:@[ view ]];
        return CGRectFromString(ar.firstObject);
    }
    return CGRectZero;
}

- (NSArray *)focus:(UIView *)views, ... {
    NSMutableArray *focii = [NSMutableArray new];

    va_list viewList;
    va_start(viewList, views);
    for (UIView *view = views; view != nil; view = va_arg(viewList, UIView *)) {
        [focii addObject:view];
    }
    va_end(viewList);

    return [self focusOnViews:[focii copy]];
}

- (NSArray *)focusOnViews:(NSArray *)views {
    NSParameterAssert(views != nil);
    NSMutableArray *retarr = [NSMutableArray new];
    self.focused = YES;

    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self adjustRotation];

    NSMutableArray *focii = [NSMutableArray arrayWithCapacity:[views count]];

    for (UIView *view in views) {
        NAFocalPointView *focalPointView = [[self.focalPointViewClass alloc] initWithFocalView:view];
        [self addSubview:focalPointView];
        focalPointView.frame = [self convertRect:focalPointView.frame fromView:focalPointView.focalView.superview];

        [focii addObject:focalPointView];
        [retarr addObject:NSStringFromCGRect(focalPointView.frame)];
    }

    self.focii = [focii copy];
    [self setNeedsDisplay];

    [UIView animateWithDuration:self.focusDuration
        animations:^{
            self.alpha = 1.0f;
        }
        completion:^(BOOL finished) {
            self.userInteractionEnabled = YES;
        }];
    return retarr;
}

- (CGRect)focusWithView:(UIView *)view rect:(CGRect)rect {
    self.focused = YES;

    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self adjustRotation];

    NSMutableArray *focii = [NSMutableArray new];

    NAFocalPointView *focalPointView = [[self.focalPointViewClass alloc] initWithFocalView:view];
    [self addSubview:focalPointView];
    focalPointView.frame = rect;

    [focii addObject:focalPointView];

    self.focii = [focii copy];
    [self setNeedsDisplay];

    [UIView animateWithDuration:self.focusDuration
        animations:^{
            self.alpha = 1.0f;
        }
        completion:^(BOOL finished) {
            self.userInteractionEnabled = YES;
        }];
    return focalPointView.frame;
}

- (CGRect)focus:(UIView *)view center:(CGPoint)center {
    self.focused = YES;

    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self adjustRotation];

    NSMutableArray *focii = [NSMutableArray new];

    NAFocalPointView *focalPointView = [[self.focalPointViewClass alloc] initWithFocalView:view];
    [self addSubview:focalPointView];
    focalPointView.center = center;

    [focii addObject:focalPointView];

    self.focii = [focii copy];
    [self setNeedsDisplay];

    [UIView animateWithDuration:self.focusDuration
        animations:^{
            self.alpha = 1.0f;
        }
        completion:^(BOOL finished) {
            self.userInteractionEnabled = YES;
        }];
    return focalPointView.frame;
}

- (void)dismiss:(void (^)())completion {
    NSAssert(self.isFocused, @"Cannot dismiss when focus is not applied in the first place.");

    [UIView animateWithDuration:self.focusDuration
        animations:^{
            self.alpha = 0.0f;
        }
        completion:^(BOOL finished) {
            for (NAFocalPointView *view in self.focii) {
                [view removeFromSuperview];
            }
            self.focii = nil;

            self.userInteractionEnabled = NO;
            [self removeFromSuperview];

            self.focused = NO;

            if (completion) {
                completion();
            }
        }];
}

#pragma mark - Internal Methods

- (void)onApplicationDidChangeStatusBarOrientationNotification:(NSNotification *)notification {
    if (!self.isFocused) {
        return;
    }

    NSMutableArray *views = [NSMutableArray new];
    for (NAFocalPointView *focalPointView in self.focii) {
        [views addObject:focalPointView.focalView];
    }

    [self dismiss:^{
        [self adjustRotation];
        [self focusOnViews:[views copy]];
    }];
}

- (void)adjustRotation {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;

    CGFloat rotationAngle = 0.0f;
    switch (orientation) {
    case UIInterfaceOrientationPortrait:
    case UIInterfaceOrientationUnknown:
        rotationAngle = 0.0f;
        break;
    case UIInterfaceOrientationPortraitUpsideDown:
        rotationAngle = M_PI;
        break;
    case UIInterfaceOrientationLandscapeLeft:
        rotationAngle = -M_PI / 2.0f;
        break;
    case UIInterfaceOrientationLandscapeRight:
        rotationAngle = M_PI / 2.0f;
        break;
    }

    self.transform = CGAffineTransformMakeRotation(rotationAngle);
    self.frame = self.superview.frame;
}

@end
