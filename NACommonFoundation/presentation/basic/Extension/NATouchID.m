//
//  NATouchID.m
//  NACommon
//
//  Created by ND on 15/6/17.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NATouchID.h"

@implementation NATouchID

+ (void)NA_showTouchIDAuthenticationWithReason:(NSString *)reason completion:(void (^)(TouchIDResult result))completion {

    //初始化上下文对象
    LAContext *context = [[LAContext alloc] init];
    //错误对象
    NSError *error = nil;

    //首先使用canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //支持指纹验证
        //        TouchIDResultSuccess = 0,
        //        TouchIDResultError,
        //        TouchIDResultAuthenticationFailed,
        //        TouchIDResultUserCancel,
        //        TouchIDResultUserFallback,
        //        TouchIDResultSystemCancel,
        //        TouchIDResultPasscodeNotSet,
        //        TouchIDResultNotAvailable,
        //        TouchIDResultNotEnrolled

        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:reason
                          reply:^(BOOL success, NSError *error) {
                              if (success) {
                                  if (completion) {
                                      completion(TouchIDResultSuccess);
                                  }
                              } else {
                                  switch (error.code) {
                                  case LAErrorAuthenticationFailed: {
                                      if (completion) {
                                          completion(TouchIDResultAuthenticationFailed);
                                      }
                                      break;
                                  }

                                  case LAErrorSystemCancel: {
                                      if (completion) {
                                          completion(TouchIDResultSystemCancel);
                                      }
                                      break;
                                  }

                                  case LAErrorUserCancel: {
                                      if (completion) {
                                          completion(TouchIDResultUserCancel);
                                      }
                                      break;
                                  }
                                  case LAErrorUserFallback: {
                                      if (completion) {
                                          completion(TouchIDResultUserFallback);
                                      }
                                      break;
                                  }

                                  case LAErrorTouchIDNotAvailable: {
                                      if (completion) {
                                          completion(TouchIDResultNotAvailable);
                                      }
                                      break;
                                  }

                                  default: {
                                      if (completion) {
                                          completion(TouchIDResultError);
                                      }
                                      break;
                                  }
                                  }
                              }
                          }];
    } else {
        //不支持指纹识别，LOG出错误详情

        switch (error.code) {
        case LAErrorTouchIDNotEnrolled: {
            if (completion) {
                completion(TouchIDResultNotEnrolled);
            }
            break;
        }
        case LAErrorPasscodeNotSet: {
            if (completion) {
                completion(TouchIDResultPasscodeNotSet);
            }
            break;
        }
        default: {
            if (completion) {
                completion(TouchIDResultNotAvailable);
            }
            break;
        }
        }
    }
}

@end
