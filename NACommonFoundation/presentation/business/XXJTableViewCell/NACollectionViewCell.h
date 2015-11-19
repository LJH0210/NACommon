//
//  NACollectionViewCell.h
//  NACommon
//
//  Created by ND on 15/8/27.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NACollectionViewCellStyle) {
    NACollectionViewCellImageLabel //包含左侧Label(leftTitle)、右侧UISegmentedControl(rightSegmentedControl)
};

@interface NACollectionViewCell : UICollectionViewCell

@property(strong, nonatomic) UIImageView *topImageView;
@property(strong, nonatomic) UILabel *bottomTitle;

- (instancetype)initWithFrame:(CGRect)frame style:(NACollectionViewCellStyle)style;

@end
