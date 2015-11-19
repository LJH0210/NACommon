//
//  XXJAutoTableViewCellHeighCache.m
//  XXJCommon
//
//  Created by ND on 15/6/5.
//  Copyright (c) 2015年 xxjia. All rights reserved.
//

#import "XXJAutoTableViewCellHeighCache.h"
#import <UIKit/UIKit.h>
#import "NSString+XXJFoundation.h"
#import "NSString+MD5.h"

@interface XXJAutoTableViewCellHeighCache ()
@property(strong) NSMutableDictionary *cache;
@property(strong) NSMutableDictionary *mdCache;
@end

@implementation XXJAutoTableViewCellHeighCache

+ (XXJAutoTableViewCellHeighCache *)shareInstance {
    static XXJAutoTableViewCellHeighCache *autoCache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        autoCache = [[super alloc] init];
        autoCache.cache = [[NSMutableDictionary alloc] init];
        autoCache.mdCache = [[NSMutableDictionary alloc] init];
    });
    return autoCache;
}

- (CGFloat)labelHeightWithString:(NSString *)string width:(int)width font:(UIFont *)font useCache:(BOOL)useCache {
    float height = 0;
    if (!useCache) {
        height = [string xxj_countHeighWithWidth:width font:font];
        return height;
    }
    NSString *key = [self md5WithString:string width:width font:font];

    if (key) {
        height = [[[XXJAutoTableViewCellHeighCache shareInstance].mdCache objectForKey:key] floatValue];
        if (height > 0) {
            return height;
        } else {
            height = [string xxj_countHeighWithWidth:width font:font];
            [[XXJAutoTableViewCellHeighCache shareInstance].mdCache setObject:[NSNumber numberWithFloat:height] forKey:key];
        }
    } else {
        height = [string xxj_countHeighWithWidth:width font:font];
        NSLog(@"构造UITableViewCell高度md5失败");
    }

    return height;
}

- (void)removeLabelHeightCache {
    [[XXJAutoTableViewCellHeighCache shareInstance].mdCache removeAllObjects];
}

- (NSString *)md5WithString:(NSString *)string width:(int)width font:(UIFont *)font {
    NSMutableString *st = [string mutableCopy];
    [st appendFormat:@"%i", width];
    [st appendFormat:@"%@", font.familyName];
    [st appendFormat:@"%@", font.fontName];
    [st appendFormat:@"%f", font.pointSize];
    [st appendFormat:@"%f", font.ascender];
    [st appendFormat:@"%f", font.descender];
    [st appendFormat:@"%f", font.capHeight];
    [st appendFormat:@"%f", font.xHeight];
    [st appendFormat:@"%f", font.lineHeight];
    [st appendFormat:@"%f", font.leading];
    return [st md5Hash];
}

- (CGFloat)cellHightWithCacheKey:(NSString *)cacheKey indexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *dic = [[XXJAutoTableViewCellHeighCache shareInstance].cache objectForKey:cacheKey];
    if ([XXJAutoTableViewCellHeighCache cellIndexPathToString:indexPath]) {
        return [[dic objectForKey:[XXJAutoTableViewCellHeighCache cellIndexPathToString:indexPath]] floatValue];
    }
    return 0;
}

- (void)addCellHightWithCacheKey:(NSString *)cacheKey indexPath:(NSIndexPath *)indexPath cellHeight:(CGFloat)height {
    NSMutableDictionary *dic = [[XXJAutoTableViewCellHeighCache shareInstance].cache objectForKey:cacheKey];
    if (!dic) {
        dic = [[NSMutableDictionary alloc] init];
    }
    [dic setObject:[NSNumber numberWithFloat:height] forKey:[XXJAutoTableViewCellHeighCache cellIndexPathToString:indexPath]];
}

- (void)removeCacheHighWithCacheKey:(NSString *)cacheKey {
    [[XXJAutoTableViewCellHeighCache shareInstance].cache removeObjectForKey:cacheKey];
}

+ (NSString *)cellIndexPathToString:(NSIndexPath *)indexpath {
    return [NSString stringWithFormat:@"%li,%li", indexpath.section, indexpath.row];
}

@end
