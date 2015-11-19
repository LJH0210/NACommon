//
//  XX
//  NACommon
//
//  Created by ND on 15/6/17.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

@import Foundation;
@import LocalAuthentication;

typedef NS_ENUM(NSInteger, TouchIDResult) {
    TouchIDResultSuccess = 0,
    TouchIDResultError,
    TouchIDResultAuthenticationFailed,
    TouchIDResultUserCancel,
    TouchIDResultUserFallback,
    TouchIDResultSystemCancel,
    TouchIDResultPasscodeNotSet,
    TouchIDResultNotAvailable,
    TouchIDResultNotEnrolled
} NS_ENUM_AVAILABLE_IOS(8_0);

@interface NATouchID : NSObject

/**
 *  跳出指纹验证
 *
 *  @param reason     提示指纹验证文字
 *  @param completion 完成指纹验证Block
 */
+ (void)NA_showTouchIDAuthenticationWithReason:(NSString *)reason completion:(void (^)(TouchIDResult result))completion;

@end
