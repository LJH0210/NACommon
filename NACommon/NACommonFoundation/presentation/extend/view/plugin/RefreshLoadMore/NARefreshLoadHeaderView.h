//
//  RefreshLoadHeaderView.h
//  SudokuCollection
//
//  Created by ND on 15/1/27.
//  Copyright (c) 2015年 ND. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PULL_AREA_HEIGTH 60.0f
#define PULL_TRIGGER_HEIGHT (PULL_AREA_HEIGTH + 5.0f)

typedef enum { NAPullStatePulling = 100, NAPullStateNomal, NAPullStateLoading, NAPullStateDone } NAPullState;

@protocol NARefreshLoadScrollDelegate <NSObject>

- (void)NAStartRefreshLoad;

@end

@interface NARefreshLoadHeaderView : UIView {
    NAPullState _state;
    UILabel *_lastUpdatedLabel;
    UILabel *_statusLabel;
}

@property(weak, nonatomic) id<NARefreshLoadScrollDelegate> delegate;

- (void)endRefreshLoad:(UIScrollView *)scrollView;
- (void)NAScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)NAScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@end
