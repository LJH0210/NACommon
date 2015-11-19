//
//  NAHttpTranscations.h
//  NACommon
//
//  Created by  on 3/11/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NAHttpRequest.h"
#import "NADBase.h"
#import "NADBuffer.h"
#import "NAHostConfig.h"
#import "NAHttpRequestManager.h"

#define kNAHttpRequestTimeout 10

typedef NS_ENUM(NSInteger, NAHttpErrorType) {
    NAHttpErrorTypeData = 1,
    NAHttpErrorTypeConnect,
    NAHttpErrorTypeNotAbility,
    NAHttpErrorTypeNoJsonModel,
    NAHttpErrorTypeOther
};

typedef NS_ENUM(NSInteger, NAHttpBatchItemResponseDataType) {
    NAHttpBatchItemResponseDataTypeKeyValue = 1,
    NAHttpBatchItemResponseDataTypeModel,
    NAHttpBatchItemResponseDataTypeModelInArray,
    NAHttpBatchItemResponseDataTypeNull
};


/**
 *  @author , 15-03-25 20:03:10
 *
 *  http事务
 */
@interface NAHttpTranscations : NSObject 




/**
 *  @author , 15-03-25 19:03:02
 *
 *  通过url生成当前对象
 *
 *  @param url url
 *
 *  @return 请求对象
 */
+ (NAHttpRequest *)requestWithURL:(NSString *)url;
/**
 *  @author , 15-03-25 19:03:31
 *
 *  根据url和参数生成当前对象
 *
 *  @param url    url
 *  @param object 参数
 *
 *  @return 请求对象
 */
+ (NAHttpRequest *)requestWithURL:(NSString *)url withObject:(NSObject *)object;
/**
 *  @author , 15-03-25 19:03:13
 *
 *  通过url、参数以及请求方法生成当前对象
 *
 *  @param url    url
 *  @param object 参数
 *  @param method 请求方法
 *
 *  @return 请求对象
 */
+ (NAHttpRequest *)requestWithURL:(NSString *)url withObject:(NSObject *)object withMethod:(NSString *)method;

#pragma mark 发起http请求事务

/**
 *  @author , 15-03-25 20:03:07
 *
 *  http请求事务
 *
 *  @param request      http请求
 *  @param successBlock 成功回调，无参数
 *  @param failBlock    失败回调
 *  @param sender       发起请求的宿主
 */
+ (void)transcationWithRequest:(NAHttpRequest *)request onSuccess:(void (^)())successBlock onFailed:(NARequestFailedBlock)failBlock sender:(NSString *)sender;

+ (void)transcationWithRequest:(NAHttpRequest *)request onObjSuccess:(void (^)(id obj))successBlock onFailed:(NARequestFailedBlock)failBlock sender:(NSString *)sender;
/**
 *  @author , 15-03-25 20:03:31
 *
 *  http请求事务
 *
 *  @param request      http请求
 *  @param keyName      成功回调的数据key
 *  @param successBlock 成功回调，返回key为keyName的数据
 *  @param failBlock    失败回调
 *  @param sender       发起请求的宿主
 */
+ (void)transcationWithRequest:(NAHttpRequest *)request
                       keyName:(NSString *)keyName
                     onSuccess:(void (^)(id obj))successBlock
                      onFailed:(NARequestFailedBlock)failBlock
                        sender:(NSString *)sender;
/**
 *  @author , 15-03-25 20:03:09
 *
 *  http请求事务
 *
 *  @param request      http请求
 *  @param modelclass   NADBase的子类
 *  @param isArray      是否数组
 *  @param successBlock 成功回调，NADBase子类对象或对象的数组
 *  @param failBlock    失败回调
 *  @param sender       发起请求的宿主
 */
+ (void)transcationWithRequest:(NAHttpRequest *)request
                    modelclass:(Class)modelclass
                       isArray:(BOOL)isArray
                     onSuccess:(void (^)(id obj))successBlock
                      onFailed:(NARequestFailedBlock)failBlock
                        sender:(NSString *)sender;
/**
 *  @author , 15-08-06 11:08:30
 *
 *  http请求事务
 *
 *  @param request      http请求
 *  @param modelclass   NADBase的子类
 *  @param isArray      是否数组
 *  @param successBlock 成功回调，NADBuffer（保存了原始Json数据，支持在过程中逐步解析，解决数据量太大时性能下降的问题）
 *  @param failBlock    失败回调
 *  @param sender       发起请求的宿主
 */
+ (void)transcationWithRequest:(NAHttpRequest *)request
                    modelclass:(Class)modelclass
                       isArray:(BOOL)isArray
             onSuccessToBuffer:(void (^)(NADBuffer *obj))successBlock
                      onFailed:(NARequestFailedBlock)failBlock
                        sender:(NSString *)sender;

/**
 *  @author , 15-03-25 20:03:26
 *
 *  http上传请求事务
 *
 *  @param request      http请求
 *  @param successBlock 成功回调，无参数
 *  @param failBlock    失败回调
 *  @param sender       发起请求的宿主
 */
+ (void)transcationWithUploadRequest:(NAHttpRequest *)request
                           onSuccess:(void (^)())successBlock
                            onFailed:(NARequestFailedBlock)failBlock
                              sender:(NSString *)sender;
/**
 *  @author , 15-03-25 20:03:31
 *
 *  http上传请求事务
 *
 *  @param request      http请求
 *  @param keyName      成功回调的数据key
 *  @param successBlock 成功回调，返回key为keyName的数据
 *  @param failBlock    失败回调
 *  @param sender       发起请求的宿主
 */
+ (void)transcationWithUploadRequest:(NAHttpRequest *)request
                             keyName:(NSString *)keyName
                           onSuccess:(void (^)(id obj))successBlock
                            onFailed:(NARequestFailedBlock)failBlock
                              sender:(NSString *)sender;
/**
 *  @author , 15-03-25 20:03:09
 *
 *  http上传请求事务
 *
 *  @param request      http请求
 *  @param modelclass   NADBase的子类
 *  @param isArray      是否数组
 *  @param successBlock 成功回调，NADBase子类对象或对象的数组
 *  @param failBlock    失败回调
 *  @param sender       发起请求的宿主
 */
+ (void)transcationWithUploadRequest:(NAHttpRequest *)request
                          modelclass:(Class)modelclass
                             isArray:(BOOL)isArray
                           onSuccess:(void (^)(id obj))successBlock
                            onFailed:(NARequestFailedBlock)failBlock
                              sender:(NSString *)sender;


#pragma mark other

/**
 *  @author , 15-03-25 20:03:20
 *
 *  根据错误类型返回错误信息
 *
 *  @param type 错误类型
 *
 *  @return 错误信息
 */
+ (NSString *)errorInfoWithType:(NAHttpErrorType)type;



@end
