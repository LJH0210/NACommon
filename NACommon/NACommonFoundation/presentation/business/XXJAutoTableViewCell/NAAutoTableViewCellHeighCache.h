//
//  NAAutoTableViewCellHeighCache.h
//  NACommon
//
//  Created by ND on 15/6/5.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface NAAutoTableViewCellHeighCache : NSObject

+ (NAAutoTableViewCellHeighCache *)shareInstance;

- (CGFloat)labelHeightWithString:(NSString *)string width:(int)width font:(UIFont *)font useCache:(BOOL)useCache;
- (void)removeLabelHeightCache;

- (CGFloat)cellHightWithCacheKey:(NSString *)cacheKey indexPath:(NSIndexPath *)indexPath;
- (void)addCellHightWithCacheKey:(NSString *)cacheKey indexPath:(NSIndexPath *)indexPath cellHeight:(CGFloat)height;
- (void)removeCacheHighWithCacheKey:(NSString *)cacheKey;

@end
