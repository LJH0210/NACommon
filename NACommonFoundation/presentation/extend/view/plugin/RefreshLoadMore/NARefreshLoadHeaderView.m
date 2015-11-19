//
//  RefreshLoadHeaderView.m
//  SudokuCollection
//
//  Created by ND on 15/1/27.
//  Copyright (c) 2015年 ND. All rights reserved.
//

#import "NARefreshLoadHeaderView.h"

@interface NARefreshLoadHeaderView () <UIScrollViewDelegate>

- (void)setState:(NAPullState)aState;

@end

@implementation NARefreshLoadHeaderView

- (void)dealloc {
    //    [self removeObserver:self.superview forKeyPath:@"contentOffset"];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self config];

        [self setState:NAPullStateNomal];
    }
    return self;
}

- (void)config {

    CGFloat midY = self.frame.size.height - PULL_AREA_HEIGTH / 2;

    /* Config Last Updated Label */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, midY, self.frame.size.width, 20.0f)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:12.0f];
    label.shadowOffset = CGSizeMake(0.0f, 1.0f);
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    _lastUpdatedLabel = label;

    /* Config Status Updated Label */
    label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, midY - 18, self.frame.size.width, 20.0f)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:13.0f];
    label.shadowOffset = CGSizeMake(0.0f, 1.0f);
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    _statusLabel = label;
}

- (void)setState:(NAPullState)aState {
    [self stateChanged:aState];
    if (aState == NAPullStateDone)
        [self setState:NAPullStateNomal];
    _state = aState;
}

- (void)stateChanged:(NAPullState)astatus {
    switch (astatus) {
    case NAPullStatePulling:
        _statusLabel.text = @"释放刷新";
        break;
    case NAPullStateNomal:
        _statusLabel.text = @"下拉刷新";
        break;
    case NAPullStateLoading:
        _statusLabel.text = @"正在刷新";
        break;
    case NAPullStateDone:
        [self setState:NAPullStateNomal];
        break;
    default:
        break;
    }
}

- (void)endRefreshLoad:(UIScrollView *)scrollView {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.4];
    UIEdgeInsets currentInsets = scrollView.contentInset;
    currentInsets.top = 0;
    scrollView.contentInset = currentInsets;
    [UIView commitAnimations];
    [self setState:NAPullStateNomal];
}

- (void)NAScrollViewDidScroll:(UIScrollView *)scrollView {
    if (_state == NAPullStateLoading) {
        CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
        offset = MIN(offset, PULL_AREA_HEIGTH);
        UIEdgeInsets currentInsets = scrollView.contentInset;
        currentInsets.top = offset;
        scrollView.contentInset = currentInsets;
    } else if (scrollView.isDragging) {
        if (_state == NAPullStatePulling && scrollView.contentOffset.y > -PULL_TRIGGER_HEIGHT && scrollView.contentOffset.y < 0.0f &&
            _state != NAPullStateLoading) {
            [self setState:NAPullStateNomal];
        } else if (_state == NAPullStateNomal && scrollView.contentOffset.y < -PULL_TRIGGER_HEIGHT && _state != NAPullStateLoading) {
            [self setState:NAPullStatePulling];
        }
        if (scrollView.contentInset.top != 0) {
            UIEdgeInsets currentInsets = scrollView.contentInset;
            currentInsets.top = 0;
            scrollView.contentInset = currentInsets;
        }
    }
}

- (void)NAScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.y <= -PULL_TRIGGER_HEIGHT && _state != NAPullStateLoading) {
        if ([_delegate respondsToSelector:@selector(NAStartRefreshLoad)]) {
            [_delegate NAStartRefreshLoad];
        }
        [self setState:NAPullStateLoading];
    }
}

@end
