//
//  UILabel+Extension.m
//  NACommon
//
//  Created by ND on 15/6/5.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "UILabel+Extension.h"
#import "NSString+NAFoundation.h"

@implementation UILabel (Extension)

- (CGRect)NA_autoHeightSize {
    self.numberOfLines = 0;
    CGRect tmpframe = self.frame;
    tmpframe.size.height = [self.text NA_countHeighWithWidth:self.frame.size.width font:self.font];
    self.frame = tmpframe;
    return self.frame;
}

@end
