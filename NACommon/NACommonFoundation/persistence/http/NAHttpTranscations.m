//
//  NAHttpTranscations.m
//  NACommon
//
//  Created by 130137 on 3/11/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import "NAHttpTranscations.h"
#import "NALog.h"
#import "NAHttpRequest.h"
#import "NAASIHttpTranscations.h"
#import "NAASIHttpRequest.h"
#import "NAAFHttpTranscations.h"
#import "NAAFHttpRequest.h"
#import "NAHostConfig.h"
#import "NAHttpRequestConfig.h"
#import <objc/runtime.h>

@interface NAHttpTranscations () {
    NSMutableArray *_arrmRequest;
}

@end

@implementation NAHttpTranscations

+ (Class)getCorrectRequestByHttpTranscationSuperClass{
    if ([[self superclass] isSubclassOfClass:[NAAFHttpTranscations class]]  ) {
        return [NAAFHttpRequest class];
    }else if ([[self superclass] isSubclassOfClass:[NAASIHttpTranscations class]]){
        return [NAASIHttpRequest class];
    }else{
        NSLog(@"如果你判断父类，那么你无法获取到正确的Request实例");
        return [NAHttpRequest class];
    }
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _arrmRequest = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (NAHttpRequest *)requestWithURL:(NSString *)url {
    if (nil == url) {
        return nil;
    }
    
    NAHttpRequest *request = [[[self getCorrectRequestByHttpTranscationSuperClass] alloc] init];
    NSString *tmpURL = [[[NAHostConfig sharedInstance] host] stringByAppendingString:url];
    request.strUrl = [NAHttpRequestConfig appendToUrl:tmpURL];
    request.stringAccessToken = [NAHttpRequestConfig accessTokenString];
    request.dataAccessToken = [NAHttpRequestConfig accessTokenData];
    return request;
}

+ (NAHttpRequest *)requestWithURL:(NSString *)url withObject:(NSObject *)object {
    if (nil == url) {
        return nil;
    }
    
    NAHttpRequest *request = [[[self getCorrectRequestByHttpTranscationSuperClass] alloc] init];
    NSString *tmpURL = [[[NAHostConfig sharedInstance] host] stringByAppendingString:url];
    request.strUrl = [NAHttpRequestConfig appendToUrl:tmpURL];
    request.obPara = [object copy];
    request.stringAccessToken = [NAHttpRequestConfig accessTokenString];
    request.dataAccessToken = [NAHttpRequestConfig accessTokenData];
    request.strMethod = @"POST";
    
    return request;
}

+ (NAHttpRequest *)requestWithURL:(NSString *)url withObject:(NSObject *)object withMethod:(NSString *)method {
    if (nil == url) {
        return nil;
    }
    NAHttpRequest *request = [[[self getCorrectRequestByHttpTranscationSuperClass] alloc] init];
    NSString *tmpURL = [[[NAHostConfig sharedInstance] host] stringByAppendingString:url];
    request.strUrl = [NAHttpRequestConfig appendToUrl:tmpURL];
    request.obPara = [object copy];
    request.strMethod = [method copy];
    request.stringAccessToken = [NAHttpRequestConfig accessTokenString];
    request.dataAccessToken = [NAHttpRequestConfig accessTokenData];
    return request;
}

+ (NSString *)errorInfoWithType:(NAHttpErrorType)type {
    NSString *errmsg = @"";

    switch (type) {
    case NAHttpErrorTypeData:
        errmsg = @"返回数据异常";
        break;

    case NAHttpErrorTypeConnect:
        errmsg = @"网络请求失败";
        break;

    case NAHttpErrorTypeNotAbility:
        errmsg = @"没有提交权限";
        break;

    case NAHttpErrorTypeNoJsonModel:
        errmsg = @"未定义数据层模型";
        break;

    default:
        break;
    }

    return errmsg;
}



+ (void)transcationWithRequest:(NAHttpRequest *)request
                     onSuccess:(void (^)())successBlock
                      onFailed:(NARequestFailedBlock)failBlock
                        sender:(NSString *)sender {
    [request startAsyncOnRequestFinished:^(NAHttpResponse *response) {
        if (response.nStatusCode != 200) {
            NSLog(@"ResponseErrorMsg:%@", response.strResponseErrorMsg);
            if (failBlock) {
                failBlock(response);
            }
            [[NAHttpRequestManager sharedInstance] removeRequest:request forSender:sender];
            return;
        }

        if (successBlock) {
            successBlock();
        }
        [[NAHttpRequestManager sharedInstance] removeRequest:request forSender:sender];
    } onRequestFailed:^(NAHttpResponse *response) {
        response.strManualErrorMag = [self errorInfoWithType:NAHttpErrorTypeConnect];
        if (failBlock) {
            failBlock(response);
        }
        [[NAHttpRequestManager sharedInstance] removeRequest:request forSender:sender];
    }];

    [[NAHttpRequestManager sharedInstance] addRequest:request forSender:sender];
}


+ (void)transcationWithRequest:(NAHttpRequest *)request onObjSuccess:(void (^)(id obj))successBlock onFailed:(NARequestFailedBlock)failBlock sender:(NSString *)sender{
    [request startAsyncOnRequestFinished:^(NAHttpResponse *response) {
        if (response.nStatusCode != 200) {
            NSLog(@"ResponseErrorMsg:%@", response.strResponseErrorMsg);
            if (failBlock) {
                failBlock(response);
            }
            [[NAHttpRequestManager sharedInstance] removeRequest:request forSender:sender];
            return;
        }
        
        if (successBlock) {
            successBlock(response.obResponse);
        }
        [[NAHttpRequestManager sharedInstance] removeRequest:request forSender:sender];
    } onRequestFailed:^(NAHttpResponse *response) {
        response.strManualErrorMag = [self errorInfoWithType:NAHttpErrorTypeConnect];
        if (failBlock) {
            failBlock(response);
        }
        [[NAHttpRequestManager sharedInstance] removeRequest:request forSender:sender];
    }];
    
    [[NAHttpRequestManager sharedInstance] addRequest:request forSender:sender];
}


+ (void)transcationWithRequest:(NAHttpRequest *)request
                       keyName:(NSString *)keyName
                     onSuccess:(void (^)(id obj))successBlock
                      onFailed:(NARequestFailedBlock)failBlock
                        sender:(NSString *)sender {
    [request startAsyncOnRequestFinished:^(NAHttpResponse *response) {
        if (response.nStatusCode != 200) {
            NSLog(@"ResponseErrorMsg:%@", response.strResponseErrorMsg);
            if (failBlock) {
                failBlock(response);
            }
            [[NAHttpRequestManager sharedInstance] removeRequest:request forSender:sender];
            return;
        }

        id value = response.obResponse[keyName];
        if (value) {
            if (successBlock) {
                successBlock(value);
            }
        } else {
            response.strManualErrorMag = [self errorInfoWithType:NAHttpErrorTypeData];
            if (failBlock) {
                failBlock(response);
            }
        }
        [[NAHttpRequestManager sharedInstance] removeRequest:request forSender:sender];
    } onRequestFailed:^(NAHttpResponse *response) {
        response.strManualErrorMag = [self errorInfoWithType:NAHttpErrorTypeConnect];
        if (failBlock) {
            failBlock(response);
        }
        [[NAHttpRequestManager sharedInstance] removeRequest:request forSender:sender];
    }];

    [[NAHttpRequestManager sharedInstance] addRequest:request forSender:sender];
}

+ (void)transcationWithRequest:(NAHttpRequest *)request
                    modelclass:(Class)modelclass
                       isArray:(BOOL)isArray
                     onSuccess:(void (^)(id obj))successBlock
                      onFailed:(NARequestFailedBlock)failBlock
                        sender:(NSString *)sender {
    [request startAsyncOnRequestFinished:^(NAHttpResponse *response) {
        if (response.nStatusCode != 200) {
            NSLog(@"ResponseErrorMsg:%@", response.strResponseErrorMsg);
            if (failBlock) {
                failBlock(response);
            }
            [[NAHttpRequestManager sharedInstance] removeRequest:request forSender:sender];
            return;
        }

        if ([modelclass isSubclassOfClass:[NADBase class]]) {
            if (isArray) {
                id jsmodels = [modelclass arrayOfModelWithData:response.dataResponse];
                if (jsmodels) {
                    if (successBlock) {
                        successBlock(jsmodels);
                    }
                } else {
                    response.strManualErrorMag = [self errorInfoWithType:NAHttpErrorTypeData];
                    if (failBlock) {
                        failBlock(response);
                    }
                }
            } else {
                id jsmodel = [[modelclass alloc] initWithData:response.dataResponse];
                if (jsmodel) {
                    if (successBlock) {
                        successBlock(jsmodel);
                    }
                } else {
                    response.strManualErrorMag = [self errorInfoWithType:NAHttpErrorTypeData];
                    if (failBlock) {
                        failBlock(response);
                    }
                }
            }
        } else if (modelclass == nil && isArray) {
            id jsmodel = response.obResponse;
            if (jsmodel && [jsmodel isKindOfClass:[NSArray class]]) {
                if (successBlock) {
                    successBlock(jsmodel);
                }
            } else {
                response.strManualErrorMag = [self errorInfoWithType:NAHttpErrorTypeData];
                if (failBlock) {
                    failBlock(response);
                }
            }
        } else {
            response.strManualErrorMag = [self errorInfoWithType:NAHttpErrorTypeNoJsonModel];
            if (failBlock) {
                failBlock(response);
            }
        }
        [[NAHttpRequestManager sharedInstance] removeRequest:request forSender:sender];
    } onRequestFailed:^(NAHttpResponse *response) {
        if (failBlock) {
            failBlock(response);
        }
        [[NAHttpRequestManager sharedInstance] removeRequest:request forSender:sender];
    }];

    [[NAHttpRequestManager sharedInstance] addRequest:request forSender:sender];
}

+ (void)transcationWithRequest:(NAHttpRequest *)request
                    modelclass:(Class)modelclass
                       isArray:(BOOL)isArray
             onSuccessToBuffer:(void (^)(NADBuffer *obj))successBlock
                      onFailed:(NARequestFailedBlock)failBlock
                        sender:(NSString *)sender {
    [request startAsyncOnRequestFinished:^(NAHttpResponse *response) {
        if (response.nStatusCode != 200) {
            NSLog(@"ResponseErrorMsg:%@", response.strResponseErrorMsg);
            if (failBlock) {
                failBlock(response);
            }
            [[NAHttpRequestManager sharedInstance] removeRequest:request forSender:sender];
            return;
        }

        NADBuffer *buffer = [[NADBuffer alloc] initWithObject:response.obResponse modelclass:modelclass isArray:isArray];
        if (buffer) {
            if (successBlock) {
                successBlock(buffer);
            }
        } else {
            response.strManualErrorMag = [self errorInfoWithType:NAHttpErrorTypeData];
            if (failBlock) {
                failBlock(response);
            }
        }
        [[NAHttpRequestManager sharedInstance] removeRequest:request forSender:sender];
    } onRequestFailed:^(NAHttpResponse *response) {
        if (failBlock) {
            failBlock(response);
        }
        [[NAHttpRequestManager sharedInstance] removeRequest:request forSender:sender];
    }];

    [[NAHttpRequestManager sharedInstance] addRequest:request forSender:sender];
}

+ (void)transcationWithUploadRequest:(NAHttpRequest *)request
                           onSuccess:(void (^)())successBlock
                            onFailed:(NARequestFailedBlock)failBlock
                              sender:(NSString *)sender {
    [request startAsyncOnUploadRequestFinished:^(NAHttpResponse *response) {
        if (response.nStatusCode != 200) {
            NSLog(@"ResponseErrorMsg:%@", response.strResponseErrorMsg);
            if (failBlock) {
                failBlock(response);
            }
            [[NAHttpRequestManager sharedInstance] removeRequest:request forSender:sender];
            return;
        }

        if (successBlock) {
            successBlock();
        }
        [[NAHttpRequestManager sharedInstance] removeRequest:request forSender:sender];
    } onRequestFailed:^(NAHttpResponse *response) {
        response.strManualErrorMag = [self errorInfoWithType:NAHttpErrorTypeConnect];
        if (failBlock) {
            failBlock(response);
        }
        [[NAHttpRequestManager sharedInstance] removeRequest:request forSender:sender];
    }];

    [[NAHttpRequestManager sharedInstance] addRequest:request forSender:sender];
}

+ (void)transcationWithUploadRequest:(NAHttpRequest *)request
                             keyName:(NSString *)keyName
                           onSuccess:(void (^)(id obj))successBlock
                            onFailed:(NARequestFailedBlock)failBlock
                              sender:(NSString *)sender {
    [request startAsyncOnUploadRequestFinished:^(NAHttpResponse *response) {
        if (response.nStatusCode != 200) {
            NSLog(@"ResponseErrorMsg:%@", response.strResponseErrorMsg);
            if (failBlock) {
                failBlock(response);
            }
            [[NAHttpRequestManager sharedInstance] removeRequest:request forSender:sender];
            return;
        }

        id value = response.obResponse[keyName];
        if (value) {
            if (successBlock) {
                successBlock(value);
            }
        } else {
            response.strManualErrorMag = [self errorInfoWithType:NAHttpErrorTypeData];
            if (failBlock) {
                failBlock(response);
            }
        }
        [[NAHttpRequestManager sharedInstance] removeRequest:request forSender:sender];
    } onRequestFailed:^(NAHttpResponse *response) {
        response.strManualErrorMag = [self errorInfoWithType:NAHttpErrorTypeConnect];
        if (failBlock) {
            failBlock(response);
        }
        [[NAHttpRequestManager sharedInstance] removeRequest:request forSender:sender];
    }];

    [[NAHttpRequestManager sharedInstance] addRequest:request forSender:sender];
}

+ (void)transcationWithUploadRequest:(NAHttpRequest *)request
                          modelclass:(Class)modelclass
                             isArray:(BOOL)isArray
                           onSuccess:(void (^)(id obj))successBlock
                            onFailed:(NARequestFailedBlock)failBlock
                              sender:(NSString *)sender {
    [request startAsyncOnUploadRequestFinished:^(NAHttpResponse *response) {
        if (response.nStatusCode != 200) {
            NSLog(@"ResponseErrorMsg:%@", response.strResponseErrorMsg);
            if (failBlock) {
                failBlock(response);
            }
            [[NAHttpRequestManager sharedInstance] removeRequest:request forSender:sender];
            return;
        }

        if ([modelclass isSubclassOfClass:[NADBase class]]) {
            if (isArray) {
                id jsmodels = [modelclass arrayOfModelWithData:response.dataResponse];
                if (jsmodels) {
                    if (successBlock) {
                        successBlock(jsmodels);
                    }
                } else {
                    response.strManualErrorMag = [self errorInfoWithType:NAHttpErrorTypeData];
                    if (failBlock) {
                        failBlock(response);
                    }
                }
            } else {
                id jsmodel = [[modelclass alloc] initWithData:response.dataResponse];
                if (jsmodel) {
                    if (successBlock) {
                        successBlock(jsmodel);
                    }
                } else {
                    response.strManualErrorMag = [self errorInfoWithType:NAHttpErrorTypeData];
                    if (failBlock) {
                        failBlock(response);
                    }
                }
            }
        } else if (modelclass == nil && isArray) {
            id jsmodel = response.obResponse;
            if (jsmodel && [jsmodel isKindOfClass:[NSArray class]]) {
                if (successBlock) {
                    successBlock(jsmodel);
                }
            } else {
                response.strManualErrorMag = [self errorInfoWithType:NAHttpErrorTypeData];
                if (failBlock) {
                    failBlock(response);
                }
            }
        } else {
            response.strManualErrorMag = [self errorInfoWithType:NAHttpErrorTypeNoJsonModel];
            if (failBlock) {
                failBlock(response);
            }
        }
        [[NAHttpRequestManager sharedInstance] removeRequest:request forSender:sender];
    } onRequestFailed:^(NAHttpResponse *response) {
        response.strManualErrorMag = [self errorInfoWithType:NAHttpErrorTypeConnect];
        if (failBlock) {
            failBlock(response);
        }
        [[NAHttpRequestManager sharedInstance] removeRequest:request forSender:sender];
    }];

    [[NAHttpRequestManager sharedInstance] addRequest:request forSender:sender];
}


@end
