//
//  UIImageView+XXJQuick.m
//  XXJCommon
//
//  Created by ND on 15/5/8.
//  Copyright (c) 2015年 xxjia. All rights reserved.
//

#import "UIImageView+XXJQuick.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIView+BlocksKit.h>

@implementation UIImageView (XXJQuick)

+ (UIImageView *)xxj_imageViewWithFrame:(CGRect)frame
                         imageUrlString:(NSString *)imageUrlString
                       placeholderImage:(UIImage *)placeholderImage
                          onTappedBlock:(XXJImageViewOnTappedBlock)onTappedBlock {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:placeholderImage];

    if (onTappedBlock) {
        imageView.userInteractionEnabled = YES;
        [imageView bk_whenTapped:^{
            onTappedBlock();
        }];
    }

    return imageView;
}

+ (UIImageView *)xxj_imageViewWithFrame:(CGRect)frame image:(UIImage *)image onTappedBlock:(XXJImageViewOnTappedBlock)onTappedBlock {
    return [UIImageView xxj_imageViewWithFrame:frame image:image backgroundColor:[UIColor clearColor] onTappedBlock:onTappedBlock];
}

+ (UIImageView *)xxj_imageViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor onTappedBlock:(XXJImageViewOnTappedBlock)onTappedBlock {
    return [UIImageView xxj_imageViewWithFrame:frame image:nil backgroundColor:backgroundColor onTappedBlock:onTappedBlock];
}

+ (UIImageView *)xxj_imageViewWithFrame:(CGRect)frame
                                  image:(UIImage *)image
                        backgroundColor:(UIColor *)backgroundColor
                          onTappedBlock:(XXJImageViewOnTappedBlock)onTappedBlock {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    imageView.backgroundColor = backgroundColor;
    if (onTappedBlock) {
        imageView.userInteractionEnabled = YES;
        [imageView bk_whenTapped:^{
            onTappedBlock();
        }];
    }
    return imageView;
}

@end
