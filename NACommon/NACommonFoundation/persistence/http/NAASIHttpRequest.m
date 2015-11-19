//
//  NAASIHttpRequest.m
//  NACommon
//
//  Created by  on 3/9/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import "NAASIHttpRequest.h"
#import <ASIHTTPRequest/ASIFormDataRequest.h>
#import "NALog.h"
#import "NADataSecurity.h"

@interface NAASIHttpRequest () {
    ASIFormDataRequest *_request;
}

@end

@implementation NAASIHttpRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        self.strMethod = @"GET";
        self.strContentType = @"application/json";
    }
    return self;
}

- (void)startAsyncOnRequestFinished:(NARequestFinishedBlock)finishedBlock onRequestFailed:(NARequestFailedBlock)failedBlock {
    _request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:self.strUrl]];
    _request.timeOutSeconds = self.nTimeout;
    _request.requestMethod = self.strMethod;

    //增加特殊Headers设置接口
    for (NSString *key in self.dicHeader.allKeys) {
        [_request addRequestHeader:key value:self.dicHeader[key]];
    }

    [_request addRequestHeader:@"Content-Type" value:self.strContentType];
    if (self.dataAccessToken.length) {
        [_request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Bearer %@", [NADataSecurity toStringWithEnData:self.dataAccessToken]]];
    }
    if (self.stringAccessToken.length) {
        [_request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Bearer %@", self.stringAccessToken]];
    }

    if (self.obPara) {
        if ([self.obPara isKindOfClass:[NSData class]]) {
            NSMutableData *body = [[NSMutableData alloc] init];
            [body setData:(NSData *)self.obPara];
            [_request setPostBody:body];
        } else {
            NSData *jdata = [NSJSONSerialization dataWithJSONObject:self.obPara options:NSJSONWritingPrettyPrinted error:NULL];
            NSMutableData *body = [[NSMutableData alloc] init];
            [body setData:jdata];
            [_request setPostBody:body];
        }
    }

    if ([self.strMethod isEqualToString:@"DELETE"]) {
        [_request buildPostBody];
    }
    if (self.blHttpsEnable) {
        [_request setValidatesSecureCertificate:NO];
    }

    __weak typeof(_request) weakRequest = _request;
    [_request setCompletionBlock:^{
        NAHttpResponse *response = [NAHttpResponse responseWithStautsCode:weakRequest.responseStatusCode
                                                               responseData:[weakRequest responseData]
                                                             responseObject:[NAASIHttpRequest responseObjectWithRequest:weakRequest]];
        if (finishedBlock) {
            finishedBlock(response);
        }
        [weakRequest clearDelegatesAndCancel];
    }];
    [_request setFailedBlock:^{
        NSLog(@"requestFailed error:%@", [weakRequest error]);
        NAHttpResponse *response = [NAHttpResponse responseWithStautsCode:weakRequest.responseStatusCode
                                                               responseData:[weakRequest responseData]
                                                             responseObject:[NAASIHttpRequest responseObjectWithRequest:weakRequest]];
        response.errRequest = [weakRequest error];
        response.strMsgOfError = [NAASIHttpRequest msgWithError:response.errRequest];
        if (failedBlock) {
            failedBlock(response);
        }
        [weakRequest clearDelegatesAndCancel];
    }];
    [_request startAsynchronous];
}

- (void)startAsyncOnUploadRequestFinished:(NARequestFinishedBlock)finishedBlock onRequestFailed:(NARequestFailedBlock)failedBlock {
    self.strMethod = @"POST";

    _request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:self.strUrl]];
    _request.delegate = self;
    _request.timeOutSeconds = self.nTimeout;
    _request.requestMethod = self.strMethod;
    if (self.dataAccessToken.length) {
        [_request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Bearer %@", [NADataSecurity toStringWithEnData:self.dataAccessToken]]];
    }
    if (self.stringAccessToken.length) {
        [_request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Bearer %@", self.stringAccessToken]];
    }

    if ([self.obPara isKindOfClass:[NSDictionary class]]) {
        NSDictionary *para = (NSDictionary *)self.obPara;
        for (id key in para.allKeys) {
            [_request setPostValue:para[key] forKey:key];
        }
    }

    for (NAHttpUploadObject *uploaditem in self.arrUpload) {
        if (!uploaditem.data || !uploaditem.strKey) {
            continue;
        }

        if (!uploaditem.strName || !self.strContentType) {
            [_request addData:uploaditem.data forKey:uploaditem.strKey];
        } else {
            [_request addData:uploaditem.data withFileName:uploaditem.strName andContentType:self.strContentType forKey:uploaditem.strKey];
        }
    }

    if (self.blHttpsEnable) {
        [_request setValidatesSecureCertificate:NO];
    }

    __weak typeof(_request) weakRequest = _request;
    [_request setCompletionBlock:^{
        NAHttpResponse *response = [NAHttpResponse responseWithStautsCode:weakRequest.responseStatusCode
                                                               responseData:[weakRequest responseData]
                                                             responseObject:[NAASIHttpRequest responseObjectWithRequest:weakRequest]];
        if (finishedBlock) {
            finishedBlock(response);
        }
        [weakRequest clearDelegatesAndCancel];
    }];
    [_request setFailedBlock:^{
        NSLog(@"requestFailed error:%@", [weakRequest error]);
        NAHttpResponse *response = [NAHttpResponse responseWithStautsCode:weakRequest.responseStatusCode
                                                               responseData:[weakRequest responseData]
                                                             responseObject:[NAASIHttpRequest responseObjectWithRequest:weakRequest]];
        response.errRequest = [weakRequest error];
        response.strMsgOfError = [NAASIHttpRequest msgWithError:response.errRequest];
        if (failedBlock) {
            failedBlock(response);
        }
        [weakRequest clearDelegatesAndCancel];
    }];
    [_request startAsynchronous];
}

- (void)startAsyncOnDownloadRequestFinished:(NARequestFinishedBlock)finishedBlock onRequestFailed:(NARequestFailedBlock)failedBlock {
    if (![self.strMethod isEqualToString:@"GET"]) {
        NAHttpResponse *response = [NAHttpResponse response];
        failedBlock(response);
        return;
    }

    _request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:self.strUrl]];
    _request.delegate = self;
    _request.timeOutSeconds = self.nTimeout;
    _request.requestMethod = self.strMethod;
    [_request addRequestHeader:@"Content-Type" value:self.strContentType];
    if (self.dataAccessToken.length) {
        [_request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Bearer %@", [NADataSecurity toStringWithEnData:self.dataAccessToken]]];
    }
    if (self.stringAccessToken.length) {
        [_request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Bearer %@", self.stringAccessToken]];
    }

    if (self.blHttpsEnable) {
        [_request setValidatesSecureCertificate:NO];
    }

    __weak typeof(_request) weakRequest = _request;
    [_request setCompletionBlock:^{
        NAHttpResponse *response = [NAHttpResponse responseWithStautsCode:weakRequest.responseStatusCode
                                                               responseData:[weakRequest responseData]
                                                             responseObject:[NAASIHttpRequest responseObjectWithRequest:weakRequest]];
        if (finishedBlock) {
            finishedBlock(response);
        }
        [weakRequest clearDelegatesAndCancel];
    }];
    [_request setFailedBlock:^{
        NSLog(@"requestFailed error:%@", [weakRequest error]);
        NAHttpResponse *response = [NAHttpResponse responseWithStautsCode:weakRequest.responseStatusCode
                                                               responseData:[weakRequest responseData]
                                                             responseObject:[NAASIHttpRequest responseObjectWithRequest:weakRequest]];
        response.errRequest = [weakRequest error];
        response.strMsgOfError = [NAASIHttpRequest msgWithError:response.errRequest];
        if (failedBlock) {
            failedBlock(response);
        }
        [weakRequest clearDelegatesAndCancel];
    }];
    [_request startAsynchronous];
}

- (void)cancel {
    if ([_request isExecuting]) {
        [_request clearDelegatesAndCancel];
    }
    _request = nil;
}

+ (id)responseObjectWithRequest:(ASIHTTPRequest *)request {
    NSData *responsedata = [request responseData];
    if (!responsedata) {
        return nil;
    }

    id object = nil;
    @try {
        object = [NSJSONSerialization JSONObjectWithData:responsedata options:NSJSONReadingMutableContainers error:NULL];
    } @catch (NSException *exception) {
        object = nil;
    } @finally {
    }

    return object;
}

+ (NSString *)msgWithError:(NSError *)error {
    NSString *strerror = nil;
    switch (error.code) {
    case 1:
        strerror = @"网络连接失败";
        break;
    case 2:
        strerror = @"网络请求超时";
        break;
    case 3:
        strerror = @"网络认证失败";
        break;
    case 4:
        strerror = @"网络请求已取消";
        break;
    case 5:
        strerror = @"无法创建网络请求，非法的URL？";
        break;

    default:
        break;
    }

    if (!strerror.length) {
        strerror = error.userInfo[@"NSLocalizedDescription"];
        if (!strerror.length) {
            strerror = @"网络请求失败，请检查网络是否正常";
        }
    }

    return strerror;
}

@end
