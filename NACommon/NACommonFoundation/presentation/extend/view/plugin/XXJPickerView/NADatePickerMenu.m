//
//  NADatePickerMenu.m
//  NACommon
//
//  Created by ND on 15/5/11.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NADatePickerMenu.h"

@interface NADatePickerMenu ()

@property(nonatomic, strong) NSDate *menuDate;
@property(nonatomic, strong) UIImageView *backImgV;
@property(assign, nonatomic) BOOL isFullSyle; //是否是全屏模式，点击背景取消

@property(nonatomic, copy) NAPickerMenuDateLeftToolBlock leftToolBlock;

@property(nonatomic, copy) NAPickerMenuDateRightToolBlock rightToolBlock;

@property(nonatomic, copy) NAPickerMenuDateValueChangedBlock valueChangeBlock;

@end

@implementation NADatePickerMenu

+ (NADatePickerMenu *)sharedMenu {
    static dispatch_once_t once;
    static NADatePickerMenu *sharedMenu;
    dispatch_once(&once, ^{
        sharedMenu = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    return sharedMenu;
}

+ (void)show {
    [[self sharedMenu] show];
}

+ (void)dismiss {
    [[self sharedMenu] hide];
}

+ (void)setLeftTitleColor:(UIColor *)leftColor rightTitleColor:(UIColor *)rightColor {
    if (leftColor) {
        [[self sharedMenu].leftTool setTitleColor:leftColor forState:UIControlStateNormal];
    }
    if (rightColor) {
        [[self sharedMenu].rightTool setTitleColor:rightColor forState:UIControlStateNormal];
    }
}

+ (UIView *)viewWithDate:(NSDate *)date
                    mode:(UIDatePickerMode)mode
           leftToolTitle:(NSString *)leftToolTitle
           leftToolBlock:(NAPickerMenuDateLeftToolBlock)leftBlock
          rightToolTitle:(NSString *)rightTitle
          rightToolBlock:(NAPickerMenuDateRightToolBlock)rightBlock
       valueChangedBlock:(NAPickerMenuDateValueChangedBlock)changed
             isFullStyle:(BOOL)isfull {
    [[self sharedMenu] destory];
    [[self sharedMenu] setMenuDate:date
                              mode:mode
                       isFullStyle:isfull
                     leftToolTitle:leftToolTitle
                     leftToolBlock:leftBlock
                    rightToolTitle:rightTitle
                    rightToolBlock:rightBlock
                 valueChangedBlock:changed];
    [[self sharedMenu] setUp];
    return [self sharedMenu];
}

+ (UIView *)viewWithDate:(NSDate *)date valueChangedBlock:(NAPickerMenuDateValueChangedBlock)changed mode:(UIDatePickerMode)mode isFullStyle:(BOOL)isfull {
    [[self sharedMenu] destory];
    [[self sharedMenu] setMenuDate:date
                              mode:mode
                       isFullStyle:isfull
                     leftToolTitle:nil
                     leftToolBlock:nil
                    rightToolTitle:@"取消"
                    rightToolBlock:nil
                 valueChangedBlock:changed];
    [[self sharedMenu] setUp];
    return [self sharedMenu];
}

- (void)setMenuDate:(NSDate *)date
               mode:(UIDatePickerMode)mode
        isFullStyle:(BOOL)isfull
      leftToolTitle:(NSString *)leftToolTitle
      leftToolBlock:(NAPickerMenuDateLeftToolBlock)leftBlock
     rightToolTitle:(NSString *)rightTitle
     rightToolBlock:(NAPickerMenuDateRightToolBlock)rightBlock
  valueChangedBlock:(NAPickerMenuDateValueChangedBlock)changed {
    _datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 36, self.frame.size.width, 216)];
    [_datePickerView addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];

    _menuDate = date;
    _isFullSyle = isfull;
    _leftToolBlock = leftBlock;
    _rightToolBlock = rightBlock;
    _valueChangeBlock = changed;
    _datePickerView.datePickerMode = mode;

    if (!_backImgV) {
        CGSize imageSize = self.bounds.size;
        UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
        [[UIColor blackColor] set];
        UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
        UIImage *im = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        _backImgV = [[UIImageView alloc] initWithImage:im];
        _backImgV.alpha = .725;
        [self addSubview:_backImgV];
    }

    if (leftToolTitle) {
        _leftTool = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftTool.frame = CGRectMake(0, 0, 72, 30);
        _leftTool.backgroundColor = [UIColor clearColor];
        [_leftTool setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _leftTool.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [_leftTool setTitle:leftToolTitle forState:UIControlStateNormal];
        _leftTool.titleLabel.font = [UIFont systemFontOfSize:14];
        [_leftTool addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftTool];
    }

    if (rightTitle) {
        _rightTool = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightTool setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rightTool.frame = CGRectMake(self.frame.size.width - 72, 0, 72, 30);
        _rightTool.backgroundColor = [UIColor clearColor];
        _rightTool.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [_rightTool setTitle:rightTitle forState:UIControlStateNormal];
        _rightTool.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightTool addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightTool];
    }

    _datePickerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_datePickerView];
    [self addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setUp {

    if (_isFullSyle) {
        self.frame = [[UIScreen mainScreen] bounds];
        CGRect tempFrame = _datePickerView.frame;
        tempFrame.origin.y = self.frame.size.height - _datePickerView.frame.size.height;
        _datePickerView.hidden = FALSE;
        _datePickerView.frame = tempFrame;

        tempFrame = _leftTool.frame;
        tempFrame.origin.y = self.frame.size.height - _datePickerView.frame.size.height - _leftTool.frame.size.height;
        _leftTool.frame = tempFrame;

        tempFrame = _rightTool.frame;
        tempFrame.origin.y = self.frame.size.height - _datePickerView.frame.size.height - _rightTool.frame.size.height;
        _rightTool.frame = tempFrame;

        tempFrame = self.frame;
        tempFrame.origin.y = tempFrame.size.height;
        self.frame = tempFrame;

    } else {
        CGRect screenframe = [[UIScreen mainScreen] bounds];
        screenframe.origin.y = screenframe.size.height;
        screenframe.size.height = 36 + 216;
        _datePickerView.hidden = FALSE;
        self.frame = screenframe;
    }
    if (_menuDate) {
        [_datePickerView setDate:_menuDate];
    } else {
        [_datePickerView setDate:[NSDate date]];
    }
}

- (void)show {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];

    CGRect myframe = self.frame;
    myframe.origin.y -= myframe.size.height;
    self.frame = myframe;

    [UIView commitAnimations];
}

- (void)hide {

    [UIView animateWithDuration:.5
        animations:^{
            CGRect myframe = self.frame;
            myframe.origin.y += myframe.size.height;
            self.frame = myframe;

        }
        completion:^(BOOL finished) {
            [self destory];
        }];
}

- (void)destory {
    [_leftTool removeFromSuperview];
    [_rightTool removeFromSuperview];
    [_datePickerView removeFromSuperview];
    [self removeFromSuperview];
    _menuDate = nil;
    _leftToolBlock = nil;
    _rightToolBlock = nil;
    _valueChangeBlock = nil;
    _datePickerView = nil;
}

- (void)dateChanged:(id)sender {
    //确认选择时间
    NSString *resultDate = [[NADatePickerMenu sharedMenu] getDateStringFromDatePicker];

    if (_valueChangeBlock) {
        if (resultDate.length > 0) {
            _valueChangeBlock(resultDate);
        }
    }
}

- (NSString *)getDateStringFromDatePicker {
    NSString *resultDate = @"";
    if (_datePickerView.datePickerMode == UIDatePickerModeTime) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateFormat:@"HH:mm"];

        resultDate = [dateFormatter stringFromDate:_datePickerView.date];
    } else if (_datePickerView.datePickerMode == UIDatePickerModeDate) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        resultDate = [dateFormatter stringFromDate:_datePickerView.date];
    }
    return resultDate;
}

- (void)leftAction {
    if (_leftToolBlock) {
        _leftToolBlock([[NADatePickerMenu sharedMenu] getDateStringFromDatePicker]);
    }
}

- (void)rightAction {
    if (_rightToolBlock) {
        _rightToolBlock([[NADatePickerMenu sharedMenu] getDateStringFromDatePicker]);
    }
}

@end
