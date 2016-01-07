//
//  NAUIPickerView.m
//  NACommon
//
//  Created by ND on 15/5/26.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NAPickerView.h"

@implementation NAPickerView

+ (NAPickerMenu *)na_pickerViewWithMenuArray:(NSArray *)array
                                  leftToolTile:(NSString *)leftTitle
                                 leftToolBlock:(NAPickerMenuArrayLeftToolBlock)leftBlock
                                rightToolTitle:(NSString *)rightTitle
                                rightToolBlock:(NAPickerMenuArrayRightToolBlock)rightBlock
                              valueChangeBlock:(NAPickerMenuArrayValueChangedBlock)valueChangeBlock
                                  isFullStyple:(BOOL)isfull {
    return [NAPickerMenu viewWithMenuArray:array
                               leftToolTile:leftTitle
                              leftToolBlock:leftBlock
                             rightToolTitle:rightTitle
                             rightToolBlock:rightBlock
                           valueChangeBlock:valueChangeBlock
                               isFullStyple:isfull];
}

+ (NAPickerMenu *)na_pickerViewWithMutiArray:(NSArray *)array
                                  leftToolTile:(NSString *)leftTitle
                                 leftToolBlock:(NAPickerMutiArrayLeftToolBlock)leftBlock
                                rightToolTitle:(NSString *)rightTitle
                                rightToolBlock:(NAPickerMutiArrayRightToolBlock)rightBlock
                              valueChangeBlock:(NAPickerMutiArrayValueChangedBlock)valueChangeBlock
                                  isFullStyple:(BOOL)isfull {
    return [NAPickerMenu viewWithMutiArray:array
                               leftToolTile:leftTitle
                              leftToolBlock:leftBlock
                             rightToolTitle:rightTitle
                             rightToolBlock:rightBlock
                           valueChangeBlock:valueChangeBlock
                               isFullStyple:isfull];
}

+ (NAPickerMenu *)na_pickerViewWithMultiDictionary:(NSDictionary *)dic
                                        leftToolTile:(NSString *)leftTitle
                                       leftToolBlock:(NAPickerMultiArrayCustomLeftToolBlock)leftBlock
                                      rightToolTitle:(NSString *)rightTitle
                                      rightToolBlock:(NAPickerMultiArrayCustomRightToolBlock)rightBlock
                                    valueChangeBlock:(NAPickerMultiArrayCustomValueChangedBlock)valueChangeBlock
                                        isFullStyple:(BOOL)isfull {
    return [NAPickerMenu viewWithMultiDictionary:dic
                                     leftToolTile:leftTitle
                                    leftToolBlock:leftBlock
                                   rightToolTitle:rightTitle
                                   rightToolBlock:rightBlock
                                 valueChangeBlock:valueChangeBlock
                                     isFullStyple:isfull];
}

@end
