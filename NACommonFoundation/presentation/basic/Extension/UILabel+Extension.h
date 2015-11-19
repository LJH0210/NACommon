//
//  UILabel+Extension.h
//  NACommon
//
//  Created by ND on 15/6/5.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

/**
 *  根据内容设置UILabel高度
 *
 *  @return 根据内容设置UILabel高度后，UILabel的Frame
 */
- (CGRect)NA_autoHeightSize;

@end
