//
//  NAHttpResponse.h
//  NACommon
//
//  Created by  on 3/11/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @author , 15-03-25 19:03:48
 *
 *  http响应
 */
@interface NAHttpResponse : NSObject

/**
 *  @author , 15-03-25 19:03:05
 *
 *  http响应对象
 *
 *  @return 响应对象
 */
+ (instancetype)response;
/**
 *  @author , 15-03-25 19:03:21
 *
 *  通过status code和response data初始化响应对象
 *
 *  @param statuscode   status code
 *  @param responsedata response data
 *
 *  @return 响应对象
 */
+ (instancetype)responseWithStautsCode:(NSInteger)statuscode responseData:(NSData *)responsedata;
/**
 *  @author , 15-03-25 19:03:39
 *
 *  通过status code和response object初始化响应对象
 *
 *  @param statuscode     status code
 *  @param responseobject response object
 *
 *  @return 响应对象
 */
+ (instancetype)responseWithStautsCode:(NSInteger)statuscode responseObject:(id)responseobject;
/**
 *  @author , 15-03-25 19:03:22
 *
 *  通过status code,response data和response object初始化响应对象
 *
 *  @param statuscode   status code
 *  @param responsedata response data
 *  @param responseobject response object
 *
 *  @return 响应对象
 */
+ (instancetype)responseWithStautsCode:(NSInteger)statuscode responseData:(NSData *)responsedata responseObject:(id)responseobject;

/**
 *  @author , 15-03-25 19:03:22
 *
 *  status code
 */
@property(nonatomic, assign) NSInteger nStatusCode;
/**
 *  @author , 15-08-18 14:08:22
 *
 *  请求失败的原因(系统级别)，解析自errRequest
 */
@property(nonatomic, strong) NSString *strMsgOfError;
/**
 *  @author , 15-03-25 19:03:32
 *
 *  请求的错误信息
 */
@property(nonatomic, strong) NSError *errRequest;
/**
 *  @author , 15-03-25 20:03:35
 *
 *  响应的Json数据
 */
@property(nonatomic, strong) NSData *dataResponse;
/**
 *  @author , 15-03-25 20:03:47
 *
 *  响应的Json对象，由dataResponse转化而来
 */
@property(nonatomic, strong) id obResponse;
/**
 *  @author , 15-03-25 20:03:05
 *
 *  服务端返回的错误信息
 */
@property(nonatomic, strong) NSString *strResponseErrorMsg;
/**
 *  @author , 15-03-25 20:03:25
 *
 *  服务端返回的错误码
 */
@property(nonatomic, assign) int nResponseErrorCode;
/**
 *  @author , 15-03-25 20:03:40
 *
 *  本地格式化的错误信息
 */
@property(nonatomic, strong) NSString *strManualErrorMag;
/**
 *  @author , 15-03-25 20:03:22
 *
 *  错误提示（如果strManualErrorMag非空则返回strManualErrorMag，否则返回strResponseErrorMsg），统一使用该信息反馈给用户
 */
@property(nonatomic, strong) NSString *strErrorPrompts;

@end
