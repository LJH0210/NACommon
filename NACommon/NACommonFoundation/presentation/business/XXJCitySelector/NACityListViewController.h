//
//  CityListViewController.h
//  NAiac
//
//  Created by Bird Fu on 14-7-29.
//  Copyright (c) 2014年 Enways. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocationManager.h>
#import "NACity.h"

@protocol NACityListDataSource <NSObject>

- (NSArray *)NAHotCitys;

- (NSArray *)NAAllCitys;

- (NSArray *)NASearchCity:(NSString *)keyword;

- (NACity *)NALocationCity:(CLLocation *)location;

@end

@interface NACityListViewController : UIViewController

@property(assign, nonatomic) id<NACityListDataSource> dataSource;

+ (NACity *)getSelectedCity;

+ (NACity *)getLocationedCity;

@end
