//
//  NADataSerializer.m
//  NACommon
//
//  Created by  on 3/14/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import "NADataSerializer.h"
#import "NALog.h"

@interface NADataSerializer () {
}

@property(nonatomic, strong) NSMutableDictionary *dicmPreference;

@end

@implementation NADataSerializer

+ (NSString *)pathForSerializerFile {
    NSString *strDocDir = [NSString stringWithFormat:@"%@/Documents/NAData/", NSHomeDirectory()];
    if (![[NSFileManager defaultManager] fileExistsAtPath:strDocDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:strDocDir withIntermediateDirectories:YES attributes:nil error:nil];
    }

    NSString *strfp = [strDocDir stringByAppendingPathComponent:@"/s.data"];
    return strfp;
}

+ (instancetype)loadFileFromPath:(NSString *)path {
    NADataSerializer *ds = nil;
    @try {
        ds = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    } @catch (NSException *exception) {
        ds = nil;
        NSLog(@"Exception : %@", exception);
    } @finally {
    }

    return ds;
}

#pragma mark NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_dicmPreference forKey:@"_dicmPreference"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _dicmPreference = [aDecoder decodeObjectForKey:@"_dicmPreference"];
    }
    return self;
}

#pragma mark
- (instancetype)init {
    self = [super init];
    if (self) {
        _dicmPreference = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setData:(id)data forKey:(NSString *)aKey {
    if (nil == data || nil == aKey) {
        return;
    }

    @synchronized(self) {
        [self.dicmPreference setValue:data forKey:aKey];
    }
}

- (id)dataForKey:(NSString *)aKey {
    id data = nil;

    @synchronized(self) {
        data = [self.dicmPreference objectForKey:aKey];
    }

    return data;
}

- (void)removeDataForKey:(NSString *)aKey {
    @synchronized(self) {
        [self.dicmPreference removeObjectForKey:aKey];
    }
}

- (void)removeAllData {
    @synchronized(self) {
        [self.dicmPreference removeAllObjects];
    }
}

- (BOOL)saveFileToPath:(NSString *)path {
    return [NSKeyedArchiver archiveRootObject:self toFile:path];
}

@end
