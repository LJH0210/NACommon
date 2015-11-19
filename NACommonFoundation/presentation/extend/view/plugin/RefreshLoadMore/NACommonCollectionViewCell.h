//
//  NACommonCollectionViewCell.h
//  Guide
//
//  Created by ND on 15/3/13.
//  Copyright (c) 2015年 nd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NACommonCollectionViewCellStyle) {
    NACommonCollectionViewCellDefault = 100, // Simple cell with  text label
    NACommonCollectionViewCellValue1,        // Left aligned label on left and right aligned label on right with blue text (Used in Settings)
    NACommonCollectionViewCellValue2,        // Right aligned label on left with blue text and left aligned uibutton on right (Used in Phone/Contacts)
    NACommonCollectionViewCellSubtitle       // Left aligned label on top and left aligned label on bottom with gray text (Used in iPod).
};

@interface NACommonCollectionViewCell : UICollectionViewCell

@property(retain, nonatomic) UILabel *titleLabel;
@property(retain, nonatomic) UILabel *detailLabel;
@property(retain, nonatomic) UIButton *detailButton;
@property(retain, nonatomic) UIColor *seperationLineColor;
@property(assign, nonatomic) NACommonCollectionViewCellStyle NAStyle;

@end
