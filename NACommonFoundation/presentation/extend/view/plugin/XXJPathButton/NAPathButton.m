//
//  NAPathButton.m
//  NACommon
//
//  Created by ND on 15/6/4.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NAPathButton.h"

@interface NAPathButton () {

    NSArray *_buttonArray;
}

@property(copy, nonatomic) NAPathButtonButtonClickBlock buttonClickBlock;
@property(assign, nonatomic) BOOL isExtended;

@end

@implementation NAPathButton

- (NAPathButton *)initWithFrame:(CGRect)frame centerBackgroundImg:(UIImage *)backimage centerHighlightedImg:(UIImage *)highlightedImg {
    self = [super initWithFrame:frame];
    if (self) {
        if (backimage)
            [self setBackgroundImage:backimage forState:UIControlStateNormal];
        if (highlightedImg)
            [self setBackgroundImage:highlightedImg forState:UIControlStateHighlighted];
        [self addTarget:self action:@selector(centerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _isExtended = NO;
        _style = NAPathButtonDefault;
        _radiusR = 60;
        _autoShrink = YES;
    }
    return self;
}

- (void)addExtendButtons:(NSArray *)buttons extendButtonClick:(NAPathButtonButtonClickBlock)buttonClick {
    _buttonArray = [[NSArray alloc] initWithArray:buttons];
    _buttonClickBlock = buttonClick;
}

- (void)setIsExtended:(BOOL)isExtended {
    if (_isExtended != isExtended) {
        if (isExtended) {
            NSInteger buttonNum = _buttonArray.count;

            //圆心
            int a = self.center.x;
            int b = self.center.y;

            for (int i = 0; i < buttonNum; i++) {

                //角度
                double radians = i * (180.0 / (buttonNum - 1));
                double x = 0;
                double y = 0;

                if (_style == NAPathButtonDefault) {
                    if (radians >= 90) {
                        double countRadias = 180.0 - radians;
                        //弧度
                        double degress = countRadias * M_PI / 180.0;

                        float tm = _radiusR * sin(degress);
                        x = fabs(sqrt(fabs(pow(_radiusR, 2) - pow(tm, 2))));
                        x = a + x;
                        y = b - _radiusR * sin(degress);

                    } else {
                        double countRadias = radians;
                        double degress = countRadias * M_PI / 180.0;

                        float tm = _radiusR * sin(degress);
                        x = fabs(sqrt(pow(_radiusR, 2) - pow(tm, 2)));
                        x = a - x;
                        y = b - _radiusR * sin(degress);
                    }
                } else if (_style == NAPathButtonStyleRight) {
                    radians = i * (90.0 / (buttonNum - 1));
                    double degress = radians * M_PI / 180.0;

                    float tm = _radiusR * sin(degress);
                    x = fabs(sqrt(fabs(pow(_radiusR, 2) - pow(tm, 2))));
                    x = a + x;
                    y = b - _radiusR * sin(degress);
                } else if (_style == NAPathButtonStyleLeft) {
                    radians = 180 - i * (90.0 / (buttonNum - 1));
                    double degress = radians * M_PI / 180.0;

                    float tm = _radiusR * sin(degress);
                    x = fabs(sqrt(fabs(pow(_radiusR, 2) - pow(tm, 2))));
                    x = a - x;
                    y = b - _radiusR * sin(degress);
                }

                UIButton *bt = _buttonArray[i];
                bt.alpha = 0;
                bt.tag = i;
                [bt addTarget:self action:@selector(actionExtendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [bt setCenter:CGPointMake(a, b)];
                [self.superview addSubview:bt];
                [UIView animateWithDuration:.3
                    animations:^{
                        bt.center = CGPointMake(x, y);
                        bt.alpha = 1;
                        bt.transform = CGAffineTransformMakeRotation(M_PI);
                    }
                    completion:^(BOOL finished) {
                        bt.transform = CGAffineTransformMakeRotation(0);
                    }];
            }
            _isExtended = YES;
        } else {
            [self shrinkExtendButton];
        }
    }
}

- (void)shrinkExtendButton {
    for (UIButton *bt in _buttonArray) {
        [UIView animateWithDuration:.3
            animations:^{
                bt.center = CGPointMake(self.center.x, self.center.y);
                bt.alpha = 0;
                bt.transform = CGAffineTransformMakeRotation(M_PI);
            }
            completion:^(BOOL finished) {
                bt.transform = CGAffineTransformMakeRotation(0);
                [bt removeFromSuperview];
            }];
    }
    _isExtended = NO;
}

- (void)actionExtendButtonClick:(UIButton *)sender {
    if (_buttonClickBlock) {
        _buttonClickBlock(sender.tag, sender);
        if (_autoShrink) {
            [self shrinkExtendButton];
        }
    }
}

- (void)centerButtonClick:(UIButton *)bt {
    self.isExtended = !self.isExtended;
}

@end
