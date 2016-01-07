//
//  NAUITextView.h
//  NACommon
//
//  Created by ND on 15/5/26.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NACountTextView.h"

@interface NATextView : NSObject

/**
*  限制字数输入框  无法使用uitextviewdelegate
*
*  @param frame            位置
*  @param placeHolder      辅助提示信息
*  @param maxCount         支持最大字数
*  @param placeHolderSize  辅助信息大小
*  @param placeHolderColor 辅助信息颜色
*  @param valueChanged     值变化Block
*
*  @return NACountTextView实例
*/

+ (NACountTextView *)na_textViewWithFrame:(CGRect)frame
                                placeHolder:(NSString *)placeHolder
                                   maxCount:(NSInteger)maxCount
                            placeHolderSize:(int)placeHolderSize
                           placeHolderColor:(UIColor *)placeHolderColor
                                valueChange:(UITextViewValueDidChangedBlock)valueChanged;

@end
