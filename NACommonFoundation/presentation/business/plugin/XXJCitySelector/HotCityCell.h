//
//  HotCityCell.h
//  Xxjiac
//
//  Created by Bird Fu on 14-8-2.
//  Copyright (c) 2014年 Enways. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TileView.h"
#import "XXJCity.h"

@protocol HotCityCellDelegate <NSObject>

- (void)selectHotCity:(XXJCity *)city;

@end

@interface HotCityCell : UITableViewCell

@property(strong, nonatomic) IBOutlet TileView *tileView;
@property(strong, nonatomic) NSArray *cities;

@property(assign, nonatomic) id<HotCityCellDelegate> delegate;

@end
