//
//  NAHttpRequest.h
//  NACommon
//
//  Created by  on 3/11/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NAHttpResponse.h"


/**
 *  @author , 15-03-25 19:03:11
 *
 *  http请求成功block
 *
 *  @param response 响应对象
 */
typedef void (^NARequestFinishedBlock)(NAHttpResponse *response);
/**
 *  @author , 15-03-25 19:03:57
 *
 *  http请求失败block
 *
 *  @param response 响应对象
 */
typedef void (^NARequestFailedBlock)(NAHttpResponse *response);

/**
 *  @author , 15-03-25 19:03:54
 *
 *  http上传数据对象
 */
@interface NAHttpUploadObject : NSObject

/**
 *  @author , 15-03-25 19:03:29
 *
 *  上传数据
 */
@property(nonatomic, strong) NSData *data;
/**
 *  @author , 15-03-25 19:03:39
 *
 *  名称
 */
@property(nonatomic, strong) NSString *strName;
/**
 *  @author , 15-03-25 19:03:55
 *
 *  key
 */
@property(nonatomic, strong) NSString *strKey;

@end

/**
 *  @author , 15-03-25 19:03:38
 *
 *  http请求
 */
@interface NAHttpRequest : NSObject

/**
 *  @author , 15-03-25 19:03:29
 *
 *  发起http请求的宿主
 */
@property(nonatomic, copy) NSString *obSender;

/**
 *  @author , 15-03-25 19:03:51
 *
 *  加密的access token
 */
@property(nonatomic, strong) NSData *dataAccessToken;

/**
 *  @author liaojh, 15-03-25 19:03:51
 *
 *  未加密的access token
 */
@property (nonatomic, strong) NSString *stringAccessToken;

/**
 *  @author , 15-03-25 19:03:12
 *
 *  请求的地址
 */
@property(nonatomic, strong) NSString *strUrl;
/**
 *  @author , 15-03-25 19:03:32
 *
 *  请求的方法
 */
@property(nonatomic, strong) NSString *strMethod;
/**
 *  @author , 15-03-25 19:03:49
 *
 *  请求的参数
 */
@property(nonatomic, strong) NSObject *obPara;
/**
 *  @author , 15-03-25 19:03:00
 *
 *  超时时间
 */
@property(nonatomic, assign) NSInteger nTimeout;
/**
 *  @author , 15-03-25 19:03:11
 *
 *  Content Type
 */
@property(nonatomic, strong) NSString *strContentType;
/**
 *  @author , 15-03-25 19:03:26
 *
 *  是否使用https
 */
@property(nonatomic, assign) BOOL blHttpsEnable;
/**
 *  @author , 15-03-25 19:03:43
 *
 *  上传数据列表
 */
@property(nonatomic, strong) NSArray *arrUpload;
/**
 *  @author , 15-08-04 16:08:43
 *
 *  Request Headers
 */
@property(nonatomic, strong) NSDictionary *dicHeader;

/**
 *  @author , 15-03-25 19:03:53
 *
 *  异步方式执行请求
 *
 *  @param finishedBlock 成功回调
 *  @param failedBlock   失败回调
 */
- (void)startAsyncOnRequestFinished:(NARequestFinishedBlock)finishedBlock onRequestFailed:(NARequestFailedBlock)failedBlock;
/**
 *  @author , 15-03-25 19:03:37
 *
 *  异步方式执行数据上传请求
 *
 *  @param finishedBlock 成功回调
 *  @param failedBlock   失败回调
 */
- (void)startAsyncOnUploadRequestFinished:(NARequestFinishedBlock)finishedBlock onRequestFailed:(NARequestFailedBlock)failedBlock;
/**
 *  @author , 15-03-25 19:03:12
 *
 *  异步方式执行数据下载请求
 *
 *  @param finishedBlock 成功回调
 *  @param failedBlock   失败回调
 */
- (void)startAsyncOnDownloadRequestFinished:(NARequestFinishedBlock)finishedBlock onRequestFailed:(NARequestFailedBlock)failedBlock;
- (void)cancel;

@end
