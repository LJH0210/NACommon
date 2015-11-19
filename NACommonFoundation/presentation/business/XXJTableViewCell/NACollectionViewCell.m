//
//  NACollectionViewCell.m
//  NACommon
//
//  Created by ND on 15/8/27.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NACollectionViewCell.h"

@implementation NACollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame style:(NACollectionViewCellStyle)style {
    self = [super initWithFrame:frame];
    if (self) {
        if (style == NACollectionViewCellImageLabel) {
            _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 33)];
            [self addSubview:_topImageView];

            _bottomTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 30, frame.size.width, 24)];
            _bottomTitle.backgroundColor = [UIColor clearColor];
            [self addSubview:_bottomTitle];
        }
    }
    return self;
}

@end
