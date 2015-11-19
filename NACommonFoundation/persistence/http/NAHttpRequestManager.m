//
//  NAHttpRequestManager.m
//  XXJCommon
//
//  Created by LJH on 15/11/18.
//  Copyright © 2015年 xxjia. All rights reserved.
//

#import "NAHttpRequestManager.h"

@interface NAHttpRequestManager (){
    NSMutableArray *_arrmRequest;
}
@end

@implementation NAHttpRequestManager

+ (instancetype)sharedInstance {
    static NAHttpRequestManager *gHttpTranscations = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        gHttpTranscations = [[self alloc] init];
    });
    return gHttpTranscations;
}

- (void)addRequest:(NAHttpRequest *)request forSender:(NSString *)sender {
    if (!sender) {
        return;
    }
    
    request.obSender = sender;
    [_arrmRequest addObject:request];
}

- (void)removeRequest:(NAHttpRequest *)request forSender:(NSString *)sender {
    if (!sender) {
        return;
    }
    
    [request cancel];
    [_arrmRequest removeObject:request];
}

- (void)cancelRequestsBySender:(NSString *)sender {
    NSMutableArray *arrmremoved = [NSMutableArray array];
    
    for (NAHttpRequest *request in _arrmRequest) {
        if ([request.obSender isEqualToString:sender]) {
            [request cancel];
            [arrmremoved addObject:request];
        }
    }
    
    [_arrmRequest removeObjectsInArray:arrmremoved];
}

@end
