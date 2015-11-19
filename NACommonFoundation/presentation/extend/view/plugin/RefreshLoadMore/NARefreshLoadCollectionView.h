//
//  RefreshLoadCollectionView.h
//  SudokuCollection
//
//  Created by ND on 15/1/27.
//  Copyright (c) 2015年 ND. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NARefreshLoadHeaderView.h"
#import "NARefreshLoadFooterView.h"
#import "NAMessageInterceptor.h"

@protocol NARefreshLoadCollectionViewDelegate <NSObject>

- (void)NAStartRefreshLoad:(UICollectionView *)collectionView;
- (void)NAStartLoadMore:(UICollectionView *)collectionView;

@end

@interface NARefreshLoadCollectionView : UICollectionView {
    // For intercepting the scrollView delegate messages.
    NAMessageInterceptor *_delegateInterceptor;
    NARefreshLoadHeaderView *_refreshView;
    NARefreshLoadFooterView *_loadmoreView;
}

/*上拉加载更多 下拉刷新*/
@property(assign, nonatomic) BOOL useRefresh;
@property(assign, nonatomic) BOOL useLoadMore;
@property(assign, nonatomic) id<NARefreshLoadCollectionViewDelegate> NADelegate;

//当scrollview滚动方法传递失效时实现
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@end
