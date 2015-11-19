//
//  XSecondsInvalidButton.m
//  zxl_new
//
//  Created by csj on 13-8-20.
//  Copyright (c) 2013年 eu. All rights reserved.
//

#import "NAInvalidAfterClickedButton.h"

#define INVALID_SECONDS 60

@interface NAInvalidAfterClickedButton () {
    NSAttributedString *_enableAttributeTitle;
    NSString *_enableTitle;
    UIImage *_enableImage;
    UIImage *_disableImage;

    NSString *_disableTitle;
    int showSeconds; //当前显示的需等待时间  为0s时候按钮变成可点击

    NSTimer *timer;
    NSString *_timeStoreKey;

    BOOL isInvalidAnimating;
}

@end

@implementation NAInvalidAfterClickedButton

- (void)awakeFromNib {
    _enableAttributeTitle =
        [[NSAttributedString alloc] initWithString:[[NSString alloc] initWithFormat:@"%@", [self titleForState:UIControlStateNormal]] attributes:nil];
    _enableImage = [self backgroundImageForState:UIControlStateNormal];

    //改成由业务逻辑手动控制按钮是否disable
    //[self addTarget:self action:@selector(disableButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setAttributeTitle:(NSAttributedString *)enableTitle
              enableImage:(NSString *)enableImage
             disableImage:(NSString *)disableImage
             disableTitle:(NSString *)disableTitle {
    if (!_textWarmColor)
        _textWarmColor = [UIColor lightGrayColor];
    if (!_textWarmHighlightedColor)
        _textWarmHighlightedColor = [UIColor redColor];
    _enableAttributeTitle = [[NSAttributedString alloc] initWithAttributedString:enableTitle];
    _enableImage = [[UIImage imageNamed:enableImage] stretchableImageWithLeftCapWidth:10 topCapHeight:24];
    _disableImage = [UIImage imageNamed:disableImage];
    _disableTitle = [[NSString alloc] initWithString:disableTitle];

    if (_enableImage) {
        [self setBackgroundImage:_enableImage forState:UIControlStateNormal];
    }
    if (_enableAttributeTitle) {
        [self setAttributedTitle:enableTitle forState:UIControlStateNormal];
    }
}

- (void)setEnableTitle:(NSString *)enableTitle enableImage:(NSString *)enableImage disableImage:(NSString *)disableImage disableTitle:(NSString *)disableTitle {
    if (!_textWarmColor)
        _textWarmColor = [UIColor lightGrayColor];
    if (!_textWarmHighlightedColor)
        _textWarmHighlightedColor = [UIColor redColor];
    _enableTitle = [[NSString alloc] initWithString:enableTitle];
    _enableImage = [[UIImage imageNamed:enableImage] stretchableImageWithLeftCapWidth:10 topCapHeight:24];
    _disableImage = [UIImage imageNamed:disableImage];
    _disableTitle = [[NSString alloc] initWithString:disableTitle];

    if (_enableImage) {
        [self setBackgroundImage:_enableImage forState:UIControlStateNormal];
    }
    if (_enableTitle) {
        [self setTitle:_enableTitle forState:UIControlStateNormal];
    }
}

//持久保存的时间
- (void)startTimer {
    _timeStoreKey = @"RESET_TMP_PASSWORD";
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:_timeStoreKey];

    self.enabled = NO;
    self.adjustsImageWhenHighlighted = NO;
    [self setBackgroundImage:_disableImage forState:UIControlStateDisabled];
    showSeconds = INVALID_SECONDS;
    [self setTitle:[NSString stringWithFormat:@"%@%d秒钟", _disableTitle, showSeconds] forState:UIControlStateDisabled];
    if (timer) {
        [timer invalidate];
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(handleAnimationTimer:) userInfo:nil repeats:YES];
}

- (void)handleAnimationTimer:(NSTimer *)handleTimer {

    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDate *startdate = [[NSUserDefaults standardUserDefaults] objectForKey:_timeStoreKey];
        showSeconds = INVALID_SECONDS - ([[NSDate date] timeIntervalSince1970] - [startdate timeIntervalSince1970]);

        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%d秒", _disableTitle, showSeconds]];

        [str addAttribute:NSForegroundColorAttributeName value:_textWarmColor range:NSMakeRange(0, [_disableTitle length])];
        [str addAttribute:NSForegroundColorAttributeName
                    value:_textWarmHighlightedColor
                    range:NSMakeRange([_disableTitle length], [_disableTitle length] + showSeconds > 9 ? 2 : 1)];
        [str addAttribute:NSForegroundColorAttributeName value:_textWarmColor range:NSMakeRange(str.length - 1, 1)];

        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:13] range:NSMakeRange(0, [_disableTitle length])];
        [str addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"Helvetica" size:13]
                    range:NSMakeRange([_disableTitle length], [_disableTitle length] + showSeconds > 9 ? 2 : 1)];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:13] range:NSMakeRange(str.length - 1, 1)];

        [weakSelf setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        [weakSelf setAttributedTitle:str forState:UIControlStateDisabled];

        // stop timer
        if (showSeconds <= 0) { //<= 0  fix iOS7 Timer bug
            showSeconds = 0;
            [handleTimer invalidate];
            [weakSelf setBackgroundImage:_enableImage forState:UIControlStateNormal];
            [weakSelf setTitle:[NSString stringWithFormat:@"%@", _enableTitle] forState:UIControlStateNormal];
            weakSelf.enabled = YES;
            isInvalidAnimating = NO;
            [weakSelf setTitleColor:_textWarmColor forState:UIControlStateNormal];
            return;
        }
        isInvalidAnimating = YES;
    });

    return;
}

@end
