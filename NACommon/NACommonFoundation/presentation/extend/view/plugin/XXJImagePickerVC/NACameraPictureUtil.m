//
//  NACameraPictureUtil.m
//  Guide
//
//  Created by LJH on 15/3/14.
//  Copyright (c) 2015年 nd. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NACameraPictureUtil.h"
#import <MobileCoreServices/UTCoreTypes.h>

#define kTempFile [NSTemporaryDirectory() stringByAppendingString:@"tmp_upload/"]
static NACameraPictureUtil *gInstance;

@interface NACameraPictureUtil () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(retain, nonatomic) NSString *lowQualityUrl;
@property(retain, nonatomic) NSString *nomalQualityUrl;

@end

@implementation NACameraPictureUtil

+ (id)getInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gInstance = [[super alloc] init];
        if ([[NSFileManager defaultManager] fileExistsAtPath:kTempFile] && rand() % 3 == 0) {
            if ([[NSFileManager defaultManager] removeItemAtPath:kTempFile error:nil]) {
                [[NSFileManager defaultManager] createDirectoryAtPath:kTempFile withIntermediateDirectories:YES attributes:nil error:nil];
            }
        } else {
            [[NSFileManager defaultManager] createDirectoryAtPath:kTempFile withIntermediateDirectories:YES attributes:nil error:nil];
        }
        gInstance.allowsEditing = YES;
    });
    int ra = rand();
    gInstance.lowQualityUrl = [kTempFile stringByAppendingFormat:@"camera%i.jpg", ra];
    gInstance.nomalQualityUrl = [kTempFile stringByAppendingFormat:@"cameraNormal%i.jpg", ra];
    NSLog(@"%@", gInstance.lowQualityUrl);
    return gInstance;
}

- (void)showCamera:(UIImagePickerControllerSourceType)sourceType
    mediaTypeArray:(NSArray *)mediaType
      videoQuality:(UIImagePickerControllerQualityType)qualityType {
    if ([NACameraPictureUtil isCameraAvailable] && [NACameraPictureUtil doesCameraSupportTakingPhotos]) {
        // 初始化图片选择控制器

        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        [controller setSourceType:UIImagePickerControllerSourceTypeCamera]; // 设置类型

        // 设置所支持的类型，设置只能拍照，或则只能录像，或者两者都可以
        NSString *requiredMediaType = (NSString *)kUTTypeImage;
        //        NSString *requiredMediaType1 = ( NSString *)kUTTypeMovie;
        NSArray *arrMediaTypes = [NSArray arrayWithObjects:requiredMediaType, nil];
        [controller setMediaTypes:arrMediaTypes];

        // 设置录制视频的质量
        [controller setVideoQuality:UIImagePickerControllerQualityTypeLow];
        //设置最长摄像时间
        [controller setVideoMaximumDuration:10.f];

        [controller setAllowsEditing:_allowsEditing]; // 设置是否可以管理已经存在的图片或者视频
        controller.delegate = gInstance;              // 设置代理
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:controller animated:YES completion:nil];

    } else {
        NSLog(@"Camera is not available.");
    }
}

- (void)showPhotoLib {
    if ([NACameraPictureUtil isPhotoLibraryAvailable]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        [controller setSourceType:UIImagePickerControllerSourceTypePhotoLibrary]; // 设置类型
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        if ([NACameraPictureUtil canUserPickPhotosFromPhotoLibrary]) {
            [mediaTypes addObject:(NSString *)kUTTypeImage];
        }
        if ([NACameraPictureUtil canUserPickVideosFromPhotoLibrary]) {
            [mediaTypes addObject:(NSString *)kUTTypeMovie];
        }
        controller.allowsEditing = _allowsEditing;
        controller.videoQuality = UIImagePickerControllerQualityTypeLow;
        [controller setMediaTypes:mediaTypes];
        [controller setDelegate:[NACameraPictureUtil getInstance]]; // 设置代理
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:controller animated:YES completion:nil];
    }
}

//用户取消拍照
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    picker.delegate = nil;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        __block UIImage *theImage = nil;
        // 判断，图片是否允许修改
        if ([picker allowsEditing]) {
            //获取用户编辑之后的图像
            theImage = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            // 照片的元数据参数
            theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

            UIGraphicsBeginImageContext(CGSizeMake(200, 200));
            [theImage drawInRect:CGRectMake(0, 0, 200, 200)];
            UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            [UIImageJPEGRepresentation(scaledImage, .5) writeToFile:gInstance.lowQualityUrl atomically:YES];

            [UIImageJPEGRepresentation(theImage, .5) writeToFile:gInstance.nomalQualityUrl atomically:YES];

            if ([_delegate respondsToSelector:@selector(cameraLowQualityPictureImgSaved:nomalQualityPicUrl:)]) {
                [_delegate cameraLowQualityPictureImgSaved:gInstance.lowQualityUrl nomalQualityPicUrl:gInstance.nomalQualityUrl];
            }
        });
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 摄像头和相册相关的公共类

// 判断设备是否有摄像头
+ (BOOL)isCameraAvailable {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

// 前面的摄像头是否可用
+ (BOOL)isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

// 后面的摄像头是否可用
+ (BOOL)isRearCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

// 判断是否支持某种多媒体类型：拍照，视频
+ (BOOL)cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType {
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        NSLog(@"Media type is empty.");
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]) {
            result = YES;
            *stop = YES;
        }

    }];
    return result;
}

// 检查摄像头是否支持录像
+ (BOOL)doesCameraSupportShootingVideos {
    return [NACameraPictureUtil cameraSupportsMedia:(NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypeCamera];
}

// 检查摄像头是否支持拍照
+ (BOOL)doesCameraSupportTakingPhotos {
    return [NACameraPictureUtil cameraSupportsMedia:(NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

#pragma mark - 相册文件选取相关
// 相册是否可用
+ (BOOL)isPhotoLibraryAvailable {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

// 是否可以在相册中选择视频
+ (BOOL)canUserPickVideosFromPhotoLibrary {
    return [NACameraPictureUtil cameraSupportsMedia:(NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

// 是否可以在相册中选择视频
+ (BOOL)canUserPickPhotosFromPhotoLibrary {
    return [NACameraPictureUtil cameraSupportsMedia:(NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

@end
