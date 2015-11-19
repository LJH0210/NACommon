//
//  FlowLoginViewController.h
//  momo
//
//  Created by Coffee on 13-6-25.
//
//

#import <UIKit/UIKit.h>
#import "NAHostManualConfigVC.h"

// FlowVerifyDelegate
@interface NAFlowLoginViewController : UIViewController <UITextFieldDelegate, NAHostManualConfigDelegate> {
}

/**
 *  电话号码输入框
 */
@property(strong, nonatomic) UITextField *phoneField;
/**
 *  获取验证码按钮
 */
@property(strong, nonatomic) UIButton *btnGetCode;
@property(strong, nonatomic) UIColor *btnGetCodeLayerColor;
@property(strong, nonatomic) UIColor *btnGetCodeLayerHighlightedColor;
/**
 *  提示信息：为了验证您的身份，我们将会发送短信验证码
 */
@property(strong, nonatomic) UILabel *labelAlert;
/**
 *  错误提示：手机号码不合法,请重新输入
 */
@property(strong, nonatomic) UILabel *labelError;

/**
 *  必须重载用于获取验证码
 *
 */
- (void)getVervifyCodeHandler;
/**
 *  必须重载用于重新获取验证码
 */
- (void)resendVervifyCodeHandler;

@end
