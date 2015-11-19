//
//  NACameraPictureUtil.h
//  Guide
//
//  Created by LJH on 15/3/14.
//  Copyright (c) 2015年 nd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NACameraPictureUtilDelegate <NSObject>

- (void)cameraLowQualityPictureImgSaved:(NSString *)lowUrl nomalQualityPicUrl:(NSString *)nomalUrl;

@end

@interface NACameraPictureUtil : NSObject

@property(assign, nonatomic) id<NACameraPictureUtilDelegate> delegate;

@property(assign, nonatomic) BOOL allowsEditing;

+ (NACameraPictureUtil *)getInstance;

- (void)showCamera:(UIImagePickerControllerSourceType)sourceType
    mediaTypeArray:(NSArray *)mediaType
      videoQuality:(UIImagePickerControllerQualityType)qualityType;

- (void)showPhotoLib;

@end
