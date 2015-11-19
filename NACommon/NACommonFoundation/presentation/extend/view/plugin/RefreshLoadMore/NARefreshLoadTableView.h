//
//  NARefreshLoadTableView.h
//  Guide
//
//  Created by ND on 15/3/23.
//  Copyright (c) 2015年 nd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NARefreshLoadHeaderView.h"
#import "NARefreshLoadFooterView.h"
#import "NAMessageInterceptor.h"

@protocol NARefreshLoadTableViewDelegate <NSObject>

- (void)NAStartRefreshLoad:(UITableView *)tableview;
- (void)NAStartLoadMore:(UITableView *)tableview;

@end

@interface NARefreshLoadTableView : UITableView <NARefreshLoadScrollDelegate, NARefreshLoadMoreScrollDelegate> {
    // For intercepting the scrollView delegate messages.
    NAMessageInterceptor *_delegateInterceptor;

    NARefreshLoadHeaderView *_refreshView;
    NSString *_childRefreshLoadHeaderViewName; //记录自定义刷新头类名,必须继承重写NARefreshLoadHeaderView

    NARefreshLoadFooterView *_loadmoreView;
    NSString *_childRefreshLoadFooterViewName; //记录自定义刷新头类名,必须继承重写NARefreshLoadFooterView
}

/*上拉加载更多 下拉刷新*/
@property(assign, nonatomic) BOOL useRefresh;
@property(assign, nonatomic) BOOL useLoadMore;
@property(assign, nonatomic) id<NARefreshLoadTableViewDelegate> NADelegate;

- (instancetype)initWithFrame:(CGRect)frame headerClassName:(NSString *)headerClassName footerClassName:(NSString *)footerClassName;

//当scrollview滚动方法传递失效时实现
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

// reload data 不改变刷新状态
- (void)reloadDataWithoutRefreshHeaderAndFooter;

@end
