//
//  NATableViewCell.m
//  NACommon
//
//  Created by ND on 15/6/12.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NATableViewCell.h"
#import "NATableViewCell+DisplayExtension.h"
#import "NATableViewCell+InputExtension.h"
#import "NATableViewCell+SwitchExtension.h"

#define defaultLabelFontSize 15

@implementation NATableViewCell

- (instancetype)initWithNAStyle:(NATableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self config:style];
        [self initView];
    }
    return self;
}

- (void)config:(NATableViewCellStyle)style {
    switch (style) {
    case NATableViewCellDefault:
    case NATableViewCellInputSearch: {
        [self initInputWithNAStyle:style];
    } break;

    case NATableViewCellLabelValue2:
    case NATableViewCellLabelValue3:
    case NATableViewCellLabelValue4:
    case NATableViewCellLabelButtonStyle:
    case NATableViewCellButtonLabelStyle:
    case NATableViewCellImageLabel: {
        [self initDisplayWithNAStyle:style];
    } break;

    case NATableViewCellLabelSwitch:
    case NATableViewCellLabelSegment:
    case NATableViewCellCheckLabel: {
        [self initSwitchWithNAStyle:style];

    } break;

    default:
        break;
    }
}

- (void)initView {
    _leftTitle.font = [UIFont systemFontOfSize:defaultLabelFontSize];
    _leftTitle.textAlignment = NSTextAlignmentCenter;

    _rightTitle.font = [UIFont systemFontOfSize:defaultLabelFontSize];
    _rightTitle.textAlignment = NSTextAlignmentCenter;

    _centerTitle.font = [UIFont systemFontOfSize:defaultLabelFontSize];
    _centerTitle.textAlignment = NSTextAlignmentCenter;

    _leftBottomTitle.font = [UIFont systemFontOfSize:defaultLabelFontSize];
    _leftBottomTitle.textAlignment = NSTextAlignmentCenter;

    _rightBottomTitle.font = [UIFont systemFontOfSize:defaultLabelFontSize];
    _rightBottomTitle.textAlignment = NSTextAlignmentCenter;

    _leftButton.titleLabel.font = [UIFont systemFontOfSize:defaultLabelFontSize];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:defaultLabelFontSize];

    _rightTextInput.borderStyle = UITextBorderStyleRoundedRect;
    _rightTextInput.font = [UIFont systemFontOfSize:defaultLabelFontSize];

#warning test
    _leftButton.backgroundColor = [UIColor orangeColor];
    _leftButton.layer.cornerRadius = _leftButton.frame.size.height / 2;
    _rightButton.backgroundColor = [UIColor orangeColor];
    _rightButton.layer.cornerRadius = _rightButton.frame.size.height / 2;
}

@end
