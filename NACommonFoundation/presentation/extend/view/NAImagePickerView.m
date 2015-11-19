//
//  NAUIImagePickerView.m
//  NACommon
//
//  Created by ND on 15/5/29.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NAImagePickerView.h"

@implementation NAImagePickerView

+ (NAImgPickerView *)NA_imagePickerWithFrame:(CGRect)frame limitCount:(int)limitCount allowsEditing:(BOOL)allowsEditing {
    NAImgPickerView *imp = [[NAImgPickerView alloc] initWithFrame:frame];
    if (limitCount > 0) {
        imp.imgCount = limitCount;
        imp.allowsEditing = allowsEditing;
    }
    return imp;
}

@end
