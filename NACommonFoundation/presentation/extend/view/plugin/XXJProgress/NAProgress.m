//
//  NAProgress.m
//  NACommon
//
//  Created by  on 4/9/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import "NAProgress.h"
#import <SVProgressHUD.h>

@implementation NAProgress

+ (void)show {
    [SVProgressHUD show];
}

+ (void)showWithMaskType:(NAProgressMaskType)maskType {
    [SVProgressHUD showWithMaskType:(SVProgressHUDMaskType)maskType];
}

+ (void)showWithStatus:(NSString *)status {
    [SVProgressHUD showWithStatus:status];
}

+ (void)showWithStatus:(NSString *)status maskType:(NAProgressMaskType)maskType {
    [SVProgressHUD showWithStatus:status maskType:(SVProgressHUDMaskType)maskType];
}

+ (void)showInfoWithStatus:(NSString *)string {
    [SVProgressHUD showInfoWithStatus:string];
}

+ (void)showInfoWithStatus:(NSString *)string maskType:(NAProgressMaskType)maskType {
    [SVProgressHUD showInfoWithStatus:string maskType:(SVProgressHUDMaskType)maskType];
}

+ (void)showSuccessWithStatus:(NSString *)string {
    [SVProgressHUD showSuccessWithStatus:string];
}

+ (void)showSuccessWithStatus:(NSString *)string maskType:(NAProgressMaskType)maskType {
    [SVProgressHUD showSuccessWithStatus:string maskType:(SVProgressHUDMaskType)maskType];
}

+ (void)showErrorWithStatus:(NSString *)string {
    [SVProgressHUD showErrorWithStatus:string];
}

+ (void)showErrorWithStatus:(NSString *)string maskType:(NAProgressMaskType)maskType {
    [SVProgressHUD showErrorWithStatus:string maskType:(SVProgressHUDMaskType)maskType];
}

+ (void)dismiss {
    [SVProgressHUD dismiss];
}

@end
