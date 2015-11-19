//
//  NAKeyChain.h
//  NACommon
//
//  Created by ND on 15/8/25.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NAKeyChain : NSObject

+ (void)NA_saveWithKeyInKeyChain:(NSString *)service data:(id)data;
+ (id)NA_loadWithKeyInKeyChain:(NSString *)service;
+ (void)NA_deleteWithKeyInKeyChain:(NSString *)service;

@end
