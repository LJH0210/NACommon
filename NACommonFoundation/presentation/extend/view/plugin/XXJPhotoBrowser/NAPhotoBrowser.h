//
//  NAPhotoBrowser.h
//  NACommon
//
//  Created by ND on 15/6/19.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "MWPhotoBrowser.h"

typedef enum {
    NAPhotoBrowserStyleSinglePhoto = 1,
    NAPhotoBrowserStyleMultiplePhotos,
    NAPhotoBrowserStyleMultiplePhotoGrid,
    NAPhotoBrowserStylePhotoSelections,
    NAPhotoBrowserStylePhotoSelectionGrid,
    NAPhotoBrowserStyleWebPhotos,
    NAPhotoBrowserStyleWebPhotoGrid,
    NAPhotoBrowserStyleLibraryPhotos
} NAPhotoBrowserStyle;

@class NAPhotoBrowser;
@protocol NAPhotoBrowserDelegate <NSObject, MWPhotoBrowserDelegate>

- (NSUInteger)numberOfPhotosInPhotoBrowser:(NAPhotoBrowser *)photoBrowser;
- (id<MWPhoto>)photoBrowser:(NAPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index;

@optional

- (id<MWPhoto>)photoBrowser:(NAPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index;
- (MWCaptionView *)photoBrowser:(NAPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index;
- (NSString *)photoBrowser:(NAPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index;
- (void)photoBrowser:(NAPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index;
- (void)photoBrowser:(NAPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index;
- (BOOL)photoBrowser:(NAPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index;
- (void)photoBrowser:(NAPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected;
- (void)photoBrowserDidFinishModalPresentation:(NAPhotoBrowser *)photoBrowser;

@end

@interface NAPhotoBrowser : MWPhotoBrowser
/**
 *  @author Liandy
 *
 *  创建指定类型查看大图控制器
 *
 *  @param browserStyle 图片浏览方式
 *
 *  @return return value description
 */
- (NAPhotoBrowser *)initWithStyle:(NAPhotoBrowserStyle)browserStyle;

@end
