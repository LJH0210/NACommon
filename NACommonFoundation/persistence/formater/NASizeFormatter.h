//
//  NASizeFormatter.h
//  NACommon
//
//  Created by  on 4/2/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NASizeFormatter : NSObject

+ (CGSize)sizeForText:(NSString *)text font:(UIFont *)font tosize:(CGSize)tosize;

@end
