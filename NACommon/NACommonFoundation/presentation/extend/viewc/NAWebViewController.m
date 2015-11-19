//
//  NAWebViewController.m
//  NACommon
//
//  Created by  on 3/11/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import "NAWebViewController.h"
#import <NSURL+QueryDictionary.h>


@interface NAWebViewController () <UIWebViewDelegate> {
    BOOL canBack;
}

@end

@implementation NAWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initMyWebView];
    [self loadWebPageWithString:self.webPageUrl];

    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    [webMain.scrollView addSubview:refreshControl];
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

- (void)initMyWebView {
    CGRect webframe = self.view.bounds;
    webframe.size.height -= 64;
    webMain = [[UIWebView alloc] initWithFrame:webframe];
    webMain.delegate = self;
    webMain.scalesPageToFit = YES;
    webMain.multipleTouchEnabled = YES;
    [self.view addSubview:webMain];
}

- (void)loadWebPageWithString:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:5.0];
    [webMain loadRequest:request];
    NSLog(@"url:%@",url);
}

-(void)handleRefresh:(UIRefreshControl *)refresh {
    [webMain reload];
    [refresh endRefreshing];
}

- (NSString *)decodeURLWithString:(NSString *)string {
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                             (CFStringRef)string,
                                                                                                             CFSTR(""),
                                                                                                             kCFStringEncodingUTF8));
    return result;
}

#pragma mark -
#pragma mark WepApp接口
- (void)webAppMethod:(NSString *)method paras:(NSDictionary *)paras {

}

#pragma mark -
#pragma mark WebPage Canback
- (void)wepPageRefreshWithCanback:(BOOL)canback {
    canBack = canback;
}

- (void)navDefaultBackButtonClick:(id)button{
    if (canBack) {
        [webMain goBack];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -
#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    static NSString *NAiaScheme = @"NAia";
    
    if ([request.URL.scheme isEqualToString:NAiaScheme]) {
        NSString *method = request.URL.host;
        NSDictionary *paramsdic = [[self decodeURLWithString:[[request URL] query]] uq_URLQueryDictionary];
        [self webAppMethod:method paras:paramsdic];
    }
    
    return true;
}

- (void)webViewDidFinishLoad:(UIWebView*)webView {
    [self wepPageRefreshWithCanback:webView.canGoBack];
}

- (void)webView:(UIWebView*)webView didFailLoadWithError:(NSError*)error {
    [self wepPageRefreshWithCanback:webView.canGoBack];
}

@end
