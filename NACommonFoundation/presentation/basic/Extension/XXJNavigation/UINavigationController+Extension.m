//
//  UINavigationController+Extension.m
//  XXJCommon
//
//  Created by ND on 15/8/28.
//  Copyright (c) 2015年 xxjia. All rights reserved.
//

#import "UINavigationController+Extension.h"
#import "XXJNavigationBar.h"

@implementation UINavigationController (Extension)

- (instancetype)initWithNavigationBarClass:(Class)navigationBarClass style:(XXJNavigationBarStyle)style {
    if (self = [[UINavigationController alloc] initWithNavigationBarClass:navigationBarClass toolbarClass:nil]) {
        ((XXJNavigationBar *)self.navigationBar).xxjBarStyle = style;
    }
    return self;
}

- (void)changeNavigationBarStyle:(XXJNavigationBarStyle)style {
    [((XXJNavigationBar *)self.navigationController.navigationBar)changeXXJDefaultNavigationBarStyle:style];
}

+ (void)changeALLNavigationBarStyle:(XXJNavigationBarStyle)style {
    [XXJNavigationBar changeALLNavigationBarStyle:style];
}

@end
