//
//  UITableView+XXJKit.h
//  Common
//
//  Created by ND on 15/4/30.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (XXJKit)

/**
 *  快速创建UITableView - UITableViewStylePlain、透明背景色
 *
 *  @param frame              TableView's frame
 *  @param delegate           TableView's 委托 数据源
 *
 *  @return UITableView实例
 */
+ (UITableView *)xxj_tableWithFrame:(CGRect)frame delegateAnddataSource:(id<UITableViewDataSource, UITableViewDelegate>)delegateDatasource;

@end
