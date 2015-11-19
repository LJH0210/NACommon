//
//  NANavigationBar.m
//  NACommon
//
//  Created by ND on 15/8/28.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NANavigationBar.h"

@interface NANavigationBar ()

@end

@implementation NANavigationBar

- (instancetype)init {
    if (self = [super init]) {
        [self initBarView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initBarView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initBarView];
    }
    return self;
}

- (void)initBarView {
    [self changeNADefaultNavigationBarStyle:_NABarStyle];
}

- (void)setNABarStyle:(NANavigationBarStyle)NABarStyle {
    if (_NABarStyle != NABarStyle) {
        _NABarStyle = NABarStyle;
        [self changeNADefaultNavigationBarStyle:NABarStyle];
    }
}

- (void)changeNADefaultNavigationBarStyle:(NANavigationBarStyle)style {
    if (style == NANavigationBarDefault) {
        [self setBarTintColor:[UIColor colorWithRed:43.0 / 255 green:178.0 / 255 blue:216.0 / 255 alpha:1]];
        [self setTitleTextAttributes:@{UITextAttributeTextColor : [UIColor whiteColor]}];
    } else if (style == NANavigationBarBlack) {
        [self setBarTintColor:[UIColor blackColor]];
    }
}

+ (void)changeALLNavigationBarStyle:(NANavigationBarStyle)style {
    if (style == NANavigationBarDefault) {
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:43.0 / 255 green:178.0 / 255 blue:216.0 / 255 alpha:1]];
        [[UINavigationBar appearance] setTitleTextAttributes:@{UITextAttributeTextColor : [UIColor whiteColor]}];
    } else if (style == NANavigationBarBlack) {
        [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    }
}

@end
