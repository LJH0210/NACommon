//
//  NAPhotoBrowser.m
//  NACommon
//
//  Created by ND on 15/6/19.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NAPhotoBrowser.h"

@interface NAPhotoBrowser ()

@property(nonatomic, assign) NAPhotoBrowserStyle browserStyle;

@end

@implementation NAPhotoBrowser

- (NAPhotoBrowser *)initWithStyle:(NAPhotoBrowserStyle)browserStyle {
    self = [super init];
    if (self) {
        self.browserStyle = browserStyle;
        self.displayActionButton = YES;
        self.displaySelectionButtons = NO;
        self.displayNavArrows = NO;
        self.enableGrid = YES;
        self.startOnGrid = NO;
        switch (self.browserStyle) {
        case NAPhotoBrowserStyleSinglePhoto:
            self.enableGrid = NO;
            break;
        case NAPhotoBrowserStyleMultiplePhotos:
            self.enableGrid = NO;
            break;
        case NAPhotoBrowserStyleMultiplePhotoGrid:
            self.startOnGrid = YES;
            self.displayNavArrows = YES;
            break;
        case NAPhotoBrowserStylePhotoSelections:
            break;
        case NAPhotoBrowserStylePhotoSelectionGrid:
            self.displayActionButton = NO;
            self.displaySelectionButtons = YES;
            self.startOnGrid = YES;
            self.enableGrid = NO;
            break;
        case NAPhotoBrowserStyleWebPhotos:
            break;
        case NAPhotoBrowserStyleWebPhotoGrid:
            self.startOnGrid = YES;
            break;
        case NAPhotoBrowserStyleLibraryPhotos:
            break;
        default:
            break;
        }
        self.zoomPhotosToFill = YES;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        self.wantsFullScreenLayout = YES;
#endif
        self.enableSwipeToDismiss = YES;
        [self setCurrentPhotoIndex:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
