//
//  NAUITableView.h
//  NACommon
//
//  Created by ND on 15/5/26.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NARefreshLoadTableView.h"

@interface NATableView : NSObject

/**
 *  返回下拉刷新 上拉加载更多UITableView
 *
 *  @param frame       frame description
 *  @param useRefresh  是否使用下拉刷新
 *  @param useLoadMore 是否使用上拉加载更多控件
 *  @param delegate     UITableViewDelegate, UITableViewDataSource, NARefreshLoadTableViewDelegate
 *
 *  @return NARefreshLoadTableView
 */
+ (NARefreshLoadTableView *)na_tableViewWithFrame:(CGRect)frame
                                         useRefresh:(BOOL)useRefresh
                                        useLoadMore:(BOOL)useLoadMore
                              delegateAndDatasource:(id<UITableViewDelegate, UITableViewDataSource, NARefreshLoadTableViewDelegate>)delegate;

/**
 *  自定义header、footer 返回下拉刷新 上拉加载更多UITableView
 *
 *  @param frame        frame description
 *  @param useRefresh   是否使用下拉刷新
 *  @param refreshName  自定义refreshheader类名
 *  @param useLoadMore  是否使用上拉加载更多控件
 *  @param loadmoreName 自定义refreshFooter类名
 *  @param delegate     UITableViewDelegate, UITableViewDataSource, NARefreshLoadTableViewDelegate
 *
 *  @return NARefreshLoadTableView实例
 */
+ (NARefreshLoadTableView *)na_tableViewWithFrame:(CGRect)frame
                                         useRefresh:(BOOL)useRefresh
                                   refreshClassName:(NSString *)refreshName
                                        useLoadMore:(BOOL)useLoadMore
                                  loadMoreClassName:(NSString *)loadmoreName
                              delegateAndDatasource:(id<UITableViewDelegate, UITableViewDataSource, NARefreshLoadTableViewDelegate>)delegate;

@end
