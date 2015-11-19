//
//  LocatedCityCell.h
//  Xxjiac
//
//  Created by Bird Fu on 14-7-29.
//  Copyright (c) 2014年 Enways. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXJCity.h"

@interface LocatedCityCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *cityNameValue;
@property (strong, nonatomic) XXJCity *locationCity;

@end
