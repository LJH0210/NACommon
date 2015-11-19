//
//  LocatedCityCell.m
//  Xxjiac
//
//  Created by Bird Fu on 14-7-29.
//  Copyright (c) 2014年 Enways. All rights reserved.
//

#import "LocatedCityCell.h"
#import "XXJCity.h"

@implementation LocatedCityCell

- (void)setLocationCity:(XXJCity *)locationCity {
    _locationCity = locationCity;
    if (_locationCity != nil) {
        _cityNameValue.text = [NSString stringWithFormat:@"当前城市-%@", locationCity.cityname];
    }
}

@end
