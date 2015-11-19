//
//  NAProgress.h
//  NACommon
//
//  Created by  on 4/9/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NAProgressMaskType) { NAProgressMaskTypeNone = 1, NAProgressMaskTypeClear };

@interface NAProgress : NSObject

+ (void)show;
+ (void)showWithMaskType:(NAProgressMaskType)maskType;

+ (void)showWithStatus:(NSString *)status;
+ (void)showWithStatus:(NSString *)status maskType:(NAProgressMaskType)maskType;

+ (void)showInfoWithStatus:(NSString *)string;
+ (void)showInfoWithStatus:(NSString *)string maskType:(NAProgressMaskType)maskType;

+ (void)showSuccessWithStatus:(NSString *)string;
+ (void)showSuccessWithStatus:(NSString *)string maskType:(NAProgressMaskType)maskType;

+ (void)showErrorWithStatus:(NSString *)string;
+ (void)showErrorWithStatus:(NSString *)string maskType:(NAProgressMaskType)maskType;

+ (void)dismiss;

@end
