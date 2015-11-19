//
//  UINavigationController+Extension.h
//  XXJCommon
//
//  Created by ND on 15/8/28.
//  Copyright (c) 2015年 xxjia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XXJNavigationBarStyle) {
    XXJNavigationBarDefault // default
};

@interface UINavigationController (Extension)

- (instancetype)initWithNavigationBarClass:(Class)navigationBarClass style:(XXJNavigationBarStyle)style;

- (void)changeNavigationBarStyle:(XXJNavigationBarStyle)style;

+ (void)changeALLNavigationBarStyle:(XXJNavigationBarStyle)style;

@end
