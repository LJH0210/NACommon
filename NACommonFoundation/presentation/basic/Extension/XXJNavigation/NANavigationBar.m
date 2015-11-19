//
//  XXJNavigationBar.m
//  XXJCommon
//
//  Created by ND on 15/8/28.
//  Copyright (c) 2015年 xxjia. All rights reserved.
//

#import "XXJNavigationBar.h"
#import "UIImage+Extension.h"

@interface XXJNavigationBar ()

@end

@implementation XXJNavigationBar

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
    [self changeXXJDefaultNavigationBarStyle:_xxjBarStyle];
}

- (void)changeXXJDefaultNavigationBarStyle:(XXJNavigationBarStyle)style {
    if (style == XXJNavigationBarDefault) {
        [self setBarTintColor:[UIColor whiteColor]];
    }
}

+ (void)changeALLNavigationBarStyle:(XXJNavigationBarStyle)style {
    if (style == XXJNavigationBarDefault) {
        [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    }
}

@end
