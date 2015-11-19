//
//  NACity.m
//  NACommon
//
//  Created by ND on 15/6/1.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NACity.h"

@implementation NACity

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.citycode forKey:@"citycode"];
    [aCoder encodeObject:self.cityname forKey:@"cityname"];
    [aCoder encodeObject:self.pinyin forKey:@"pinyin"];
    [aCoder encodeObject:self.py forKey:@"py"];
    [aCoder encodeObject:[NSNumber numberWithBool:self.enable] forKey:@"enable"];
    [aCoder encodeObject:self.hot forKey:@"hot"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.citycode = [aDecoder decodeObjectForKey:@"citycode"];
        self.cityname = [aDecoder decodeObjectForKey:@"cityname"];
        self.pinyin = [aDecoder decodeObjectForKey:@"pinyin"];
        self.py = [aDecoder decodeObjectForKey:@"py"];
        self.enable = [[aDecoder decodeObjectForKey:@"enable"] boolValue];
        self.hot = [aDecoder decodeObjectForKey:@"hot"];
    }
    return self;
}

@end
