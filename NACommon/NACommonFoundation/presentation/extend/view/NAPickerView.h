//
//  NAUIPickerView.h
//  NACommon
//
//  Created by ND on 15/5/26.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NAPickerMenu.h"

@interface NAPickerView : NSObject

/**
 *  创建单列UIPickerView isFullStyle:YES -- 背景透明黑，点击自动消失
 *
 *  @param array            array description
 *  @param leftTitle        左侧按钮标题
 *  @param leftBlock        左侧标题点击block
 *  @param rightTitle       右侧标题
 *  @param rightBlock       右侧标题点击block
 *  @param valueChangeBlock UIPickerView 值变化
 *  @param isfull           是否是全屏模式
 *
 *  @return NAPickerMenu对象
 */
+ (NAPickerMenu *)na_pickerViewWithMenuArray:(NSArray *)array
                                  leftToolTile:(NSString *)leftTitle
                                 leftToolBlock:(NAPickerMenuArrayLeftToolBlock)leftBlock
                                rightToolTitle:(NSString *)rightTitle
                                rightToolBlock:(NAPickerMenuArrayRightToolBlock)rightBlock
                              valueChangeBlock:(NAPickerMenuArrayValueChangedBlock)valueChangeBlock
                                  isFullStyple:(BOOL)isfull;

/**
 *  创建多列不联动UIPickerView（数据格式：@[NSArray,NSArray]）  isFullStyle:YES -- 背景透明黑，点击自动消失
 *
 *  @param array            数据格式：@[NSArray,NSArray]
 *  @param leftTitle        左侧按钮标题
 *  @param leftBlock        左侧标题点击block
 *  @param rightTitle       右侧标题
 *  @param rightBlock       右侧标题点击block
 *  @param valueChangeBlock UIPickerView 值变化
 *  @param isfull           是否是全屏模式
 *
 *  @return NAPickerMenu对象
 */
+ (NAPickerMenu *)na_pickerViewWithMutiArray:(NSArray *)array
                                  leftToolTile:(NSString *)leftTitle
                                 leftToolBlock:(NAPickerMutiArrayLeftToolBlock)leftBlock
                                rightToolTitle:(NSString *)rightTitle
                                rightToolBlock:(NAPickerMutiArrayRightToolBlock)rightBlock
                              valueChangeBlock:(NAPickerMutiArrayValueChangedBlock)valueChangeBlock
                                  isFullStyple:(BOOL)isfull;

/**
 *  创建多级联动UIPickerView 数据格式@{ @"key1" :@[] , @"key2":@[] }
 *
 *  @param dic              数据格式@{ @"key1" :@[] , @"key2":@[] }
 *  @param leftTitle        左侧按钮标题
 *  @param leftBlock        左侧标题点击block
 *  @param rightTitle       右侧标题
 *  @param rightBlock       右侧标题点击block
 *  @param valueChangeBlock UIPickerView 值变化
 *  @param isfull           是否是全屏模式
 *
 *  @return NAPickerMenu对象
 */
+ (NAPickerMenu *)na_pickerViewWithMultiDictionary:(NSDictionary *)dic
                                        leftToolTile:(NSString *)leftTitle
                                       leftToolBlock:(NAPickerMultiArrayCustomLeftToolBlock)leftBlock
                                      rightToolTitle:(NSString *)rightTitle
                                      rightToolBlock:(NAPickerMultiArrayCustomRightToolBlock)rightBlock
                                    valueChangeBlock:(NAPickerMultiArrayCustomValueChangedBlock)valueChangeBlock
                                        isFullStyple:(BOOL)isfull;

@end
