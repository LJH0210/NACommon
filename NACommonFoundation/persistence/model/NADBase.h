//
//  NADBase.h
//  NACommon
//
//  Created by  on 3/12/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModelLib.h>

@class NADBaseArray;

/**
 基于JSON的数据层基类
 */
@interface NADBase : JSONModel

/**
 *  @author , 15-03-25 19:03:00
 *
 *  通过字典初始化
 *
 *  @param dic 字典
 *
 *  @return 数据层对象
 */
- (instancetype)initWithDictionary:(NSDictionary *)dic;
/**
 *  @author , 15-03-25 19:03:39
 *
 *  通过NSData初始化
 *
 *  @param data NSData
 *
 *  @return 数据层对象
 */
- (instancetype)initWithData:(NSData *)data;
/**
 *  @author , 15-03-25 19:03:12
 *
 *  通过加密数据初始化
 *
 *  @param edata 加密数据
 *
 *  @return 数据层对象
 */
- (instancetype)initWithEncryptedData:(NSData *)edata;

/**
 *  将jason data装换成BMDBaseArray对象
 *
 *  @param data json Data
 *
 *  @return BMDBaseArray对象
 */
+ (NADBaseArray *)arrayForJSONModelWithData:(NSData *)data;
/**
 *  @author , 15-03-25 19:03:50
 *
 *  将json data转化成数据层对象数据
 *
 *  @param data json data
 *
 *  @return 数据层对象数组
 */
+ (NSMutableArray *)arrayOfModelWithData:(NSData *)data;
/**
 *  @author , 15-03-25 19:03:47
 *
 *  将字典数组转化成数据层对象数组
 *
 *  @param array 字典数组
 *
 *  @return 数据层对象
 */
+ (NSMutableArray *)arrayOfModelWithDictionaries:(NSArray *)array;

@end

/**
 NADBase的列表类
 */
@interface NADBaseArray : JSONModelArray

/**
 *  @author , 15-03-25 19:03:32
 *
 *  通过数据层对象数组和数据层类初始化
 *
 *  @param array 数据层对象数据
 *  @param cls   数据层类
 *
 *  @return NADBaseArray对象
 */
- (instancetype)initWithArray:(NSArray *)array modelClass:(Class)cls;

@end
