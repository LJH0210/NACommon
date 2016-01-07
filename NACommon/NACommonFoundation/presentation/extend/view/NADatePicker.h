//
//  NAUIDatePicker.h
//  NACommon
//
//  Created by ND on 15/5/26.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NADatePickerMenu.h"

@interface NADatePicker : NSObject

/**
 *  创建日期选择器
 *
 *  @param date          选中日期
 *  @param mode          mode description
 *  @param leftToolTitle 左侧按钮 - title为空不响应 block
 *  @param leftBlock     左侧按钮block事件
 *  @param rightTitle    右侧按钮
 *  @param rightBlock    右侧block
 *  @param changed       value changed block
 *
 *  @return NADatePickerMenu
 */
+ (NADatePickerMenu *)na_viewWithDate:(NSDate *)date
                                   mode:(UIDatePickerMode)mode
                          leftToolTitle:(NSString *)leftToolTitle
                          leftToolBlock:(NAPickerMenuDateLeftToolBlock)leftBlock
                         rightToolTitle:(NSString *)rightTitle
                         rightToolBlock:(NAPickerMenuDateRightToolBlock)rightBlock
                      valueChangedBlock:(NAPickerMenuDateValueChangedBlock)changed
                            isFullStyle:(BOOL)isfull;

/**  
 *  创建日期选择器
 *
 *  @param date    选中日期
 *  @param changed changed block 该模式只响应滚动选择
 *  @param mode    mode description
 *
 *  @return
 */
+ (NADatePickerMenu *)na_viewWithDate:(NSDate *)date
                      valueChangedBlock:(NAPickerMenuDateValueChangedBlock)changed
                                   mode:(UIDatePickerMode)mode
                            isFullStyle:(BOOL)isfull;

@end
