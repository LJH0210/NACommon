//
//  XXJCity.h
//  XXJCommon
//
//  Created by ND on 15/6/1.
//  Copyright (c) 2015年 xxjia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXJCity : NSObject<NSCoding>

@property(nonatomic, strong) NSString *citycode;
@property(nonatomic, strong) NSString *cityname;
@property(nonatomic, strong) NSString *pinyin;
@property(nonatomic, strong) NSString *py;
@property(nonatomic, assign) BOOL enable;
@property(nonatomic, strong) NSString *hot;

@end
