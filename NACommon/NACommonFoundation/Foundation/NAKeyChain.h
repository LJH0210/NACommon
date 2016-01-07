//
//  NAKeyChain.h
//  NACommon
//
//  Created by ND on 15/8/25.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NAKeyChain : NSObject

+ (void)na_saveWithKeyInKeyChain:(NSString *)service data:(id)data;
+ (id)na_loadWithKeyInKeyChain:(NSString *)service;
+ (void)na_deleteWithKeyInKeyChain:(NSString *)service;

@end
