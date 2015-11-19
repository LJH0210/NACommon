//
//  NARefreshLoadFooterView.h
//  SudokuCollection
//
//  Created by ND on 15/1/27.
//  Copyright (c) 2015年 ND. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NARefreshLoadHeaderView.h"

@protocol NARefreshLoadMoreScrollDelegate <NSObject>

- (void)NAStartLoadMore;

@end

@interface NARefreshLoadFooterView : UIView {
    NAPullState _state;
    UILabel *_lastUpdatedLabel;
    UILabel *_statusLabel;
}

@property(assign, nonatomic) id<NARefreshLoadMoreScrollDelegate> delegate;
//传入父contentOffset用于标题坐标校验
@property(assign, nonatomic) CGPoint fatherContentOffset;

- (void)endRefreshLoad:(UIScrollView *)scrollView;
- (void)NAScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)NAScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@end
