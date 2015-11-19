//
//  NAEmptyBackgroundView.m
//  Guide
//
//  Created by ND on 15/4/20.
//  Copyright (c) 2015年 nd. All rights reserved.
//

#import "NAEmptyBackgroundView.h"

@interface NAEmptyBackgroundView (){

    UIImageView *_centerImgv;
    UILabel *_centerLabel;
}

@end

@implementation NAEmptyBackgroundView


- (void)drawRect:(CGRect)rect {
    // Drawing code
    _centerImgv.center = CGPointMake(self.center.x, self.center.y - 45);
    _centerLabel.center = CGPointMake(self.center.x, _centerImgv.center.y + _centerImgv.bounds.size.height /2 + 10);
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self config];
    }
    return self;
}

- (void)config {
    self.backgroundColor = [UIColor clearColor];
    if (!_centerImgv) {
        _centerImgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 106, 125)];
        _centerImgv.center = CGPointMake(self.center.x, self.center.y - 15);
        _centerImgv.backgroundColor = [UIColor clearColor];
        [self addSubview:_centerImgv];
    }
    if (!_centerLabel) {
        _centerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 24)];
        _centerLabel.font = [UIFont systemFontOfSize:11];
        _centerLabel.backgroundColor = [UIColor clearColor];
        _centerLabel.textAlignment = NSTextAlignmentCenter;
        _centerLabel.textColor = [UIColor darkGrayColor];
        _centerLabel.center = CGPointMake(self.center.x, _centerImgv.center.y + _centerImgv.bounds.size.height /2 + 5);
        [self addSubview:_centerLabel];
    }
}

- (void)setEmptyImg:(UIImage *)img size:(CGSize)size{
    _centerImgv.image = img;
    _centerImgv.frame = CGRectMake(_centerImgv.frame.origin.x
                                   , _centerImgv.frame.origin.y
                                   , size.width, size.height);
}

- (void)setEmptyImg:(UIImage *)img{
    _centerImgv.image = img;
}

- (void)setEmptyString:(NSString *)str{
    _centerLabel.text = str;
}

@end
