//
//  NADBase.m
//  NACommon
//
//  Created by  on 3/12/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import "NADBase.h"
#import "NALog.h"

@implementation NADBase

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{ @"id" : @"object_id" }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    if (!dic) {
        return nil;
    }

    @try {
        self = [super initWithDictionary:dic error:NULL];
    } @catch (NSException *exception) {
        NSLog(@"[JSONModel Exception] name:%@,reason:%@", exception.name, exception.reason);
        self = nil;
    } @finally {
    }

    if (self) {
    }

    return self;
}

- (instancetype)initWithData:(NSData *)data {
    if (!data) {
        return nil;
    }

    @try {
        self = [super initWithData:data error:NULL];
    } @catch (NSException *exception) {
        NSLog(@"[JSONModel Exception] name:%@,reason:%@", exception.name, exception.reason);
        self = nil;
    } @finally {
    }

    if (self) {
    }

    return self;
}

- (instancetype)initWithEncryptedData:(NSData *)edata {
    if (!edata) {
        return nil;
    }

    NSData *data = nil;
    if (!data) {
        return nil;
    }

    @try {
        self = [super initWithData:data error:NULL];
    } @catch (NSException *exception) {
        NSLog(@"[JSONModel Exception] name:%@,reason:%@", exception.name, exception.reason);
        self = nil;
    } @finally {
    }

    if (self) {
    }

    return self;
}

+ (NADBaseArray *)arrayForJSONModelWithData:(NSData *)data {
    if (!data) {
        return nil;
    }

    NADBaseArray *baseArray = nil;
    @try {
        NSMutableArray *array = [self arrayOfModelsFromData:data error:NULL];
        if (array) {
            baseArray = [[NADBaseArray alloc] initWithArray:array modelClass:[self class]];
        }
    } @catch (NSException *exception) {
        NSLog(@"[JSONModel Exception] name:%@,reason:%@", exception.name, exception.reason);
        baseArray = nil;
    } @finally {
    }

    return baseArray;
}

+ (NSMutableArray *)arrayOfModelWithData:(NSData *)data {
    if (!data) {
        return nil;
    }

    NSMutableArray *array = nil;
    @try {
        array = [self arrayOfModelsFromData:data error:NULL];
    } @catch (NSException *exception) {
        NSLog(@"[JSONModel Exception] name:%@,reason:%@", exception.name, exception.reason);
        array = nil;
    } @finally {
    }

    return array;
}

+ (NSMutableArray *)arrayOfModelWithDictionaries:(NSArray *)array {
    if (!array) {
        return nil;
    }

    NSMutableArray *modelArray = nil;
    @try {
        modelArray = [self arrayOfModelsFromDictionaries:array error:NULL];
    } @catch (NSException *exception) {
        NSLog(@"[JSONModel Exception] name:%@,reason:%@", exception.name, exception.reason);
        modelArray = nil;
    } @finally {
    }

    return modelArray;
}

@end

@implementation NADBaseArray

- (instancetype)initWithArray:(NSArray *)array modelClass:(Class)cls {
    if (!array) {
        return nil;
    }

    @try {
        self = [super initWithArray:array modelClass:cls];
    } @catch (NSException *exception) {
        NSLog(@"[JSONModel Exception] name:%@,reason:%@", exception.name, exception.reason);
        self = nil;
    } @finally {
    }

    return self;
}

@end
