//
//  UITextField+Extension.h
//  NACommon
//
//  Created by ND on 15/5/8.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)

/**
 *  获取选择范围
 *
 *  @return <#return value description#>
 */
- (NSRange)NA_selectedRange;

/**
 *  设置选择范围
 *
 *  @param range <#range description#>
 */
- (void)NA_setSelectedRange:(NSRange)range;

@end
