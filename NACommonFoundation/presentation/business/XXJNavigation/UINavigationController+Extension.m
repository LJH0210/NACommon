//
//  UINavigationController+Extension.m
//  NACommon
//
//  Created by ND on 15/8/28.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "UINavigationController+Extension.h"
#import "NANavigationBar.h"

@implementation UINavigationController (Extension)

- (instancetype)initWithNavigationBarClass:(Class)navigationBarClass style:(NANavigationBarStyle)style {
    if (self = [[UINavigationController alloc] initWithNavigationBarClass:navigationBarClass toolbarClass:nil]) {
        ((NANavigationBar *)self.navigationBar).NABarStyle = style;
    }
    return self;
}

- (void)changeNavigationBarStyle:(NANavigationBarStyle)style {
    [((NANavigationBar *)self.navigationController.navigationBar)changeNADefaultNavigationBarStyle:style];
}

+ (void)changeALLNavigationBarStyle:(NANavigationBarStyle)style {
    [NANavigationBar changeALLNavigationBarStyle:style];
}

@end
