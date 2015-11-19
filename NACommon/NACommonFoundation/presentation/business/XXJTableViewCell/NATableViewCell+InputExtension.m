//
//  NATableViewCell+InputExtension.m
//  NACommon
//
//  Created by ND on 15/8/27.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NATableViewCell+InputExtension.h"

@implementation NATableViewCell (InputExtension)

- (void)initInputWithNAStyle:(NATableViewCellStyle)style {
    switch (style) {
    case NATableViewCellDefault: {
        self.leftTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, self.bounds.size.width / 3, self.bounds.size.height)];
        self.leftTitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.leftTitle];
        self.rightTextInput = [[UITextField alloc]
            initWithFrame:CGRectMake(self.leftTitle.frame.origin.x + self.leftTitle.bounds.size.width + 10, 10, self.bounds.size.width * 2 / 3 - 30, self.bounds.size.height - 20)];
        self.rightTextInput.backgroundColor = [UIColor clearColor];
        self.rightTextInput.borderStyle = UITextBorderStyleRoundedRect;
        [self.contentView addSubview:self.rightTextInput];
    } break;
    case NATableViewCellInputSearch: {
        self.leftTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, self.bounds.size.width / 3, self.bounds.size.height)];
        self.leftTitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.leftTitle];
        self.rightTextInput = [[UITextField alloc] initWithFrame:CGRectMake(self.leftTitle.bounds.size.width + self.leftTitle.frame.origin.x + 10, 10,
                                                                            self.bounds.size.width * 2 / 3 - 60, self.bounds.size.height - 20)];
        self.rightTextInput.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.rightTextInput];

        self.rightTextInputDisplayView =
            [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.rightTextInput.frame.size.height, self.rightTextInput.frame.size.height)];
        self.rightTextInput.rightViewMode = UITextFieldViewModeAlways;
        self.rightTextInput.rightView = self.rightTextInputDisplayView;

    } break;
    default:
        break;
    }
}

@end
