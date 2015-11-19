//
//  UITableView+XXJKit.m
//  Common
//
//  Created by ND on 15/4/30.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import "UITableView+XXJQuick.h"

@implementation UITableView (XXJQuick)

+ (UITableView *)xxj_tableWithFrame:(CGRect)frame delegateAnddataSource:(id<UITableViewDataSource, UITableViewDelegate>)delegateDatasource {
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    [tableView setDelegate:delegateDatasource];
    [tableView setDataSource:delegateDatasource];
    return tableView;
}

@end
