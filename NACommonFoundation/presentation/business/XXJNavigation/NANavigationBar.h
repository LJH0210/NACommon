//
//  NANavigationBar.h
//  NACommon
//
//  Created by ND on 15/8/28.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationController+Extension.h"

@interface NANavigationBar : UINavigationBar

@property(nonatomic, assign) NANavigationBarStyle NABarStyle;

- (void)changeNADefaultNavigationBarStyle:(NANavigationBarStyle)style;
+ (void)changeALLNavigationBarStyle:(NANavigationBarStyle)style;

@end
