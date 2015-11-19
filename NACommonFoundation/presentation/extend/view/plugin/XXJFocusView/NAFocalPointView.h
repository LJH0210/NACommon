//
//  NAAlertView.h
//  NACommon
//
//  Created by ND on 15/8/14.
//  Copyright (c) 2015年 NAia. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface NAFocalPointView : UIView

@property (nonatomic, strong, readonly) UIView *focalView;

- (id)initWithFocalView:(UIView *)focalView;

@end
