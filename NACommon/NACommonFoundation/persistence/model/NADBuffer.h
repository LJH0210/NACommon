//
//  NADBuffer.h
//  NACommon
//
//  Created by  on 8/6/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NADBuffer : NSObject

@property(nonatomic, readonly) NSString *strKey;
@property(nonatomic, readonly) Class classJsonModel;
@property(nonatomic, readonly) BOOL blIsArray;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary key:(NSString *)key;
- (instancetype)initWithData:(NSData *)data modelclass:(Class)modelclass isArray:(BOOL)isArray;
- (instancetype)initWithObject:(NSObject *)object modelclass:(Class)modelclass isArray:(BOOL)isArray;

- (id)objectForKey;
- (id)objectForModelClass;
- (id)arrayForModelClass;
- (NSInteger)countOfArray;
- (id)itemInArrayAtIndex:(NSInteger)index;

@end
