//
//  NADataSerializer.h
//  NACommon
//
//  Created by  on 3/14/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @author , 15-03-25 18:03:59
 *
 *  支持序列化的对象
 */
@interface NADataSerializer : NSObject<NSCoding>

/**
 *  @author , 15-03-25 18:03:55
 *
 *  序列化文件路径
 *
 *  @return 路径
 */
+ (NSString *)pathForSerializerFile;
/**
 *  @author , 15-03-25 18:03:11
 *
 *  从本地文件载入对象
 *
 *  @param path 文件路径
 *
 *  @return 对象
 */
+ (instancetype)loadFileFromPath:(NSString *)path;

/**
 *  @author , 15-03-25 18:03:04
 *
 *  设置数据
 *
 *  @param data 数据
 *  @param aKey key
 */
- (void)setData:(id)data forKey:(NSString *)aKey;
/**
 *  @author , 15-03-25 18:03:31
 *
 *  通过key获取数据
 *
 *  @param aKey key
 *
 *  @return 数据
 */
- (id)dataForKey:(NSString *)aKey;
/**
 *  @author , 15-03-25 19:03:13
 *
 *  通过key删除数据
 *
 *  @param aKey key
 */
- (void)removeDataForKey:(NSString *)aKey;
/**
 *  @author , 15-03-25 19:03:41
 *
 *  删除所有数据
 */
- (void)removeAllData;

/**
 *  @author , 15-03-25 19:03:51
 *
 *  保存到指定路径
 *
 *  @param path 路径
 *
 *  @return 是否成功
 */
- (BOOL)saveFileToPath:(NSString *)path;

@end
