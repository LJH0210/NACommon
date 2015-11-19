//
//  NATableViewCell+DisplayExtension.m
//  NACommon
//
//  Created by ND on 15/8/27.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NATableViewCell+DisplayExtension.h"

@implementation NATableViewCell (DisplayExtension)

- (void)initDisplayWithNAStyle:(NATableViewCellStyle)style {
    switch (style) {
    case NATableViewCellLabelValue2: {
        self.leftTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.bounds.size.width / 3, self.bounds.size.height)];
        self.leftTitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.leftTitle];

        self.rightTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.leftTitle.frame.origin.x + self.leftTitle.bounds.size.width + 10, 0,
                                                                    self.bounds.size.width * 2 / 3 - 30, self.bounds.size.height)];
        self.rightTitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.rightTitle];
    } break;

    case NATableViewCellLabelValue3: {
        self.leftTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, (self.bounds.size.width - 40) / 3, self.bounds.size.height)];
        self.leftTitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.leftTitle];

        self.centerTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.leftTitle.frame.origin.x + self.leftTitle.bounds.size.width + 10, 0,
                                                                     (self.bounds.size.width - 40) / 3, self.bounds.size.height)];
        self.centerTitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.centerTitle];

        self.rightTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.centerTitle.frame.origin.x + self.centerTitle.bounds.size.width + 10, 0,
                                                                    (self.bounds.size.width - 40) / 3, self.bounds.size.height)];
        self.rightTitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.rightTitle];

    } break;
    case NATableViewCellLabelValue4: {
        self.leftTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.bounds.size.width / 2 - 10, self.bounds.size.height / 2)];
        self.leftTitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.leftTitle];

        self.rightTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.leftTitle.frame.origin.x + self.leftTitle.bounds.size.width + 10, 0,
                                                                    self.bounds.size.width / 2 - 10, self.bounds.size.height / 2)];
        self.rightTitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.rightTitle];

        self.leftBottomTitle =
            [[UILabel alloc] initWithFrame:CGRectMake(20, self.bounds.size.height / 2, self.bounds.size.width / 2 - 10, self.bounds.size.height / 2)];
        self.leftBottomTitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.leftBottomTitle];

        self.rightBottomTitle =
            [[UILabel alloc] initWithFrame:CGRectMake(self.leftBottomTitle.frame.origin.x + self.leftBottomTitle.bounds.size.width + 10,
                                                      self.bounds.size.height / 2, self.bounds.size.width / 2 - 10, self.bounds.size.height / 2)];
        self.rightBottomTitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.rightBottomTitle];
    } break;
    case NATableViewCellLabelButtonStyle: {
        self.leftTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, (self.bounds.size.width - 100 - 20), self.bounds.size.height)];
        self.leftTitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.leftTitle];

        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightButton.frame = CGRectMake(self.leftTitle.frame.origin.x + self.leftTitle.bounds.size.width + 10, 5, 100, self.bounds.size.height - 10);
        [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.rightButton];

    } break;
    case NATableViewCellButtonLabelStyle: {
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftButton.frame = CGRectMake(20, 5, 100, self.bounds.size.height - 10);
        [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.leftButton];

        self.rightTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.leftButton.frame.origin.x + self.leftButton.bounds.size.width + 10, 0,
                                                                    self.bounds.size.width - self.leftButton.bounds.size.width - 30, self.bounds.size.height)];
        self.rightTitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.rightTitle];

    } break;
    case NATableViewCellImageLabel: {
        self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, self.bounds.size.height - 10, self.bounds.size.height - 10)];
        [self.contentView addSubview:self.leftImageView];

        self.rightTitle =
            [[UILabel alloc] initWithFrame:CGRectMake(self.leftImageView.frame.origin.x + self.leftImageView.bounds.size.width + 10, 0,
                                                      self.bounds.size.width - self.leftImageView.bounds.size.width - self.leftImageView.frame.origin.x - 20,
                                                      self.bounds.size.height / 2)];
        self.rightTitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.rightTitle];

        self.rightBottomTitle = [[UILabel alloc]
            initWithFrame:CGRectMake(self.leftImageView.frame.origin.x + self.leftImageView.bounds.size.width + 10, self.bounds.size.height / 2,
                                     self.bounds.size.width - self.leftImageView.bounds.size.width - self.leftImageView.frame.origin.x - 20,
                                     self.bounds.size.height / 2)];
        self.rightBottomTitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.rightBottomTitle];
    } break;
    default:
        break;
    }
}

@end
