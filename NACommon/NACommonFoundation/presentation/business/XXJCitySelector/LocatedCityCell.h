//
//  LocatedCityCell.h
//  NAiac
//
//  Created by Bird Fu on 14-7-29.
//  Copyright (c) 2014年 Enways. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NACity.h"

@interface LocatedCityCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *cityNameValue;
@property (strong, nonatomic) NACity *locationCity;

@end
