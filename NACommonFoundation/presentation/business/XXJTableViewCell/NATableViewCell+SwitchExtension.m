//
//  NATableViewCell+SwitchExtension.m
//  NACommon
//
//  Created by ND on 15/8/27.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NATableViewCell+SwitchExtension.h"

@implementation NATableViewCell (SwitchExtension)

- (void)initSwitchWithNAStyle:(NATableViewCellStyle)style {
    switch (style) {
    case NATableViewCellLabelSwitch: {
        self.leftTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.bounds.size.width / 3, self.bounds.size.height)];
        self.leftTitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.leftTitle];

        self.rightSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.leftTitle.frame.origin.x + self.leftTitle.bounds.size.width + 10, 10,
                                                                      self.bounds.size.width * 2 / 3 - 30, self.bounds.size.height)];
        [self.contentView addSubview:self.rightSwitch];
    } break;
    case NATableViewCellLabelSegment: {
        self.leftTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.bounds.size.width / 3, self.bounds.size.height)];
        self.leftTitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.leftTitle];

        self.rightSegmentedControl = [[UISegmentedControl alloc]
            initWithFrame:CGRectMake(self.leftTitle.frame.origin.x + self.leftTitle.bounds.size.width + 10, 10, self.bounds.size.width / 3, 24)];
        [self.contentView addSubview:self.rightSegmentedControl];
    } break;
    case NATableViewCellCheckLabel: {
        self.leftCheckBox =
            [[NACheckBoxView alloc] initWithFrame:CGRectMake(20, 10, self.bounds.size.width / 3, 22) style:kNACheckBoxViewStyleBox checked:NO];
        self.leftCheckBox.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.leftCheckBox];

        self.rightTitle = [[UILabel alloc]
            initWithFrame:CGRectMake(self.leftCheckBox.bounds.size.width + self.leftCheckBox.frame.origin.x + 10, 10, self.bounds.size.width / 3, 33)];
        [self.contentView addSubview:self.rightTitle];

    } break;
    default:
        break;
    }
}

@end
