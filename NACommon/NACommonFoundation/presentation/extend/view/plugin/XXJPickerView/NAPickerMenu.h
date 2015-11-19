//
//  NAPickerMenu.h
//  NACommon
//
//  Created by ND on 15/5/12.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <UIKit/UIKit.h>

//单列pickview
typedef void (^NAPickerMenuArrayValueChangedBlock)(NSArray *menuArray, int row);
typedef void (^NAPickerMenuArrayLeftToolBlock)(NSArray *menuArray, int row);
typedef void (^NAPickerMenuArrayRightToolBlock)(NSArray *menuArray, int row);

//双列不联动pickview
typedef void (^NAPickerMutiArrayValueChangedBlock)(NSArray *menuArray, NSArray *arrCompomentsRow);
typedef void (^NAPickerMutiArrayLeftToolBlock)(NSArray *menuArray, NSArray *arrCompomentsRow);
typedef void (^NAPickerMutiArrayRightToolBlock)(NSArray *menuArray, NSArray *arrCompomentsRow);

//多列联动pickerview
typedef void (^NAPickerMultiArrayCustomValueChangedBlock)(NSDictionary *pickerViewData, NSDictionary *dicCompomentsRow);
typedef void (^NAPickerMultiArrayCustomLeftToolBlock)(NSDictionary *pickerViewData, NSDictionary *dicCompomentsRow);
typedef void (^NAPickerMultiArrayCustomRightToolBlock)(NSDictionary *pickerViewData, NSDictionary *dicCompomentsRow);

@interface NAPickerMenu : UIControl

@property(assign, nonatomic) BOOL isFullSyle;     //是否是全屏模式，全屏模式点击背景取消
@property(nonatomic, strong) UIButton *leftTool;  //左侧按钮
@property(nonatomic, strong) UIButton *rightTool; //右侧按钮

+ (NAPickerMenu *)viewWithMenuArray:(NSArray *)array
                        leftToolTile:(NSString *)leftTitle
                       leftToolBlock:(NAPickerMenuArrayLeftToolBlock)leftBlock
                      rightToolTitle:(NSString *)rightTitle
                      rightToolBlock:(NAPickerMenuArrayRightToolBlock)rightBlock
                    valueChangeBlock:(NAPickerMenuArrayValueChangedBlock)valueChangeBlock
                        isFullStyple:(BOOL)isfull;

+ (NAPickerMenu *)viewWithMutiArray:(NSArray *)array
                        leftToolTile:(NSString *)leftTitle
                       leftToolBlock:(NAPickerMutiArrayLeftToolBlock)leftBlock
                      rightToolTitle:(NSString *)rightTitle
                      rightToolBlock:(NAPickerMutiArrayRightToolBlock)rightBlock
                    valueChangeBlock:(NAPickerMutiArrayValueChangedBlock)valueChangeBlock
                        isFullStyple:(BOOL)isfull;

+ (NAPickerMenu *)viewWithMultiDictionary:(NSDictionary *)dic
                              leftToolTile:(NSString *)leftTitle
                             leftToolBlock:(NAPickerMultiArrayCustomLeftToolBlock)leftBlock
                            rightToolTitle:(NSString *)rightTitle
                            rightToolBlock:(NAPickerMultiArrayCustomRightToolBlock)rightBlock
                          valueChangeBlock:(NAPickerMultiArrayCustomValueChangedBlock)valueChangeBlock
                              isFullStyple:(BOOL)isfull;

+ (void)show;

+ (void)dismiss;

@end
