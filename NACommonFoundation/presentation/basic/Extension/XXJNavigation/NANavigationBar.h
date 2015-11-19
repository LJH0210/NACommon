//
//  XXJNavigationBar.h
//  XXJCommon
//
//  Created by ND on 15/8/28.
//  Copyright (c) 2015年 xxjia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationController+Extension.h"

@interface XXJNavigationBar : UINavigationBar

@property(nonatomic, assign) XXJNavigationBarStyle xxjBarStyle;

- (void)changeXXJDefaultNavigationBarStyle:(XXJNavigationBarStyle)style;
+ (void)changeALLNavigationBarStyle:(XXJNavigationBarStyle)style;

@end
