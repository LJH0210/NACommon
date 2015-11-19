//
//  NAAFHttpRequest.m
//  NACommon
//
//  Created by  on 3/11/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import "NAAFHttpRequest.h"
#import <AFNetworking/AFNetworking.h>
#import "NALog.h"
#import "NADataSecurity.h"

@interface NAAFHttpRequest () {
    AFHTTPRequestOperation *_requestOperation;
    NSURLSessionDownloadTask *_downloadTask;
}

@end

@implementation NAAFHttpRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        self.strMethod = @"GET";
        self.strContentType = @"application/json";
    }
    return self;
}

- (void)startAsyncOnRequestFinished:(NARequestFinishedBlock)finishedBlock onRequestFailed:(NARequestFailedBlock)failedBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if ([self.strContentType rangeOfString:@"json"].location != NSNotFound) {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }

    if (self.blHttpsEnable) {
        AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
        [securityPolicy setAllowInvalidCertificates:YES];
        [manager setSecurityPolicy:securityPolicy];
    }

    [manager.requestSerializer setTimeoutInterval:self.nTimeout];
    [manager.requestSerializer setValue:self.strContentType forHTTPHeaderField:@"Content-Type"];
    if (self.dataAccessToken.length) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", [NADataSecurity toStringWithEnData:self.dataAccessToken]]
                         forHTTPHeaderField:@"Authorization"];
    }

    if ([self.strMethod isEqualToString:@"GET"]) {
        _requestOperation = [manager GET:self.strUrl
            parameters:self.obPara
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NAHttpResponse *response = [NAHttpResponse responseWithStautsCode:operation.response.statusCode
                                                                       responseData:[operation responseData]
                                                                     responseObject:[operation responseObject]];
                if (finishedBlock) {
                    finishedBlock(response);
                }
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NAHttpResponse *response = [NAHttpResponse responseWithStautsCode:operation.response.statusCode
                                                                       responseData:[operation responseData]
                                                                     responseObject:[operation responseObject]];
                response.errRequest = error;
                response.strMsgOfError = [NAAFHttpRequest msgWithError:response.errRequest];
                if (failedBlock) {
                    failedBlock(response);
                }
            }];
    } else if ([self.strMethod isEqualToString:@"POST"]) {
        _requestOperation = [manager POST:self.strUrl
            parameters:self.obPara
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NAHttpResponse *response = [NAHttpResponse responseWithStautsCode:operation.response.statusCode
                                                                       responseData:[operation responseData]
                                                                     responseObject:[operation responseObject]];
                if (finishedBlock) {
                    finishedBlock(response);
                }
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NAHttpResponse *response = [NAHttpResponse responseWithStautsCode:operation.response.statusCode
                                                                       responseData:[operation responseData]
                                                                     responseObject:[operation responseObject]];
                response.errRequest = error;
                response.strMsgOfError = [NAAFHttpRequest msgWithError:response.errRequest];
                if (failedBlock) {
                    failedBlock(response);
                }
            }];
    } else if ([self.strMethod isEqualToString:@"DELETE"]) {
        _requestOperation = [manager DELETE:self.strUrl
            parameters:self.obPara
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NAHttpResponse *response = [NAHttpResponse responseWithStautsCode:operation.response.statusCode
                                                                       responseData:[operation responseData]
                                                                     responseObject:[operation responseObject]];
                if (finishedBlock) {
                    finishedBlock(response);
                }
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NAHttpResponse *response = [NAHttpResponse responseWithStautsCode:operation.response.statusCode
                                                                       responseData:[operation responseData]
                                                                     responseObject:[operation responseObject]];
                response.errRequest = error;
                response.strMsgOfError = [NAAFHttpRequest msgWithError:response.errRequest];
                if (failedBlock) {
                    failedBlock(response);
                }
            }];
    } else if ([self.strMethod isEqualToString:@"PUT"]) {
        _requestOperation = [manager PUT:self.strUrl
            parameters:self.obPara
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NAHttpResponse *response = [NAHttpResponse responseWithStautsCode:operation.response.statusCode
                                                                       responseData:[operation responseData]
                                                                     responseObject:[operation responseObject]];
                if (finishedBlock) {
                    finishedBlock(response);
                }
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NAHttpResponse *response = [NAHttpResponse responseWithStautsCode:operation.response.statusCode
                                                                       responseData:[operation responseData]
                                                                     responseObject:[operation responseObject]];
                response.errRequest = error;
                response.strMsgOfError = [NAAFHttpRequest msgWithError:response.errRequest];
                if (failedBlock) {
                    failedBlock(response);
                }
            }];
    } else {
        NAHttpResponse *response = [NAHttpResponse response];
        if (failedBlock) {
            failedBlock(response);
        }
    }
}

- (void)startAsyncOnUploadRequestFinished:(NARequestFinishedBlock)finishedBlock onRequestFailed:(NARequestFailedBlock)failedBlock {
    return [self startAsyncOnUploadRequestFinished:finishedBlock onRequestFailed:failedBlock progress:nil];
}

- (void)startAsyncOnUploadRequestFinished:(NARequestFinishedBlock)finishedBlock
                          onRequestFailed:(NARequestFailedBlock)failedBlock
                                 progress:(NSProgress *)progress {
    self.strMethod = @"POST";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if ([self.strContentType rangeOfString:@"json"].location != NSNotFound) {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }

    if (self.blHttpsEnable) {
        AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
        [securityPolicy setAllowInvalidCertificates:YES];
        [manager setSecurityPolicy:securityPolicy];
    }

    [manager.requestSerializer setTimeoutInterval:self.nTimeout];
    [manager.requestSerializer setValue:self.strContentType forHTTPHeaderField:@"Content-Type"];
    if (self.dataAccessToken.length) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", [NADataSecurity toStringWithEnData:self.dataAccessToken]]
                         forHTTPHeaderField:@"Authorization"];
    }

    _requestOperation = [manager POST:self.strUrl
        parameters:self.obPara
        constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            for (NAHttpUploadObject *uploaditem in self.arrUpload) {
                if (!uploaditem.data || !uploaditem.strKey) {
                    continue;
                }

                if (!uploaditem.strName || !self.strContentType) {
                    [formData appendPartWithFormData:uploaditem.data name:uploaditem.strKey];
                } else {
                    [formData appendPartWithFileData:uploaditem.data name:uploaditem.strKey fileName:uploaditem.strName mimeType:self.strContentType];
                }
            }
        }
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NAHttpResponse *response = [NAHttpResponse responseWithStautsCode:operation.response.statusCode
                                                                   responseData:[operation responseData]
                                                                 responseObject:[operation responseObject]];
            if (finishedBlock) {
                finishedBlock(response);
            }
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NAHttpResponse *response = [NAHttpResponse responseWithStautsCode:operation.response.statusCode
                                                                   responseData:[operation responseData]
                                                                 responseObject:[operation responseObject]];
            response.errRequest = error;
            response.strMsgOfError = [NAAFHttpRequest msgWithError:response.errRequest];
            if (failedBlock) {
                failedBlock(response);
            }
        }];
}

- (void)startAsyncOnDownloadRequestFinished:(NARequestFinishedBlock)finishedBlock onRequestFailed:(NARequestFailedBlock)failedBlock {
    return [self startAsyncOnDownloadRequestFinished:finishedBlock onRequestFailed:failedBlock progress:nil];
}

- (void)startAsyncOnDownloadRequestFinished:(NARequestFinishedBlock)finishedBlock
                            onRequestFailed:(NARequestFailedBlock)failedBlock
                                   progress:(NSProgress *)progress {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSURL *URL = [NSURL URLWithString:self.strUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    _downloadTask = [manager downloadTaskWithRequest:request
        progress:&progress
        destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            NSURL *documentsDirectoryURL =
                [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        }
        completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            NSLog(@"File downloaded to: %@", filePath);
            if (error) {
                NSLog(@"Error: %@", error);
                NAHttpResponse *NAresponse = [NAHttpResponse response];
                NAresponse.errRequest = error;
                NAresponse.strMsgOfError = [NAAFHttpRequest msgWithError:NAresponse.errRequest];
                if (failedBlock) {
                    failedBlock(NAresponse);
                }
            } else {
                NSLog(@"Success: %@ %@", response, filePath);
                NAHttpResponse *NAresponse = [NAHttpResponse response];
                NAresponse.nStatusCode = 200;
                if (finishedBlock) {
                    finishedBlock(NAresponse);
                }
            }
        }];
    [_downloadTask resume];
}

- (void)cancel {
    [_requestOperation cancel];
    [_downloadTask cancel];
}

+ (NSString *)msgWithError:(NSError *)error {
    NSString *strerror = nil;
    switch (error.code) {
    case -998:
        strerror = @"网络连接失败";
        break;
    case -1001:
        strerror = @"网络请求超时";
        break;
    case -1004:
        strerror = @"无法访问服务器";
        break;
    case -1005:
    case -1009:
        strerror = @"请检查网络是否正常";
        break;
    case -999:
        strerror = @"网络请求已取消";
        break;
    case -1000:
    case -1002:
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
