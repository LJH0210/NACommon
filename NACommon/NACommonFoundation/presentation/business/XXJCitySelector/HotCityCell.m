//
//  HotCityCell.m
//  NAiac
//
//  Created by Bird Fu on 14-8-2.
//  Copyright (c) 2014年 Enways. All rights reserved.
//

#import "HotCityCell.h"
#import "HotCityBtn.h"
#import "NACity.h"

@interface HotCityCell() <TileViewDelegate>

@end

@implementation HotCityCell

@synthesize tileView;
@synthesize cities=_cities;
@synthesize delegate;

- (void)awakeFromNib {
    tileView.horizontalSpacing = 10;
    tileView.verticalSpacing = 10;
    tileView.paddingLeft = 10;
    tileView.paddingTop = 10;
    tileView.paddingRight = 10;
    tileView.paddingBottom = 10;
    
    tileView.delegate = self;
}



- (void)setCities:(NSArray *)cities {
    _cities = cities;
    if (_cities != nil) {
        [tileView reset];
        
        NSInteger i=0;
        for (NACity *city in cities) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 36)];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitle:city.cityname forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(clickCity:) forControlEvents:UIControlEventTouchUpInside];
            btn.backgroundColor = [UIColor whiteColor];
            btn.tag = i;
            
            CGSize size = [city.cityname sizeWithFont:[UIFont systemFontOfSize:14]];
            CGFloat minWidth = 70;
            
            if (size.width > minWidth) {
                minWidth = size.width+20;
            }
            
            CGRect frame = btn.frame;
            frame.size.width = minWidth;
            btn.frame = frame;
            tileView.delegate = self;
            [tileView addSubview:btn];
            
            i++;
        }
    }
}

- (void)clickCity:(id)sender {
    HotCityBtn *btn = sender;
    
    if (delegate) {
        [delegate selectHotCity:_cities[btn.tag]];
    }
}

#pragma mark - TileViewDelegate
- (void)tileViewSizeChanged:(CGSize)size {
    CGRect frame = tileView.frame;
    frame.size.height = size.height;
    tileView.frame = frame;
}

@end
