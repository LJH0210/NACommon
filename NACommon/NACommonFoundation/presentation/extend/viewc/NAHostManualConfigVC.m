//
//  NAHostManualConfigVC.m
//  NACommon
//
//  Created by  on 3/14/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import "NAHostManualConfigVC.h"
#import "NAHostConfig.h"
#import "NACommonDefine.h"

@interface NAHostManualConfigVC () {
    UIView *_viewTitle;
    UIScrollView *_viewContent;
    UITextView *_viewHostText;
    UITextView *_viewWebHostText;
    UITextView *_viewUserLoginHostText;
    UITextView *_viewPhotoHostText;
}

@end

@implementation NAHostManualConfigVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _viewTitle = [[UIView alloc] initWithFrame:CGRectMake(0, 20 - kNAStatusBarHeight, self.view.bounds.size.width, 44)];
    _viewTitle.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_viewTitle];
    
    UILabel *labtitle = [[UILabel alloc] initWithFrame:_viewTitle.bounds];
    labtitle.backgroundColor = [UIColor clearColor];
    labtitle.textAlignment = NSTextAlignmentCenter;
    labtitle.text = @"手动";
    [_viewTitle addSubview:labtitle];
    
    UIButton *btnleft = [UIButton buttonWithType:UIButtonTypeCustom];
    btnleft.frame = CGRectMake(15, 2, 36, 40);
    btnleft.backgroundColor = [UIColor clearColor];
    [btnleft setTitle:@"取消" forState:UIControlStateNormal];
    [btnleft addTarget:self action:@selector(actionCancel) forControlEvents:UIControlEventTouchUpInside];
    [_viewTitle addSubview:btnleft];
    
    UIButton *btnright = [UIButton buttonWithType:UIButtonTypeCustom];
    btnright.frame = CGRectMake(_viewTitle.bounds.size.width - 15 - 36, 2, 36, 40);
    btnright.backgroundColor = [UIColor clearColor];
    [btnright setTitle:@"保存" forState:UIControlStateNormal];
    [btnright addTarget:self action:@selector(actionSave) forControlEvents:UIControlEventTouchUpInside];
    [_viewTitle addSubview:btnright];
    
    _viewContent = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNANavBarHeight, self.view.bounds.size.width, self.view.bounds.size.height - kNANavBarHeight)];
    _viewContent.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_viewContent];

    UILabel *labelhost = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.view.bounds.size.width - 20*2, 30)];
    labelhost.backgroundColor = [UIColor clearColor];
    labelhost.text = @"主机设置";
    [_viewContent addSubview:labelhost];
    
    _viewHostText = [[UITextView alloc] initWithFrame:CGRectMake(20, labelhost.frame.origin.y + labelhost.frame.size.height, self.view.bounds.size.width - 20*2, 80)];
    _viewHostText.font = [UIFont systemFontOfSize:18];
    _viewHostText.text = [[NAHostConfig sharedInstance] manualHost];
    if (_viewHostText.text.length == 0) {
        _viewHostText.text = [NAHostConfig hostWithType:NAHostTypeIn];
    }
    [_viewContent addSubview:_viewHostText];
    
    UILabel *labelwebhost = [[UILabel alloc] initWithFrame:CGRectMake(20, _viewHostText.frame.origin.y + _viewHostText.frame.size.height + 10, self.view.bounds.size.width - 20*2, 30)];
    labelwebhost.backgroundColor = [UIColor clearColor];
    labelwebhost.text = @"web主机设置";
    [_viewContent addSubview:labelwebhost];
    
    _viewWebHostText = [[UITextView alloc] initWithFrame:CGRectMake(20, labelwebhost.frame.origin.y + labelwebhost.frame.size.height, self.view.bounds.size.width - 20*2, 80)];
    _viewWebHostText.font = [UIFont systemFontOfSize:18];
    _viewWebHostText.text = [[NAHostConfig sharedInstance] manualWebAppHost];
    if (_viewWebHostText.text.length == 0) {
        _viewWebHostText.text = [NAHostConfig webhostWithType:NAHostTypeIn];
    }
    [_viewContent addSubview:_viewWebHostText];

    UILabel *labeluserloginhost = [[UILabel alloc] initWithFrame:CGRectMake(20, _viewWebHostText.frame.origin.y + _viewWebHostText.frame.size.height + 10, self.view.bounds.size.width - 20*2, 30)];
    labeluserloginhost.backgroundColor = [UIColor clearColor];
    labeluserloginhost.text = @"通用服务主机设置";
    [_viewContent addSubview:labeluserloginhost];
    
    _viewUserLoginHostText = [[UITextView alloc] initWithFrame:CGRectMake(20, labeluserloginhost.frame.origin.y + labeluserloginhost.frame.size.height, self.view.bounds.size.width - 20*2, 80)];
    _viewUserLoginHostText.font = [UIFont systemFontOfSize:18];
    _viewUserLoginHostText.text = [[NAHostConfig sharedInstance] manualHostForService];
    if (_viewUserLoginHostText.text.length == 0) {
        _viewUserLoginHostText.text = [NAHostConfig hostWithType:NAHostTypeIn];
    }
    [_viewContent addSubview:_viewUserLoginHostText];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)keyboardWillShow:(NSNotification *)notification {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
    [UIView setAnimationDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]];
    
    CGRect kbrect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect rectcontent = _viewContent.frame;
    _viewContent.contentSize = rectcontent.size;
    rectcontent.size.height = rectcontent.size.height - kbrect.size.height;
    _viewContent.frame = rectcontent;
    
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [UIView beginAnimations:nil context:NULL];
    
    [UIView setAnimationCurve:[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
    [UIView setAnimationDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]];
    
    CGRect rectcontent = _viewContent.frame;
    rectcontent.size.height = self.view.bounds.size.height - kNANavBarHeight;
    _viewContent.contentSize = rectcontent.size;
    _viewContent.frame = rectcontent;
    
    [UIView commitAnimations];
}

- (void)actionCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)actionSave {
    [[NAHostConfig sharedInstance] setHostType:NAHostTypeManual];
    [[NAHostConfig sharedInstance] setManualHost:_viewHostText.text];
    [[NAHostConfig sharedInstance] setManualWebAppHost:_viewWebHostText.text];
    [[NAHostConfig sharedInstance] setManualHostForService:_viewUserLoginHostText.text];
    if ([self.delegate respondsToSelector:@selector(manualConfigFinished)]) {
        [self.delegate performSelector:@selector(manualConfigFinished) withObject:nil];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
