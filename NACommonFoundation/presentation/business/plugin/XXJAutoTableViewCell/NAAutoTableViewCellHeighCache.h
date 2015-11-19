//
//  XXJAutoTableViewCellHeighCache.h
//  XXJCommon
//
//  Created by ND on 15/6/5.
//  Copyright (c) 2015年 xxjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface XXJAutoTableViewCellHeighCache : NSObject

+ (XXJAutoTableViewCellHeighCache *)shareInstance;

- (CGFloat)labelHeightWithString:(NSString *)string width:(int)width font:(UIFont *)font useCache:(BOOL)useCache;
- (void)removeLabelHeightCache;

- (CGFloat)cellHightWithCacheKey:(NSString *)cacheKey indexPath:(NSIndexPath *)indexPath;
- (void)addCellHightWithCacheKey:(NSString *)cacheKey indexPath:(NSIndexPath *)indexPath cellHeight:(CGFloat)height;
- (void)removeCacheHighWithCacheKey:(NSString *)cacheKey;

@end
