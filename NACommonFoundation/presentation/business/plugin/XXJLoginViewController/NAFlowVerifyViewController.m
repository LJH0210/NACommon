//
//  FlowVerifyViewController.m
//  momo
//
//  Created by Coffee on 13-6-25.
//
//

#import "XXJFlowVerifyViewController.h"
#import "XXJInvalidAfterClickedButton.h"
#import "UIColor+Extension.h"
#import "XXJProgress.h"

@interface XXJFlowVerifyViewController () {

    UILabel *_labelError;
    UILabel *_labelTopLeft;
    UILabel *_labelTopRight;

    UIView *_contentView;
    XXJInvalidAfterClickedButton *btnResendCode;
}

@end

@implementation XXJFlowVerifyViewController

/**
 *  必须重载用于验证验登录
 *
 */
- (void)loginWithVervifyCodeHandler {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  必须重载用于密码登录
 */
- (void)loginWithPWHandler {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.view.backgroundColor = [UIColor xxj_colorWithHex:0xE8E8E8];
    self.title = @"填写验证码";
    _btnLoginLayerColor = [UIColor lightGrayColor];
    _btnLoginLayerHighlightedColor = [UIColor redColor];

    _contentView = [[UIView alloc]
        initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height)];
    [self.view addSubview:_contentView];
    [self.view sendSubviewToBack:_contentView];

    UIButton *btnBackground = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBackground.frame = CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height - 44);
    btnBackground.adjustsImageWhenHighlighted = NO;
    [btnBackground addTarget:self action:@selector(btnBackgroundClicked) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:btnBackground];

    _labelTopLeft = [[UILabel alloc] initWithFrame:CGRectMake(10, 75, 100, 21)];
    _labelTopLeft.backgroundColor = [UIColor clearColor];
    _labelTopLeft.font = [UIFont systemFontOfSize:13];
    _labelTopLeft.textColor = [UIColor grayColor];
    _labelTopLeft.text = @"验证码已发送到";
    _labelTopLeft.textAlignment = NSTextAlignmentLeft;
    [_contentView addSubview:_labelTopLeft];

    _labelTopRight = [[UILabel alloc] initWithFrame:CGRectMake(104, 75, 140, 21)];
    _labelTopRight.backgroundColor = [UIColor clearColor];
    _labelTopRight.font = [UIFont systemFontOfSize:13];
    _labelTopRight.textColor = [UIColor blackColor];
    _labelTopRight.text = self.account;
    _labelTopRight.textAlignment = NSTextAlignmentLeft;
    [_contentView addSubview:_labelTopRight];

    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, [[UIScreen mainScreen] applicationFrame].size.width, 60)];
    backImage.userInteractionEnabled = YES;
    backImage.backgroundColor = [UIColor whiteColor];
    codeField = [[UITextField alloc] initWithFrame:CGRectMake(10, 15, [[UIScreen mainScreen] applicationFrame].size.width - 20, 30)];
    codeField.backgroundColor = [UIColor whiteColor];
    codeField.borderStyle = UITextBorderStyleNone;
    codeField.textAlignment = NSTextAlignmentLeft;
    codeField.placeholder = @"  输入验证码";
    codeField.font = [UIFont boldSystemFontOfSize:13];
    codeField.keyboardType = UIKeyboardTypeNumberPad;
    codeField.textColor = [UIColor blackColor];
    codeField.returnKeyType = UIReturnKeyDone;
    codeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    codeField.delegate = self;

    [backImage addSubview:codeField];
    [_contentView addSubview:backImage];

    //缺少一个警告图标

    _labelError = [[UILabel alloc] initWithFrame:CGRectMake(10, 75, 220, 21)];
    _labelError.backgroundColor = [UIColor clearColor];
    _labelError.textColor = [UIColor redColor];
    _labelError.textAlignment = NSTextAlignmentLeft;
    _labelError.font = [UIFont systemFontOfSize:13];
    _labelError.text = @"您输入的验证码无效，请重新输入";
    [_contentView addSubview:_labelError];
    _labelError.hidden = YES;

    _btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setBtnLoginColor:NO];

    if (self.VerifyType == 0) {
        [_btnLogin addTarget:self action:@selector(actionLogin) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [_btnLogin addTarget:self action:@selector(actionRegister) forControlEvents:UIControlEventTouchUpInside];
    }

    _btnLogin.enabled = NO;
    [_contentView addSubview:_btnLogin];

    btnResendCode = [XXJInvalidAfterClickedButton buttonWithType:UIButtonTypeCustom];
    btnResendCode.frame = CGRectMake(60, 190, 200, 31);
    btnResendCode.titleLabel.font = [UIFont systemFontOfSize:13];
    [btnResendCode setTitle:@"重新发送验证码" forState:UIControlStateNormal];
    [btnResendCode setTitle:@"重新发送验证码" forState:UIControlStateHighlighted];
    [btnResendCode addTarget:self action:@selector(resendCode:) forControlEvents:UIControlEventTouchUpInside];

    [btnResendCode setEnableTitle:@"重新发送验证码" enableImage:@"" disableImage:@"" disableTitle:@"接收短信大约需要"];
    [btnResendCode startTimer];
    [_contentView addSubview:btnResendCode];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBtnLoginColor:(BOOL)isOrange {

    _btnLogin.frame = CGRectMake(40, 150, [[UIScreen mainScreen] applicationFrame].size.width - 80, 44);

    NSString *verifyType = self.VerifyType == 0 ? @"登录" : @"提交";
    if (isOrange) {
        [_btnLogin setAttributedTitle:[[NSAttributedString alloc] initWithString:verifyType
                                                                      attributes:@{
                                                                          NSFontAttributeName : [UIFont systemFontOfSize:16],
                                                                          NSForegroundColorAttributeName : _btnLoginLayerHighlightedColor
                                                                      }]
                             forState:UIControlStateNormal];
        _btnLogin.layer.borderWidth = .5;
        _btnLogin.layer.borderColor = _btnLoginLayerHighlightedColor.CGColor;
        _btnLogin.layer.cornerRadius = _btnLogin.frame.size.height / 2;
    } else {
        [_btnLogin
            setAttributedTitle:[[NSAttributedString alloc]
                                   initWithString:verifyType
                                       attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16], NSForegroundColorAttributeName : _btnLoginLayerColor}]
                      forState:UIControlStateNormal];
        _btnLogin.layer.borderWidth = .5;
        _btnLogin.layer.borderColor = _btnLoginLayerColor.CGColor;
        _btnLogin.layer.cornerRadius = _btnLogin.frame.size.height / 2;
    }
}
- (void)setBtnLoginLayerColor:(UIColor *)btnLoginLayerColor {
    _btnLoginLayerColor = btnLoginLayerColor;
    [self setBtnLoginColor:_btnLogin.enabled];
}

- (void)setBtnLoginLayerHighlightedColor:(UIColor *)btnLoginLayerHighlightedColor {
    _btnLoginLayerHighlightedColor = btnLoginLayerHighlightedColor;
    [self setBtnLoginColor:_btnLogin.enabled];
}
#pragma mark - 按钮事件
//验证注册时的手机号
- (void)actionRegister {
    [self.view endEditing:YES];
    [codeField resignFirstResponder];

    [self loginWithPWHandler];
}

- (void)actionLogin {
    [self.view endEditing:YES];
    [codeField resignFirstResponder];

    [self loginWithVervifyCodeHandler];
}

- (void)btnBackgroundClicked {
    [codeField resignFirstResponder];
}

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField isEqual:codeField] && range.location == 0 && string.length != 0) {
        _btnLogin.enabled = YES;
        [self setBtnLoginColor:YES];
    } else if ([textField isEqual:codeField] && range.location == 0 && string.length == 0) {
        [self setBtnLoginColor:NO];
        _btnLogin.enabled = NO;
    }

    _labelError.hidden = YES;

    //最大6位
    if (textField.text.length == 6 && string.length != 0) {
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    [self setBtnLoginColor:NO];
    _btnLogin.enabled = NO;

    _labelError.hidden = YES;
    return YES;
}

- (void)resendCode:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(resendCode)]) {
        [self.delegate resendCode];
        XXJInvalidAfterClickedButton *btn = (XXJInvalidAfterClickedButton *)sender;
        [btn startTimer];
    }
}

@end
