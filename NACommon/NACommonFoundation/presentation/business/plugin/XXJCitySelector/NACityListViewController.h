//
//  CityListViewController.h
//  Xxjiac
//
//  Created by Bird Fu on 14-7-29.
//  Copyright (c) 2014年 Enways. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocationManager.h>
#import "XXJCity.h"

@protocol XXJCityListDataSource <NSObject>

- (NSArray *)xxjHotCitys;

- (NSArray *)xxjAllCitys;

- (NSArray *)xxjSearchCity:(NSString *)keyword;

- (XXJCity *)xxjLocationCity:(CLLocation *)location;

@end

@interface XXJCityListViewController : UIViewController

@property(assign, nonatomic) id<XXJCityListDataSource> dataSource;

+ (XXJCity *)getSelectedCity;

+ (XXJCity *)getLocationedCity;

@end
