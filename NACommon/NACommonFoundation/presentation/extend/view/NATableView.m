//
//  NAUITableView.m
//  NACommon
//
//  Created by ND on 15/5/26.
//  Copyright (c) 2015年 NAia. All rights reserved.
//

#import "NATableView.h"

@implementation NATableView

+ (NARefreshLoadTableView *)na_tableViewWithFrame:(CGRect)frame
                                         useRefresh:(BOOL)useRefresh
                                        useLoadMore:(BOOL)useLoadMore
                              delegateAndDatasource:(id<UITableViewDelegate, UITableViewDataSource, NARefreshLoadTableViewDelegate>)delegate {
    return [NATableView NA_tableViewWithFrame:frame
                                     useRefresh:useRefresh
                               refreshClassName:nil
                                    useLoadMore:useLoadMore
                              loadMoreClassName:nil
                          delegateAndDatasource:delegate];
}

+ (NARefreshLoadTableView *)na_tableViewWithFrame:(CGRect)frame
                                         useRefresh:(BOOL)useRefresh
                                   refreshClassName:(NSString *)refreshName
                                        useLoadMore:(BOOL)useLoadMore
                                  loadMoreClassName:(NSString *)loadmoreName
                              delegateAndDatasource:(id<UITableViewDelegate, UITableViewDataSource, NARefreshLoadTableViewDelegate>)delegate {
    NARefreshLoadTableView *tableView = [[NARefreshLoadTableView alloc] initWithFrame:frame headerClassName:refreshName footerClassName:loadmoreName];
    tableView.useRefresh = useRefresh;
    tableView.useLoadMore = useLoadMore;
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    tableView.NADelegate = delegate;
    return tableView;
}

@end
