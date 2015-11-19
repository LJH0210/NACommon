//
//  NAUISegmentedControl.m
//  NACommon
//
//  Created by ND on 15/5/26.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NASegmentedControl.h"

@implementation NASegmentedControl

+ (HMSegmentedControl *)NA_segmentedWithFrame:(CGRect)frame
                                        titles:(NSArray *)titles
                                    titleColor:(UIColor *)titleColor
                               backgroundColor:(UIColor *)backgroundcolor
                                indicatorColor:(UIColor *)indicatorColor
                                        target:(id)target
                                        action:(SEL)action {
    HMSegmentedControl *seg = [[HMSegmentedControl alloc] initWithSectionTitles:titles];
    [seg setFrame:frame];
    [seg setBackgroundColor:backgroundcolor];
    [seg setTextColor:titleColor];
    [seg setSelectionIndicatorColor:indicatorColor];
    [seg setSelectionIndicatorMode:HMSelectionIndicatorFillsSegment];
    [seg setSelectionIndicatorHeight:1];
    [seg addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    return seg;
}

+ (HMSegmentedControl *)NA_segmentedWithFrame:(CGRect)frame
                                        titles:(NSArray *)titles
                                    titleColor:(UIColor *)titleColor
                              highlightedColor:(UIColor *)highlightColor
                               backgroundColor:(UIColor *)backgroundcolor
                    backgroundHighlightedColor:(UIColor *)backhightlightedColor
                                        target:(id)target
                                        action:(SEL)action {
    HMSegmentedControl *seg = [[HMSegmentedControl alloc] initWithSectionTitles:titles];
    [seg setFrame:frame];
    [seg setBackgroundColor:backgroundcolor];
    [seg setTextColor:titleColor];
    [seg setTextHighlightedColor:highlightColor];
    [seg setSelectionIndicatorColor:[UIColor clearColor]];
    [seg setSelectionBackgroundColor:backhightlightedColor];
    [seg setSelectionIndicatorMode:HMSelectionIndicatorFillsSegment];
    [seg setSelectionIndicatorHeight:1];
    [seg addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    return seg;
}

@end
