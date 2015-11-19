//
//  NAWebViewController.h
//  NACommon
//
//  Created by  on 3/11/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @author , 15-03-25 19:03:05
 *
 *  web视图控制器
 */
@interface NAWebViewController : UIViewController {
    UIWebView*	webMain;
}

/**
 *  @author , 15-03-25 19:03:24
 *
 *  web页面Url
 */
@property (nonatomic, strong) NSString* webPageUrl;

/**
 *  @author , 15-03-25 19:03:46
 *
 *  当前控制器与web页面之间的数据交互接口
 *
 *  @param method 调用方法名称
 *  @param paras  传递的参数
 */
- (void)webAppMethod:(NSString *)method paras:(NSDictionary *)paras;

@end
