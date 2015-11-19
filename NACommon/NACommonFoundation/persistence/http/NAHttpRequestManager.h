//
//  NAHttpRequestManager.h
//  XXJCommon
//
//  Created by LJH on 15/11/18.
//  Copyright © 2015年 xxjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NAHttpRequest.h"

@interface NAHttpRequestManager : NSObject


/**
 *  @author , 15-03-25 20:03:32
 *
 *  单例
 *
 *  @return 单例
 */
+ (instancetype)sharedInstance;

/**
 *  @author , 15-03-25 20:03:57
 *
 *  添加http请求
 *
 *  @param request http请求
 *  @param sender  发起请求的宿主
 */
- (void)addRequest:(NAHttpRequest *)request forSender:(NSString *)sender;
/**
 *  @author , 15-03-25 20:03:30
 *
 *  删除http请求
 *
 *  @param request http请求
 *  @param sender  发起请求的宿主
 */
- (void)removeRequest:(NAHttpRequest *)request forSender:(NSString *)sender;
/**
 *  @author , 15-03-25 20:03:59
 *
 *  取消http请求
 *
 *  @param sender 发起请求的宿主
 */
- (void)cancelRequestsBySender:(NSString *)sender;

@end
