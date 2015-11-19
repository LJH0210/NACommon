//
//  NAAlertView.h
//  NACommon
//
//  Created by ND on 15/8/14.
//  Copyright (c) 2015年 NAia. All rights reserved.
//


#import "NAFocalPointView.h"


@implementation NAFocalPointView


#pragma mark - Object Initialization

- (id)initWithFocalView:(UIView *)focalView {
    self = [super initWithFrame:focalView.frame];
    if (self) {
        _focalView = focalView;

        self.opaque = NO;
        self.userInteractionEnabled = NO;
    }
    return self;
}

@end
