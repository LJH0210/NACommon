//
//  FlowVerifyViewController.h
//  momo
//
//  Created by Coffee on 13-6-25.
//
//

#import <UIKit/UIKit.h>

@protocol NAFlowVerifyDelegate <NSObject>

- (void)resendCode;

@end

@interface NAFlowVerifyViewController : UIViewController <UITextFieldDelegate> {
    UITextField *codeField;
}

/**
 *  登录帐号
 */
@property(retain, nonatomic) NSString *account;
/**
 *  登录类型
 */
@property(nonatomic) int VerifyType; //验证类型 0=登录验证（默认）  1 = 注册验证
                                     /**
                                      *  登录按钮
                                      */
@property(retain, nonatomic) UIButton *btnLogin;
@property(strong, nonatomic) UIColor *btnLoginLayerColor;
@property(strong, nonatomic) UIColor *btnLoginLayerHighlightedColor;
@property(nonatomic, weak) id<NAFlowVerifyDelegate> delegate;
/**
 *  必须重载用于验证验登录
 *
 */
- (void)loginWithVervifyCodeHandler;
/**
 *  必须重载用于密码登录
 */
- (void)loginWithPWHandler;

@end
