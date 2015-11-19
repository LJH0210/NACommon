//
//  LocatedCityCell.m
//  NAiac
//
//  Created by Bird Fu on 14-7-29.
//  Copyright (c) 2014年 Enways. All rights reserved.
//

#import "LocatedCityCell.h"
#import "NACity.h"

@implementation LocatedCityCell

- (void)setLocationCity:(NACity *)locationCity {
    _locationCity = locationCity;
    if (_locationCity != nil) {
        _cityNameValue.text = [NSString stringWithFormat:@"当前城市-%@", locationCity.cityname];
    }
}

@end
