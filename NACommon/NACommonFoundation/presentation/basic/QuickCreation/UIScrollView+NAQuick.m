//
//  UIScrollView+XXJKit.m
//  Common
//
//  Created by ND on 15/4/30.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import "UIScrollView+XXJQuick.h"

@implementation UIScrollView (XXJQuick)

+ (UIScrollView *)xxj_scrollWithFrame:(CGRect)frame
                          contentSize:(CGSize)contentSize
                        pagingEnabled:(BOOL)pagingEnabled
                             delegate:(id<UIScrollViewDelegate>)delegate {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    [scrollView setDelegate:delegate];
    [scrollView setPagingEnabled:pagingEnabled];
    [scrollView setContentSize:contentSize];
    scrollView.backgroundColor = [UIColor clearColor];
    return scrollView;
}

@end
