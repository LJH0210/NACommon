//
//  NATableViewCell.h
//  NACommon
//
//  Created by ND on 15/6/12.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NACheckBoxView.h"

typedef NS_ENUM(NSInteger, NATableViewCellStyle) {
    NATableViewCellDefault,     //包含左侧UILabel(leftTitle)、右侧UITextField(rightTextInput)
    NATableViewCellLabelValue2, //包含左侧Label(leftTitle)、右侧UILabel(rightTitle)
    NATableViewCellLabelValue3, //包含左侧Label(leftTitle)、中间UILabel（centerTitle） 右侧UILabel(rightTitle)
    NATableViewCellLabelValue4, //包含左侧UILabel(leftTitle)、右侧UITextField(rightTextInput)、左下UILabel(leftBottomTitle)、右下UILabel（rightBottomTitle）
    NATableViewCellLabelButtonStyle, //包含左侧UILabel（leftTitle）  右侧 UIButton(rightButton)
    NATableViewCellButtonLabelStyle, //包含左侧UIButton(rightButton)  右侧 UILabel（leftTitle）
    NATableViewCellLabelSwitch,      //包含左侧Label(leftTitle)、右侧UISwitch(rightTitle)
    NATableViewCellLabelSegment,     //包含左侧Label(leftTitle)、右侧UISegmentedControl(rightSegmentedControl)
    NATableViewCellCheckLabel,       //包含左侧Label(leftTitle)、右侧NACheckBoxView(leftCheckBox)
    NATableViewCellInputSearch,
    NATableViewCellImageLabel
};

@interface NATableViewCell : UITableViewCell

@property(strong, nonatomic) UILabel *leftTitle;
@property(strong, nonatomic) UITextField *rightTextInput;

@property(strong, nonatomic) UILabel *centerTitle;
@property(strong, nonatomic) UILabel *rightTitle;

@property(strong, nonatomic) UIButton *leftButton;
@property(strong, nonatomic) UIButton *rightButton;

@property(strong, nonatomic) UILabel *leftBottomTitle;
@property(strong, nonatomic) UILabel *rightBottomTitle;

@property(strong, nonatomic) UISwitch *rightSwitch;
@property(strong, nonatomic) UISegmentedControl *rightSegmentedControl;

@property(strong, nonatomic) NACheckBoxView *leftCheckBox;
@property(strong, nonatomic) UIImageView *leftImageView;
@property(strong, nonatomic) UIImageView *rightTextInputDisplayView;

- (instancetype)initWithNAStyle:(NATableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

/**
 *  创建CELL后调用
 */
- (void)initView;

@end
