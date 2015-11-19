//
//  NACommonCollectionReusableView.h
//  Guide
//
//  Created by ND on 15/3/19.
//  Copyright (c) 2015年 nd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NACommonCollectionReusableView : UICollectionReusableView
@property(weak, nonatomic) IBOutlet UILabel *titleLabel;
@property(weak, nonatomic) IBOutlet UILabel *detailLabel;

@end
