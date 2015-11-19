//
//  NADatePickerMenu.h
//  NACommon
//
//  Created by ND on 15/5/11.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^NAPickerMenuDateValueChangedBlock)(NSString *result);
typedef void (^NAPickerMenuDateLeftToolBlock)(NSString *result);
typedef void (^NAPickerMenuDateRightToolBlock)(NSString *result);

@interface NADatePickerMenu : UIControl

@property(nonatomic, strong) UIDatePicker *datePickerView;
@property(nonatomic, strong) UIButton *leftTool;
@property(nonatomic, strong) UIButton *rightTool;


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
 *  @return
 */
+ (NADatePickerMenu *)viewWithDate:(NSDate *)date
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
+ (NADatePickerMenu *)viewWithDate:(NSDate *)date
                  valueChangedBlock:(NAPickerMenuDateValueChangedBlock)changed
                               mode:(UIDatePickerMode)mode
                        isFullStyle:(BOOL)isfull;

+ (void)show;

+ (void)dismiss;

+ (void)setLeftTitleColor:(UIColor *)leftColor rightTitleColor:(UIColor *)rightColor;

@end
