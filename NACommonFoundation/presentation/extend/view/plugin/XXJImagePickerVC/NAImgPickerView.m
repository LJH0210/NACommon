//
//  ISImgPickerView.m
//  Guide
//
//  Created by LJH on 15/3/14.
//  Copyright (c) 2015年 nd. All rights reserved.
//

#import "NAImgPickerView.h"
#import "NAImgPickerCell.h"
#import "NACameraPictureUtil.h"

@interface NAImgPickerView () <UICollectionViewDelegate, UICollectionViewDataSource, NACameraPictureUtilDelegate, NAImgPickerCellDelegate,
                                UIActionSheetDelegate, UICollectionViewDelegateFlowLayout>

@property(retain, nonatomic) NSMutableArray *arrNomalImgs;
@property(retain, nonatomic) UICollectionView *collcetion;

@end

@implementation NAImgPickerView

- (void)config {
    _arrImgs = [[NSMutableArray alloc] init];
    _arrNomalImgs = [[NSMutableArray alloc] init];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(self.bounds.size.height - 10, self.bounds.size.height - 10);
    layout.minimumLineSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 0);
    ;
    _collcetion = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collcetion.delegate = self;
    _collcetion.dataSource = self;

    _collcetion.backgroundColor = [UIColor clearColor];
    [_collcetion registerNib:[UINib nibWithNibName:@"NAImgPickerCell" bundle:nil] forCellWithReuseIdentifier:@"NAImgPickerCell"];
    _collcetion.contentInset = UIEdgeInsetsZero;
    _imgCount = 100;

    _collcetion.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:_collcetion];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self config];
    }
    return self;
}

#pragma mark uicollection delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_imgCount > 0) {
        if (_arrImgs.count == _imgCount) {
            return _imgCount;
        }
    }
    return _arrImgs.count + 1;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _collcetion.contentInset = UIEdgeInsetsMake(0, 10, 0, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NAImgPickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NAImgPickerCell" forIndexPath:indexPath];
    if (_strWarm && ![_strWarm isEqualToString:@""])
        cell.infoLabel.text = _strWarm;
    cell.delegate = self;
    cell.indexPath = indexPath;
    if (_imgCount > 0) {
        if (indexPath.row == _arrImgs.count && _arrImgs.count < _imgCount) {
            cell.btDelete.hidden = YES;
            cell.infoLabel.hidden = NO;
            cell.imgBack.image = [UIImage imageNamed:@"icx_appraise_upload"];
        } else {
            cell.btDelete.hidden = NO;
            cell.infoLabel.hidden = YES;
            cell.imgBack.image = [UIImage imageWithContentsOfFile:_arrImgs[indexPath.row]];
        }
    } else {
        if (indexPath.row == _arrImgs.count) {
            cell.btDelete.hidden = YES;
            cell.infoLabel.hidden = NO;
            cell.imgBack.image = [UIImage imageNamed:@"icx_appraise_upload"];
        } else {
            cell.btDelete.hidden = NO;
            cell.infoLabel.hidden = YES;
            cell.imgBack.image = [UIImage imageWithContentsOfFile:_arrImgs[indexPath.row]];
        }
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_imgCount > 0) {
        if (indexPath.row == _arrImgs.count && _arrImgs.count < _imgCount) {
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@""
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                 destructiveButtonTitle:nil
                                                      otherButtonTitles:@"拍照", @"相册", nil];
            [sheet showInView:self.superview];
        }
    } else {
        if (indexPath.row == _arrImgs.count) {
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@""
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                 destructiveButtonTitle:nil
                                                      otherButtonTitles:@"拍照", @"相册", nil];
            [sheet showInView:self.superview];
        }
    }
}

- (void)setAllowsEditing:(BOOL)allowsEditing {
    _allowsEditing = allowsEditing;
    [NACameraPictureUtil getInstance].allowsEditing = _allowsEditing;
}

#pragma cell delegate
- (void)imgPickerCellDeleteAtIndexPath:(NSIndexPath *)indexPath {
    [_arrImgs removeObjectAtIndex:indexPath.row];
    [_collcetion reloadData];
    if (_delegate && [_delegate respondsToSelector:@selector(NAImgPickerDidDelImg)]) {
        [_delegate NAImgPickerDidDelImg];
    }
}

#pragma mark actionsheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[NACameraPictureUtil getInstance] showCamera:UIImagePickerControllerSourceTypeCamera
                                            mediaTypeArray:nil
                                              videoQuality:UIImagePickerControllerQualityTypeLow];
            [NACameraPictureUtil getInstance].delegate = self;
        });
    }
    if (buttonIndex == 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[NACameraPictureUtil getInstance] showPhotoLib];
            [NACameraPictureUtil getInstance].delegate = self;

        });
    }
}

- (void)cameraLowQualityPictureImgSaved:(NSString *)lowUrl nomalQualityPicUrl:(NSString *)nomalUrl {
    [_arrNomalImgs addObject:nomalUrl];
    [_arrImgs addObject:lowUrl];
    dispatch_sync(dispatch_get_main_queue(), ^{
        [_collcetion reloadData];
    });
    if (_delegate && [_delegate respondsToSelector:@selector(NAImgPickerDidAddImg)]) {
        [_delegate NAImgPickerDidAddImg];
    }
}

@end
