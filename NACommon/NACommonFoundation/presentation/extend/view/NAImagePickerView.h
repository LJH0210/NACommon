//
//  NAUIImagePickerView.h
//  NACommon
//
//  Created by ND on 15/5/29.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NAImgPickerView.h"

@interface NAImagePickerView : NSObject

/**
 *  创建图片选择控件
 *
 *  @param frame      frame description
 *  @param limitCount 可选图片上限
 *  @allowsEditing  是否可编辑，YES为头像正方形模式，NO 全屏模式
 *  @return return NAImgPickerView对象
 */
+ (NAImgPickerView *)na_imagePickerWithFrame:(CGRect)frame limitCount:(int)limitCount allowsEditing:(BOOL)allowsEditing;

@end
