//
//  ISImgPickerView.h
//  Guide
//
//  Created by LJH on 15/3/14.
//  Copyright (c) 2015年 nd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NAImgPickerDelegate <NSObject>

- (void)NAImgPickerDidAddImg;
- (void)NAImgPickerDidDelImg;

@end

@interface NAImgPickerView : UIView

@property(assign, nonatomic) id<NAImgPickerDelegate> delegate;
//选中结果图片集
@property(retain, nonatomic) NSMutableArray *arrImgs;
//图片限制
@property(assign, nonatomic) int imgCount;
//提示名称
@property(strong, nonatomic) NSString *strWarm;
//是否可编辑，NO全屏图片，YES为1：1正方形
@property(assign, nonatomic) BOOL allowsEditing;

@end
