//
//  NAPickerMenu.m
//  NACommon
//
//  Created by ND on 15/5/12.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NAPickerMenu.h"
#import "NAPickerModel.h"

typedef enum {
    NAPickerMenuTypeArray = 11,       //一级
    NAPickerMenuTypeMultiArray,       //两级不联动
    NAPickerMenuTypeMultiArrayCustom, //多级联动
} NAPickerMenuType;

@interface NAPickerMenu () <UIPickerViewDelegate, UIPickerViewDataSource>

@property(nonatomic, strong) NSArray *menuArray;
@property(nonatomic, strong) NSDictionary *pickerViewData;
@property(nonatomic, assign) NAPickerMenuType menuType;

@property(nonatomic, strong) UIPickerView *customerPickerView;

@property(nonatomic, copy) NAPickerMenuArrayLeftToolBlock menuArrayleftToolBlock;
@property(nonatomic, copy) NAPickerMutiArrayLeftToolBlock mutiArrayLeftToolBlock;
@property(nonatomic, copy) NAPickerMultiArrayCustomLeftToolBlock multiArrayCustomLeftToolBlock;

@property(nonatomic, copy) NAPickerMenuArrayRightToolBlock menuArrayrightToolBlock;
@property(nonatomic, copy) NAPickerMutiArrayRightToolBlock mutiArrayRightToolBlock;
@property(nonatomic, copy) NAPickerMultiArrayCustomRightToolBlock multiArrayCustomRightToolBlock;

@property(nonatomic, copy) NAPickerMenuArrayValueChangedBlock menuArrayvalueChangeBlock;
@property(nonatomic, copy) NAPickerMutiArrayValueChangedBlock mutiArrayValueChangeBlock;
@property(nonatomic, copy) NAPickerMultiArrayCustomValueChangedBlock multiArrayCustomValueChageBlock;

@end

@implementation NAPickerMenu

+ (NAPickerMenu *)sharedMenu {
    static dispatch_once_t once;
    static NAPickerMenu *sharedMenu;
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

+ (id)viewWithMenuArray:(NSArray *)array
           leftToolTile:(NSString *)leftTitle
          leftToolBlock:(NAPickerMenuArrayLeftToolBlock)leftBlock
         rightToolTitle:(NSString *)rightTitle
         rightToolBlock:(NAPickerMenuArrayRightToolBlock)rightBlock
       valueChangeBlock:(NAPickerMenuArrayValueChangedBlock)valueChangeBlock
           isFullStyple:(BOOL)isfull {
    [[self sharedMenu] destory];
    [[self sharedMenu] setMenuDic:array type:NAPickerMenuTypeArray isFullStyle:isfull leftToolTitle:leftTitle rightToolTitle:rightTitle];
    [self sharedMenu].menuArrayleftToolBlock = leftBlock;
    [self sharedMenu].menuArrayvalueChangeBlock = valueChangeBlock;
    [self sharedMenu].menuArrayrightToolBlock = rightBlock;
    [[self sharedMenu] setUp];
    return [self sharedMenu];
}

+ (id)viewWithMutiArray:(NSArray *)array
           leftToolTile:(NSString *)leftTitle
          leftToolBlock:(NAPickerMutiArrayLeftToolBlock)leftBlock
         rightToolTitle:(NSString *)rightTitle
         rightToolBlock:(NAPickerMutiArrayRightToolBlock)rightBlock
       valueChangeBlock:(NAPickerMutiArrayValueChangedBlock)valueChangeBlock
           isFullStyple:(BOOL)isfull {
    [[self sharedMenu] destory];
    [[self sharedMenu] setMenuDic:array type:NAPickerMenuTypeMultiArray isFullStyle:isfull leftToolTitle:leftTitle rightToolTitle:rightTitle];
    [self sharedMenu].mutiArrayLeftToolBlock = leftBlock;
    [self sharedMenu].mutiArrayValueChangeBlock = valueChangeBlock;
    [self sharedMenu].mutiArrayRightToolBlock = rightBlock;
    [[self sharedMenu] setUp];
    return [self sharedMenu];
}

+ (id)viewWithMultiDictionary:(NSDictionary *)dic
                 leftToolTile:(NSString *)leftTitle
                leftToolBlock:(NAPickerMultiArrayCustomLeftToolBlock)leftBlock
               rightToolTitle:(NSString *)rightTitle
               rightToolBlock:(NAPickerMultiArrayCustomRightToolBlock)rightBlock
             valueChangeBlock:(NAPickerMultiArrayCustomValueChangedBlock)valueChangeBlock
                 isFullStyple:(BOOL)isfull {
    [[self sharedMenu] destory];
    [[self sharedMenu] setMenuDic:dic type:NAPickerMenuTypeMultiArrayCustom isFullStyle:isfull leftToolTitle:leftTitle rightToolTitle:rightTitle];
    [self sharedMenu].multiArrayCustomLeftToolBlock = leftBlock;
    [self sharedMenu].multiArrayCustomValueChageBlock = valueChangeBlock;
    [self sharedMenu].multiArrayCustomRightToolBlock = rightBlock;
    [[self sharedMenu] setUp];
    return [self sharedMenu];
}

- (void)setMenuDic:(id)dic type:(NAPickerMenuType)type isFullStyle:(BOOL)isfull leftToolTitle:(NSString *)leftToolTitle rightToolTitle:(NSString *)rightTitle {
    self.menuType = type;
    _isFullSyle = isfull;
    if ([dic isKindOfClass:[NSArray class]]) {
        self.menuArray = [[NSArray alloc] initWithArray:(NSArray *)dic];
    } else if ([dic isKindOfClass:[NSDictionary class]]) {
        self.pickerViewData = dic;
    }
    _customerPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(10, 36, self.frame.size.width - 10 * 2, 216)];
    [self addSubview:_customerPickerView];

    if (leftToolTitle) {
        _leftTool = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftTool.frame = CGRectMake(0, 0, 72, 36);
        _leftTool.backgroundColor = [UIColor clearColor];
        _leftTool.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [_leftTool setTitle:leftToolTitle forState:UIControlStateNormal];
        _leftTool.titleLabel.font = [UIFont systemFontOfSize:18];
        [_leftTool setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftTool addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftTool];
    }

    if (rightTitle) {
        _rightTool = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightTool.frame = CGRectMake(self.frame.size.width - 72, 0, 72, 36);
        _rightTool.backgroundColor = [UIColor clearColor];
        _rightTool.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [_rightTool setTitle:rightTitle forState:UIControlStateNormal];
        _rightTool.titleLabel.font = [UIFont systemFontOfSize:18];
        [_rightTool setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightTool addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightTool];
    }
    [self addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
}

- (void)leftAction {
    if (_menuType == NAPickerMenuTypeArray && _menuArrayleftToolBlock) {
        _menuArrayleftToolBlock(_menuArray, (int)[_customerPickerView selectedRowInComponent:0]);
    }
    if (self.menuType == NAPickerMenuTypeMultiArray && _mutiArrayLeftToolBlock) {
        NSMutableArray *arrRowComponents = [NSMutableArray new];
        for (int i = 0; i < _customerPickerView.numberOfComponents; i++) {
            [arrRowComponents addObject:@[ @(i), @([_customerPickerView selectedRowInComponent:i]) ]];
        }
        if (_mutiArrayLeftToolBlock) {
            _mutiArrayLeftToolBlock(self.menuArray, arrRowComponents);
        }
        return;
    }
    if (self.menuType == NAPickerMenuTypeMultiArray && _multiArrayCustomLeftToolBlock) {
        NSMutableDictionary *dicRowComponents = [NSMutableDictionary new];

        NSMutableArray *arrPosComponents = [NSMutableArray new];
        NSMutableArray *arrTitleComponents = [NSMutableArray new];

        for (int i = 0; i < _customerPickerView.numberOfComponents; i++) {
            NSInteger selectRow = [_customerPickerView selectedRowInComponent:i];
            [arrPosComponents addObject:@([_customerPickerView selectedRowInComponent:i])];
            [arrTitleComponents addObject:[self pickerView:_customerPickerView titleForRow:selectRow forComponent:i]];
        }

        [dicRowComponents setObject:arrPosComponents forKey:@"position"];
        [dicRowComponents setObject:arrTitleComponents forKey:@"title"];

        [_customerPickerView reloadAllComponents];
        if (_multiArrayCustomLeftToolBlock) {
            _multiArrayCustomLeftToolBlock(self.pickerViewData, dicRowComponents);
        }
    }
}

- (void)rightAction {
    if (_menuType == NAPickerMenuTypeArray && _menuArrayrightToolBlock) {
        _menuArrayrightToolBlock(_menuArray, (int)[_customerPickerView selectedRowInComponent:0]);
    }
    if (self.menuType == NAPickerMenuTypeMultiArray && _mutiArrayRightToolBlock) {
        NSMutableArray *arrRowCompoments = [NSMutableArray new];
        for (int i = 0; i < _customerPickerView.numberOfComponents; i++) {
            [arrRowCompoments addObject:@[ @(i), @([_customerPickerView selectedRowInComponent:i]) ]];
        }
        if (_mutiArrayRightToolBlock) {
            _mutiArrayRightToolBlock(self.menuArray, arrRowCompoments);
        }
        return;
    }
    if (self.menuType == NAPickerMenuTypeMultiArrayCustom && _multiArrayCustomRightToolBlock) {
        NSMutableDictionary *dicRowComponents = [NSMutableDictionary new];

        NSMutableArray *arrPosComponents = [NSMutableArray new];
        NSMutableArray *arrTitleComponents = [NSMutableArray new];

        for (int i = 0; i < _customerPickerView.numberOfComponents; i++) {
            NSInteger selectRow = [_customerPickerView selectedRowInComponent:i];
            [arrPosComponents addObject:@([_customerPickerView selectedRowInComponent:i])];
            [arrTitleComponents addObject:[self pickerView:_customerPickerView titleForRow:selectRow forComponent:i]];
        }

        [dicRowComponents setObject:arrPosComponents forKey:@"position"];
        [dicRowComponents setObject:arrTitleComponents forKey:@"title"];

        [_customerPickerView reloadAllComponents];
        if (_multiArrayCustomRightToolBlock) {
            _multiArrayCustomRightToolBlock(self.pickerViewData, dicRowComponents);
        }
    }
}

- (void)setUp {

    UIPickerView *tagetPickerView = _customerPickerView;
    for (int i = 0; i < self.customerPickerView.numberOfComponents; i++) {
        if ([self.customerPickerView numberOfRowsInComponent:i]) {
            [self.customerPickerView selectRow:0 inComponent:i animated:YES];
        }
    }

    [self.customerPickerView setDataSource:self];
    [self.customerPickerView setDelegate:self];
    [self.customerPickerView reloadAllComponents];

    if (_isFullSyle) {

        CGRect tempFrame = tagetPickerView.frame;
        tempFrame.origin.y = self.frame.size.height - tagetPickerView.frame.size.height;
        tagetPickerView.hidden = FALSE;
        tagetPickerView.frame = tempFrame;

        tempFrame = _leftTool.frame;
        tempFrame.origin.y = self.frame.size.height - tagetPickerView.frame.size.height - 36;
        _leftTool.frame = tempFrame;

        tempFrame = _rightTool.frame;
        tempFrame.origin.y = self.frame.size.height - tagetPickerView.frame.size.height - 36;
        _rightTool.frame = tempFrame;

        tempFrame = self.frame;
        tempFrame.origin.y = tempFrame.size.height;
        self.frame = tempFrame;

    } else {
        CGRect screenframe = [[UIScreen mainScreen] bounds];
        screenframe.origin.y = screenframe.size.height;
        screenframe.size.height = 36 + 216;
        self.frame = screenframe;
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
    [_customerPickerView removeFromSuperview];
    [self removeFromSuperview];

    _menuArrayrightToolBlock = nil;
    _menuArrayleftToolBlock = nil;
    _menuArrayvalueChangeBlock = nil;

    _mutiArrayLeftToolBlock = nil;
    _mutiArrayRightToolBlock = nil;
    _mutiArrayValueChangeBlock = nil;

    _multiArrayCustomLeftToolBlock = nil;
    _multiArrayCustomRightToolBlock = nil;
    _multiArrayCustomValueChageBlock = nil;

    _customerPickerView = nil;
}

#pragma mark UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.menuType == NAPickerMenuTypeMultiArray) {
        NSMutableArray *arrRowCompoments = [NSMutableArray new];
        for (int i = 0; i < pickerView.numberOfComponents; i++) {
            [arrRowCompoments addObject:@[ @(i), @([pickerView selectedRowInComponent:i]) ]];
        }
        if (_mutiArrayValueChangeBlock) {
            _mutiArrayValueChangeBlock(self.menuArray, arrRowCompoments);
        }
        return;
    }

    if (_menuType == NAPickerMenuTypeArray) {
        if ([self.menuArray count] == 0) {
            return;
        }
        if (_menuArrayvalueChangeBlock) {
            _menuArrayvalueChangeBlock(_menuArray, (int)row);
        }
    }

    if (_menuType == NAPickerMenuTypeMultiArrayCustom) {
        NSMutableDictionary *dicRowComponents = [NSMutableDictionary new];

        NSMutableArray *arrPosComponents = [NSMutableArray new];
        NSMutableArray *arrTitleComponents = [NSMutableArray new];

        for (int i = 0; i < pickerView.numberOfComponents; i++) {
            NSInteger selectRow = [pickerView selectedRowInComponent:i];
            if (i > component) {
                [pickerView selectRow:0 inComponent:i animated:NO];
                selectRow = 0;
            }
            [arrPosComponents addObject:@([pickerView selectedRowInComponent:i])];
            NSString *title = [self pickerView:pickerView titleForRow:selectRow forComponent:i];
            if (title.length) {
                [arrTitleComponents addObject:title];
            }
        }

        [dicRowComponents setObject:arrPosComponents forKey:@"position"];
        [dicRowComponents setObject:arrTitleComponents forKey:@"title"];

        [pickerView reloadAllComponents];
        if (_multiArrayCustomValueChageBlock) {
            _multiArrayCustomValueChageBlock(self.pickerViewData, dicRowComponents);
        }
        return;
    }
}

#pragma mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.menuType == NAPickerMenuTypeMultiArray) {
        return self.menuArray.count ? self.menuArray.count : 1;
    }
    if (self.menuType == NAPickerMenuTypeMultiArrayCustom) {
        return [self dicDepth:_pickerViewData];
    }
    return 1;
}

- (int)dicDepth:(NSDictionary *)dic {
    if ([dic isKindOfClass:[NSArray class]]) {
        return 1;
    } else {
        int depth = 0;
        for (NSDictionary *subDic in dic.allValues) {
            int tempDepth = [self dicDepth:subDic] + 1;
            if (tempDepth > depth) {
                depth = tempDepth;
            }
        }
        return depth;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.menuType == NAPickerMenuTypeMultiArray) {
        NSArray *rows = self.menuArray[component];
        if (!rows.count || ![rows isKindOfClass:[NSArray class]]) {
            return 1;
        }
        return rows.count;
    }
    if (self.menuType == NAPickerMenuTypeMultiArrayCustom) {
        id lastId = _pickerViewData;
        for (int i = 0; i <= component; i++) {
            if (i == component) {
                if ([lastId isKindOfClass:[NSArray class]]) {
                    return ((NSArray *)lastId).count;
                }
                if ([lastId isKindOfClass:[NSDictionary class]]) {
                    return [lastId allKeys].count;
                }
                return 0;
            }
            if ([lastId isKindOfClass:[NSDictionary class]]) {
                NSArray *ar = [lastId allKeys];
                NSInteger keyrow = 0;
                keyrow = [pickerView selectedRowInComponent:i];
                lastId = [lastId objectForKey:ar[keyrow]];
            }
        }
        return 0;
    }

    return [self.menuArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (self.menuType == NAPickerMenuTypeMultiArrayCustom) {
        NAPickerModel *resultModel = [[NAPickerModel alloc] init];
        NSString *resultString;
        id lastId = _pickerViewData;
        if (component == 0) {
            id result = [[_pickerViewData allKeys] objectAtIndex:row];
            if ([result isKindOfClass:[NAPickerModel class]]) {
                resultModel = result;
                return resultModel.value;
            } else if ([result isKindOfClass:[NSString class]]) {
                resultString = result;
                return resultString;
            }
        }
        for (int i = 0; i <= component; i++) {
            if (i == component) {
                if ([lastId isKindOfClass:[NSArray class]]) {
                    if (((NSArray *)lastId).count == 0) {
                        return @"";
                    }
                    id result = lastId[row];
                    if ([result isKindOfClass:[NAPickerModel class]]) {
                        resultModel = result;
                        return resultModel.value;
                    } else if ([result isKindOfClass:[NSString class]]) {
                        resultString = result;
                        return resultString;
                    }
                    return result;
                }
                if ([lastId isKindOfClass:[NSDictionary class]]) {
                    if ([lastId allKeys].count > row) {
                        id result = [lastId allKeys][row];
                        if ([result isKindOfClass:[NAPickerModel class]]) {
                            resultModel = result;
                            return resultModel.value;
                        } else if ([result isKindOfClass:[NSString class]]) {
                            resultString = result;
                            return resultString;
                        }
                    }
                    return @"";
                }
            }
            if ([lastId isKindOfClass:[NSDictionary class]]) {
                NSArray *ar = [lastId allKeys];
                NSInteger keyrow = 0;
                keyrow = [pickerView selectedRowInComponent:i];
                if ([lastId allKeys].count > keyrow) {
                    lastId = [lastId objectForKey:ar[keyrow]];
                }
            }
        }
        return resultModel.value;
    } else if (self.menuType == NAPickerMenuTypeMultiArray) {
        NSArray *rows = self.menuArray[component];
        if (!rows.count || ![rows isKindOfClass:[NSArray class]]) {
            return @"";
        }
        return rows[row];
    }

    if ([self.menuArray count] == 0) {
        return @"";
    }

    return [NSString stringWithFormat:@"%@", self.menuArray[row]];
}

@end
