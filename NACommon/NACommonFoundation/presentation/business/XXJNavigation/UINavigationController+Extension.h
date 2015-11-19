//
//  UINavigationController+Extension.h
//  NACommon
//
//  Created by ND on 15/8/28.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NANavigationBarStyle) {
    NANavigationBarDefault, // default
    NANavigationBarBlack
};

@interface UINavigationController (Extension)

- (instancetype)initWithNavigationBarClass:(Class)navigationBarClass style:(NANavigationBarStyle)style;

- (void)changeNavigationBarStyle:(NANavigationBarStyle)style;

+ (void)changeALLNavigationBarStyle:(NANavigationBarStyle)style;

@end
