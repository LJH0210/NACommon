//
//  NAHttpResponse.m
//  NACommon
//
//  Created by  on 3/11/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import "NAHttpResponse.h"

@implementation NAHttpResponse

+ (instancetype)response {
    NAHttpResponse *resp = [[NAHttpResponse alloc] init];
    return resp;
}

+ (instancetype)responseWithStautsCode:(NSInteger)statuscode responseData:(NSData *)responsedata {
    NAHttpResponse *resp = [[NAHttpResponse alloc] init];
    resp.nStatusCode = statuscode;
    resp.dataResponse = [responsedata copy];
    return resp;
}

+ (instancetype)responseWithStautsCode:(NSInteger)statuscode responseObject:(id)responseobject {
    NAHttpResponse *resp = [[NAHttpResponse alloc] init];
    resp.nStatusCode = statuscode;
    resp.obResponse = [responseobject copy];
    return resp;
}

+ (instancetype)responseWithStautsCode:(NSInteger)statuscode responseData:(NSData *)responsedata responseObject:(id)responseobject {
    NAHttpResponse *resp = [[NAHttpResponse alloc] init];
    resp.nStatusCode = statuscode;
    resp.dataResponse = [responsedata copy];
    resp.obResponse = [responseobject copy];
    return resp;
}

- (NSString *)strResponseErrorMsg {
    return [self responseErrorMsg];
}

- (int)nResponseErrorCode {
    return [self responseErrorCode];
}

- (NSString *)strErrorPrompts {
    if (self.strManualErrorMag.length) {
        return self.strManualErrorMag;
    }

    if ([self responseErrorMsg]) {
        return [self responseErrorMsg];
    }

    NSString *strerror = self.strMsgOfError.length ? self.strMsgOfError : @"";

    return strerror;
}

- (NSString *)responseErrorMsg {
    NSString *errmsg = nil;

    id errorinfo = nil;
    id responseobject = self.obResponse;
    if (responseobject) {
        if ([responseobject isKindOfClass:[NSDictionary class]]) {
            errorinfo = responseobject[@"error"];
        }

        if (errorinfo) {
            if ([errorinfo isKindOfClass:[NSDictionary class]]) {
                errmsg = errorinfo[@"msg"];
            } else if ([errorinfo isKindOfClass:[NSString class]]) {
                errmsg = errorinfo;
            } else
                errmsg = @"服务器异常!";
        } else
            errmsg = @"服务器异常!";
    }

    return errmsg;
}

- (int)responseErrorCode {
    int code = -1;

    if (nil == self.obResponse) {
        return code;
    }

    id errorinfo = nil;
    if ([self.obResponse isKindOfClass:[NSDictionary class]]) {
        errorinfo = self.obResponse[@"error"];
    }

    if (errorinfo && [errorinfo isKindOfClass:[NSDictionary class]]) {
        code = [errorinfo[@"code"] intValue];
    }

    return code;
}

@end
