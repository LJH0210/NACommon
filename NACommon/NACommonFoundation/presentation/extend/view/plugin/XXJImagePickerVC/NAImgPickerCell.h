//
//  ISImgPickerCell.h
//  Guide
//
//  Created by LJH on 15/3/14.
//  Copyright (c) 2015年 nd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NAImgPickerCellDelegate <NSObject>

- (void)imgPickerCellDeleteAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface NAImgPickerCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *btDelete;
@property (weak, nonatomic) IBOutlet UIImageView *imgBack;
@property (weak, nonatomic) IBOutlet UILabel *labelWarm;

@property (assign,nonatomic) id<NAImgPickerCellDelegate>delegate;
@property (retain, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end
