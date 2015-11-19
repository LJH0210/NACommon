//
//  NALog.h
//  NACommon
//
//  Created by  on 4/13/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <NSLogger.h>

#if DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

@interface NALog : NSObject

@end
