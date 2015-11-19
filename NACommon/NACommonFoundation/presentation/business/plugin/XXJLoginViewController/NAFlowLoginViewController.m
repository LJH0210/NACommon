//
//  FlowLoginViewController.m
//  momo
//
//  Created by Coffee on 13-6-25.
//
//

#import "XXJFlowLoginViewController.h"
#import <BlocksKit/BlocksKit+UIKit.h>
#import "XXJHostConfig.h"
#import "UITextField+Extension.h"
#import "NSString+XXJFoundation.h"
#import "XXJProgress.h"
#import "XXJFlowVerifyViewController.h"
#import "UIColor+Extension.h"

//#import "FlowVerifyViewController.h"
//#import "XGHttpTranscations.h"
//#import "NSString+Common.h"
//#import "UIAlertView+MKBlockAdditions.h"
//#import "RegisterGuidVC.h"
//#import "RegisterEditVC.h"
//#import "UITextField+ExtentRange.h"

@interface XXJFlowLoginViewController () <XXJFlowVerifyDelegate> {

    NSString *_mobile;
}

@end

@implementation XXJFlowLoginViewController

- (void)getVervifyCodeHandler {
    [XXJProgress showSuccessWithStatus:@"验证码已发送，请注意查收"];
    XXJFlowVerifyViewController *viewController = [[XXJFlowVerifyViewController alloc] init];
    viewController.account = _mobile;
    viewController.delegate = self;
    [self.navigationController pushViewController:viewController animated:YES];
    _mobile = [[NSString alloc] initWithFormat:@"%@", _phoneField.text];
}

- (void)resendVervifyCodeHandler {
}

- (id)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写手机号";
    self.view.backgroundColor = [UIColor xxj_colorWithHex:0xE8E8E8];
    _btnGetCodeLayerColor = [UIColor lightGrayColor];
    _btnGetCodeLayerHighlightedColor = [UIColor redColor];

    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    [self.navigationController.navigationBar setTranslucent:NO];

    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        if ([UIDevice currentDevice].systemVersion.floatValue < 7) {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"icx_navigation_background_-white"]
                                                          forBarMetrics:UIBarMetricsDefault];
        } else {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"icx_navigation_background_-white"]
                                                          forBarMetrics:UIBarMetricsDefault];
        }
    }

    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    UIControl *menuControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 66, 44)];
    UIImageView *imv;
    imv.frame = CGRectMake(0, 10, imv.frame.size.width, imv.frame.size.height);
    [menuControl addSubview:imv];
    [menuControl addTarget:self action:@selector(actionLeft) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuControl];

#if DEBUG
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 20, 20);
    [rightButton setImage:[UIImage imageNamed:@"icx_navigation_button_share"] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"icx_navigation_button_share"] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(actionRight) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = item;
#else
    self.navigationItem.rightBarButtonItem = nil;
    UIButton *btnBackground = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBackground.frame = CGRectMake(0, 0, kXXJDeviceWidth, kXXJDeviceHeight - 44);
    btnBackground.adjustsImageWhenHighlighted = NO;
    [btnBackground addTarget:self action:@selector(btnBackgroundClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBackground];
#endif

    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 60)];
    backImage.userInteractionEnabled = YES;
    backImage.backgroundColor = [UIColor whiteColor];
    _phoneField = [[UITextField alloc] initWithFrame:CGRectMake(10, 15, [UIScreen mainScreen].bounds.size.width - 20, 30)];
    _phoneField.borderStyle = UITextBorderStyleNone;
    _phoneField.textAlignment = NSTextAlignmentLeft;
    _phoneField.placeholder = @" 输入手机号";
    _phoneField.font = [UIFont boldSystemFontOfSize:16];
    _phoneField.keyboardType = UIKeyboardTypePhonePad;
    _phoneField.backgroundColor = [UIColor clearColor];
    _phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;

    UIButton *clearButton = [_phoneField valueForKey:@"_clearButton"];
    [clearButton setImage:[UIImage imageNamed:@"icx_button_ xx"] forState:UIControlStateNormal];
    [clearButton setImage:[UIImage imageNamed:@"icx_button_ xx"] forState:UIControlStateHighlighted];

    _phoneField.textColor = [UIColor blackColor];
    _phoneField.returnKeyType = UIReturnKeyDone;
    _phoneField.delegate = self;
    [backImage addSubview:_phoneField];
    [self.view addSubview:backImage];

    _labelAlert = [[UILabel alloc] initWithFrame:CGRectMake(10, 75, [UIScreen mainScreen].bounds.size.width - 20, 21)];
    _labelAlert.backgroundColor = [UIColor clearColor];
    _labelAlert.textColor = [UIColor grayColor];
    _labelAlert.textAlignment = NSTextAlignmentLeft;
    _labelAlert.font = [UIFont systemFontOfSize:13];
    _labelAlert.text = @"为了验证您的身份，我们将会发送短信验证码";
    [self.view addSubview:_labelAlert];

    _labelError = [[UILabel alloc] initWithFrame:CGRectMake(10, 75, [UIScreen mainScreen].bounds.size.width - 20, 21)];
    _labelError.backgroundColor = [UIColor clearColor];
    _labelError.textColor = [UIColor redColor];
    _labelError.textAlignment = NSTextAlignmentLeft;
    _labelError.font = [UIFont systemFontOfSize:13.0];
    _labelError.text = @"手机号码不合法,请重新输入";
    [self.view addSubview:_labelError];
    _labelError.hidden = YES;

    _btnGetCode = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnGetCode.frame = CGRectMake(40, 150, [UIScreen mainScreen].bounds.size.width - 80, 44);
    [_btnGetCode setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setGetCodeBtnColor:NO];
    [_btnGetCode addTarget:self action:@selector(actionGetVerify) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnGetCode];
    _btnGetCode.enabled = NO;
}

- (void)setBtnGetCodeLayerColor:(UIColor *)btnGetCodeLayerColor {
    _btnGetCodeLayerColor = btnGetCodeLayerColor;
    [self setGetCodeBtnColor:_btnGetCode.enabled];
}

- (void)setBtnGetCodeLayerHighlightedColor:(UIColor *)btnGetCodeLayerHighlightedColor {
    btnGetCodeLayerHighlightedColor = btnGetCodeLayerHighlightedColor;
    [self setGetCodeBtnColor:_btnGetCode.enabled];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_phoneField becomeFirstResponder];
#if DEBUG
    [self manualConfigFinished];
#else
    [[XXJHostConfig sharedInstance] setHostType:XXJHostTypeOut];
#endif
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionLeft {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)actionRight {
    [_phoneField resignFirstResponder];

    NSArray *hosts = @[ @"外网", @"仿真", @"开发", @"手动" ];
    UIActionSheet *bk = [[UIActionSheet alloc] init];
    [bk bk_addButtonWithTitle:hosts[0]
                      handler:^{
                          [[XXJHostConfig sharedInstance] setHostType:XXJHostTypeOut];
                          [self manualConfigFinished];
                      }];
    [bk bk_addButtonWithTitle:hosts[1]
                      handler:^{
                          [[XXJHostConfig sharedInstance] setHostType:XXJHostTypeSimulate];
                          [self manualConfigFinished];
                      }];
    [bk bk_addButtonWithTitle:hosts[2]
                      handler:^{
                          [[XXJHostConfig sharedInstance] setHostType:XXJHostTypeIn];
                          [self manualConfigFinished];
                      }];
    [bk bk_addButtonWithTitle:hosts[3]
                      handler:^{
                          XXJHostManualConfigVC *manualViewController = [[XXJHostManualConfigVC alloc] init];
                          manualViewController.delegate = self;
                          [self presentViewController:manualViewController animated:YES completion:nil];
                      }];
    [bk bk_addButtonWithTitle:@"取消" handler:nil];

    [bk showInView:self.view];
}

- (void)manualConfigFinished {
    NSString *desc = [XXJHostConfig hostDescription];
    [self setGetCodeBtnColor:_btnGetCode.enabled];

    if (_btnGetCode.enabled) {
        [_btnGetCode setTitle:[NSString stringWithFormat:@"获取验证码(%@)", desc] forState:UIControlStateNormal];
    } else {
        _btnGetCode.enabled = TRUE;
        [_btnGetCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        _btnGetCode.enabled = FALSE;
    }
}

- (void)setGetCodeBtnColor:(BOOL)isOrange {
    NSString *desc = [XXJHostConfig hostDescription];
    if (isOrange) {
        [_btnGetCode setAttributedTitle:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"获取验证码(%@)", desc]
                                                                        attributes:@{
                                                                            NSFontAttributeName : [UIFont systemFontOfSize:16],
                                                                            NSForegroundColorAttributeName : _btnGetCodeLayerHighlightedColor
                                                                        }]
                               forState:UIControlStateNormal];
        _btnGetCode.layer.borderWidth = .5;
        _btnGetCode.layer.borderColor = _btnGetCodeLayerHighlightedColor.CGColor;
        _btnGetCode.layer.cornerRadius = _btnGetCode.frame.size.height / 2;

    } else {
        [_btnGetCode setAttributedTitle:
                         [[NSAttributedString alloc]
                             initWithString:[NSString stringWithFormat:@"获取验证码(%@)", desc]
                                 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16], NSForegroundColorAttributeName : _btnGetCodeLayerColor}]
                               forState:UIControlStateNormal];
        _btnGetCode.layer.borderWidth = .5;
        _btnGetCode.layer.borderColor = _btnGetCodeLayerColor.CGColor;
        _btnGetCode.layer.cornerRadius = _btnGetCode.frame.size.height / 2;
    }
}

- (void)actionGetVerify {

    _mobile = _phoneField.text;
    if ([_mobile length] == 0) {
        [XXJProgress showErrorWithStatus:@"请输入号码"];
        return;
    }
    _mobile = [_mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    [self configHost];

    if (![_mobile xxj_isValidateMobile]) {
        _labelError.hidden = NO;
        self.title = @"验证手机号";
        _labelAlert.hidden = YES;
        return;
    } else {
        _labelAlert.hidden = NO;
        _labelError.hidden = YES;
        self.title = @"填写手机号";
    }

    __weak typeof(self) weakSelf = self;
    [UIAlertView bk_showAlertViewWithTitle:_mobile
                                   message:@"验证码将会以短信形式发送至此号码。如需更改号码请点击取消"
                         cancelButtonTitle:@"取消"
                         otherButtonTitles:@[ @"确认" ]
                                   handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                       [weakSelf getVervifyCodeHandler];
                                   }];

    return;
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // NSLog(@"range loc:%d len:%d   text:%@ replace:%@", range.location, range.length, textField.text, string);

    // phoneField在删除char
    if ([textField isEqual:_phoneField] && range.length == 1 && string.length == 0) {
    }

    UIImage *buttonImage2 = [UIImage imageNamed:@"icx_button_orange_big"];
    CGFloat capWidth = buttonImage2.size.width / 2;
    CGFloat capHeight = buttonImage2.size.height / 2;

    //增加char
    if ([textField isEqual:_phoneField] && range.length == 0 && string.length == 1) {
        if (textField.text.length >= 13) {
            _btnGetCode.enabled = YES;
            return NO;
        }

        NSRange selectedRange = [textField selectedRange];

        //将号码的分割成 3 4 4的带空格间隔格式
        NSMutableString *phone = [NSMutableString stringWithString:textField.text];
        [phone insertString:string atIndex:range.location];
        if (selectedRange.location == textField.text.length) {
            selectedRange.location += 1;
        }

        NSRange searchRange = NSMakeRange(0, [phone length]);
        NSRange range;
        while ((range = [phone rangeOfString:@" " options:0 range:searchRange]).location != NSNotFound) {
            if (range.location < selectedRange.location) {
                selectedRange.location -= 1;
            }
            searchRange = NSMakeRange(NSMaxRange(range), [phone length] - NSMaxRange(range));
        }
        phone = [NSMutableString stringWithString:[phone stringByReplacingOccurrencesOfString:@" " withString:@""]];

        NSMutableString *inputphone = [NSMutableString stringWithString:phone];
        if (inputphone.length > 3) {
            NSString *item1 = [inputphone substringWithRange:NSMakeRange(3, 1)];
            if (![item1 isEqualToString:@" "]) {
                [inputphone insertString:@" " atIndex:3];

                selectedRange.location += 1;
            }

            if (inputphone.length > 8) {
                NSString *item1 = [inputphone substringWithRange:NSMakeRange(8, 1)];
                if (![item1 isEqualToString:@" "]) {
                    [inputphone insertString:@" " atIndex:8];

                    selectedRange.location += 1;
                }
            }
        }

        textField.text = inputphone;
        [textField setSelectedRange:selectedRange];

        [_btnGetCode setBackgroundImage:[buttonImage2 stretchableImageWithLeftCapWidth:capWidth topCapHeight:capHeight] forState:UIControlStateNormal];
        [_btnGetCode setBackgroundImage:[buttonImage2 stretchableImageWithLeftCapWidth:capWidth topCapHeight:capHeight] forState:UIControlStateHighlighted];
        [self setGetCodeBtnColor:YES];

        _btnGetCode.enabled = YES;

        _labelAlert.hidden = NO;
        _labelError.hidden = YES;
        self.title = @"填写手机号";
        return NO;
    }

    if ([textField isEqual:_phoneField] && range.location == 0 && string.length != 0) {
        [_btnGetCode setBackgroundImage:[buttonImage2 stretchableImageWithLeftCapWidth:capWidth topCapHeight:capHeight] forState:UIControlStateNormal];
        [_btnGetCode setBackgroundImage:[buttonImage2 stretchableImageWithLeftCapWidth:capWidth topCapHeight:capHeight] forState:UIControlStateHighlighted];
        _btnGetCode.enabled = YES;
    } else if ([textField isEqual:_phoneField] && range.location == 0 && string.length == 0) {
        UIImage *buttonImage = [UIImage imageNamed:@"icx_button_grey"];
        CGFloat capWidth = buttonImage.size.width / 2;
        CGFloat capHeight = buttonImage.size.height / 2;

        [_btnGetCode setBackgroundImage:[buttonImage stretchableImageWithLeftCapWidth:capWidth topCapHeight:capHeight] forState:UIControlStateNormal];
        [_btnGetCode setBackgroundImage:[buttonImage stretchableImageWithLeftCapWidth:capWidth topCapHeight:capHeight] forState:UIControlStateHighlighted];
        [self setGetCodeBtnColor:NO];

        _btnGetCode.enabled = NO;
    }

    _labelAlert.hidden = NO;
    _labelError.hidden = YES;
    self.title = @"填写手机号";
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    UIImage *buttonImage = [UIImage imageNamed:@"icx_button_grey"];
    CGFloat capWidth = buttonImage.size.width / 2;
    CGFloat capHeight = buttonImage.size.height / 2;

    [_btnGetCode setBackgroundImage:[buttonImage stretchableImageWithLeftCapWidth:capWidth topCapHeight:capHeight] forState:UIControlStateNormal];
    [_btnGetCode setBackgroundImage:[buttonImage stretchableImageWithLeftCapWidth:capWidth topCapHeight:capHeight] forState:UIControlStateHighlighted];

    _labelAlert.hidden = NO;
    _labelError.hidden = YES;
    self.title = @"填写手机号";
    _btnGetCode.enabled = NO;
    [self setGetCodeBtnColor:NO];
    return YES;
}

- (void)btnBackgroundClicked {
    [_phoneField resignFirstResponder];
}

- (void)configHost {
    return;
#if DEBUG
#else
    [[XXJHostConfig sharedInstance] setHostType:XXJHostTypeOut];
#endif
}

#pragma mark FlowVerifyDelegate
- (void)resendCode {
    if ([_mobile length] == 0) {
        [XXJProgress showErrorWithStatus:@"请输入号码"];

        return;
    }

    _mobile = [_mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    [self configHost];
    [self resendVervifyCodeHandler];
}

#pragma mark 程序激活，进行升级检查
- (void)appActive {
    //用户未登录，则进行检查更新
}

@end
