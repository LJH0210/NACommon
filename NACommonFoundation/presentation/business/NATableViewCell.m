//
//  XXJTableViewCell.m
//  XXJCommon
//
//  Created by ND on 15/6/12.
//  Copyright (c) 2015年 xxjia. All rights reserved.
//

#import "XXJTableViewCell.h"

@implementation XXJTableViewCell

- (instancetype)initWithXXJStyle:(XXJTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self config:style];
    }
    return self;
}

- (void)config:(XXJTableViewCellStyle)style {
}

@end
