//
//  NACommonCollectionViewCell.m
//  Guide
//
//  Created by ND on 15/3/13.
//  Copyright (c) 2015年 nd. All rights reserved.
//

#import "NACommonCollectionViewCell.h"

@interface NACommonCollectionViewCell ()

@property(retain, nonatomic) UIImageView *seperationLine;

@end

@implementation NACommonCollectionViewCell

- (void)setXgStyle:(NACommonCollectionViewCellStyle)NAStyle {
    if (_NAStyle != NAStyle) {
        _NAStyle = NAStyle;
        if (_NAStyle == NACommonCollectionViewCellValue1) {
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width / 2, self.bounds.size.height)];
            [self.contentView addSubview:_titleLabel];
            _titleLabel.backgroundColor = [UIColor clearColor];
            _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2, 0, self.bounds.size.width / 2, self.bounds.size.height)];
            [self.contentView addSubview:_detailLabel];
            _detailLabel.backgroundColor = [UIColor clearColor];
        }
        if (_NAStyle == NACommonCollectionViewCellDefault) {
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 1, self.bounds.size.width, self.bounds.size.height - 2)];
            [self.contentView addSubview:_titleLabel];
            _titleLabel.backgroundColor = [UIColor clearColor];
        }

        if (_NAStyle == NACommonCollectionViewCellValue2) {
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width - self.bounds.size.height - 10, self.bounds.size.height)];
            [self.contentView addSubview:_titleLabel];
            _titleLabel.backgroundColor = [UIColor clearColor];

            _detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _detailButton.frame = CGRectMake(self.bounds.size.width - self.bounds.size.height, 0, self.bounds.size.height, self.bounds.size.height);
            [self.contentView addSubview:_detailButton];
        }

        _seperationLine = [[UIImageView alloc] initWithFrame:CGRectMake(1, self.bounds.size.height - 1, self.bounds.size.width - 2, .5)];
        _seperationLine.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_seperationLine];
    } else {
        _titleLabel.text = @"";
        _detailLabel.text = @"";
    }
}

- (void)setSeperationLineColor:(UIColor *)seperationLineColor {
    if (_seperationLineColor != seperationLineColor) {
        _seperationLineColor = seperationLineColor;
        _seperationLine.backgroundColor = _seperationLineColor;
    }
}

@end
