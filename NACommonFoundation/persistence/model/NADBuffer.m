//
//  NADBuffer.m
//  NACommon
//
//  Created by  on 8/6/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import "NADBuffer.h"
#import "NADBase.h"

@interface NADBuffer () {
    NSObject *_obJson;
    NSString *_strKey;
    Class _classJsonModel;
    BOOL _blIsArray;
}

@end

@implementation NADBuffer

- (Class)classJModel {
    return _classJsonModel;
}

- (BOOL)blIsArray {
    return _blIsArray;
}

- (NSString *)strKey {
    return _strKey;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary key:(NSString *)key {
    if (!dictionary || ![key length]) {
        return nil;
    }

    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        return nil;
    }

    self = [super init];
    if (self) {
        _obJson = [dictionary copy];
        _strKey = [key copy];
    }

    return self;
}

- (instancetype)initWithData:(NSData *)data modelclass:(Class)modelclass isArray:(BOOL)isArray {
    if (![modelclass isSubclassOfClass:[NADBase class]] || !data) {
        return nil;
    }

    id object = nil;
    @try {
        object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
    } @catch (NSException *exception) {
        object = nil;
    } @finally {
    }

    if (!object) {
        return nil;
    }

    if (![object isKindOfClass:[NSDictionary class]] && ![object isKindOfClass:[NSArray class]]) {
        return nil;
    }

    if (isArray && ![object isKindOfClass:[NSArray class]]) {
        return nil;
    }

    if (!isArray && ![object isKindOfClass:[NSDictionary class]]) {
        return nil;
    }

    self = [super init];
    if (self) {
        _obJson = [object copy];
        _classJsonModel = modelclass;
        _blIsArray = isArray;
    }

    return self;
}

- (instancetype)initWithObject:(NSObject *)object modelclass:(Class)modelclass isArray:(BOOL)isArray {
    if (![modelclass isSubclassOfClass:[NADBase class]] || !object) {
        return nil;
    }

    if (![object isKindOfClass:[NSDictionary class]] && ![object isKindOfClass:[NSArray class]]) {
        return nil;
    }

    if (isArray && ![object isKindOfClass:[NSArray class]]) {
        return nil;
    }

    if (!isArray && ![object isKindOfClass:[NSDictionary class]]) {
        return nil;
    }

    self = [super init];
    if (self) {
        _obJson = [object copy];
        _classJsonModel = modelclass;
        _blIsArray = isArray;
    }

    return self;
}

- (id)objectForKey {
    NSDictionary *dic = (NSDictionary *)_obJson;
    return dic[_strKey];
}

- (id)objectForModelClass {
    if (_blIsArray) {
        return nil;
    } else {
        id jsmodel = [[_classJsonModel alloc] initWithDictionary:(NSDictionary *)_obJson];
        return jsmodel;
    }
}

- (id)arrayForModelClass {
    if (_blIsArray) {
        id jsmodels = [_classJsonModel arrayOfModelWithDictionaries:(NSArray *)_obJson];
        return jsmodels;
    } else {
        return nil;
    }
}

- (NSInteger)countOfArray {
    if (!_blIsArray) {
        return 0;
    }

    NSArray *items = (NSArray *)_obJson;
    return [items count];
}

- (id)itemInArrayAtIndex:(NSInteger)index {
    if (!_blIsArray) {
        return nil;
    }

    NSArray *items = (NSArray *)_obJson;
    if (index < items.count) {
        NSDictionary *item = items[index];
        id jsmodel = [[_classJsonModel alloc] initWithDictionary:item];
        return jsmodel;
    }

    return nil;
}

@end
