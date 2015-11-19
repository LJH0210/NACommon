//
//  NADataSecurity.h
//  NACommon
//
//  Created by  on 3/23/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  @author , 15-03-25 19:03:55
 *
 *  NACommon中加密工具类
 */
@interface NADataSecurity : NSObject

+ (NSString *) toStringWithEnData : (NSData *)data;

@end
