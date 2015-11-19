//
//  NAEmptyBackgroundView.h
//  Guide
//
//  Created by ND on 15/4/20.
//  Copyright (c) 2015年 nd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NAEmptyBackgroundView : UIView

- (void)setEmptyImg:(UIImage *)img;
- (void)setEmptyImg:(UIImage *)img size:(CGSize)size;

- (void)setEmptyString:(NSString *)str;

@end
