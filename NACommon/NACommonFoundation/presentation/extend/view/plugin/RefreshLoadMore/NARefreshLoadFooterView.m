//
//  NARefreshLoadFooterView.m
//  SudokuCollection
//
//  Created by ND on 15/1/27.
//  Copyright (c) 2015年 ND. All rights reserved.
//

#import "NARefreshLoadFooterView.h"
#import "NARefreshLoadHeaderView.h"

@implementation NARefreshLoadFooterView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
        
        [self setState:NAPullStateNomal];
    }
    return self;
}

-(void)config{
    CGFloat midY = 20;
    
    /* Config Last Updated Label */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, midY, [UIScreen mainScreen].bounds.size.width, 20.0f)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:12.0f];
    label.shadowOffset = CGSizeMake(0.0f, 1.0f);
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    _lastUpdatedLabel=label;
    
    /* Config Status Updated Label */
    label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, midY - 18, [UIScreen mainScreen].bounds.size.width, 20.0f)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:13.0f];
    label.shadowOffset = CGSizeMake(0.0f, 1.0f);
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    _statusLabel=label;
}

-(void)setState:(NAPullState)aState{
    [self stateChanged:aState];
    if(aState == NAPullStateDone) [self setState:NAPullStateNomal];
    _state = aState;
}

- (void)stateChanged:(NAPullState)astatus{
    switch (astatus) {
        case NAPullStatePulling:
            _statusLabel.text = @"释放加载更多";
            break;
        case NAPullStateNomal:
            _statusLabel.text = @"上拉加载更多";
            break;
        case NAPullStateLoading:
            _statusLabel.text = @"正在加载";
            break;
        case NAPullStateDone:
            [self setState:NAPullStateNomal];
            break;
        default:
            break;
    }
}

-(void)setFatherContentOffset:(CGPoint)fatherContentOffset{
    if (_fatherContentOffset.x != fatherContentOffset.x || _fatherContentOffset.y != fatherContentOffset.y) {
        _fatherContentOffset = fatherContentOffset;
        if ([self.superview isKindOfClass:[UIScrollView class]]) {
            UIScrollView *tmpScrollView = (UIScrollView *)self.superview;
            //横向滚动
            if (tmpScrollView.contentSize.width > tmpScrollView.bounds.size.width) {
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken, ^{
                    CGRect fra = self.frame;
                    fra.size.width = tmpScrollView.contentSize.width;
                    self.frame = fra;
                });
                CGRect fra = _lastUpdatedLabel.frame;
                fra.origin.x = _fatherContentOffset.x;
                _lastUpdatedLabel.frame = fra;
                fra = _statusLabel.frame;
                fra.origin.x = _fatherContentOffset.x;
                _statusLabel.frame = fra;
            }
        }
    }
}
-(void)endRefreshLoad:(UIScrollView *)scrollView{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3];
    UIEdgeInsets currentInsets = scrollView.contentInset;
    currentInsets.bottom = 0;
    scrollView.contentInset = currentInsets;
    [UIView commitAnimations];
    if (_state != NAPullStateDone) [self setState:NAPullStateNomal];
}
-(void)NAScrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat bottomOffset = [self scrollViewOffsetFromBottom:scrollView];
    if (_state == NAPullStatePulling && scrollView.isDragging) {
        CGFloat offset = MAX(bottomOffset * -1, 0);
        offset = MIN(offset, PULL_AREA_HEIGTH);
        UIEdgeInsets currentInsets = scrollView.contentInset;
        currentInsets.bottom = offset? offset + [self visibleTableHeightDiffWithBoundsHeight:scrollView]: 0;
//        scrollView.contentInset = currentInsets;
    }else if (scrollView.isDragging) {
        if (_state == NAPullStatePulling && bottomOffset > -PULL_TRIGGER_HEIGHT && bottomOffset < 0.0f && _state != NAPullStateLoading && _state != NAPullStateDone) {
            [self setState:NAPullStateNomal];
        } else if (_state == NAPullStateNomal && bottomOffset < -PULL_TRIGGER_HEIGHT && _state != NAPullStateLoading) {
            [self setState:NAPullStatePulling];
            
        }
        if (scrollView.contentInset.bottom != 0) {
            UIEdgeInsets currentInsets = scrollView.contentInset;
            currentInsets.bottom = 0;
            scrollView.contentInset = currentInsets;
        }
    }
}
-(void)NAScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if ([self scrollViewOffsetFromBottom:scrollView] <= - PULL_TRIGGER_HEIGHT && _state != NAPullStateLoading ) {
        if ([_delegate respondsToSelector:@selector(NAStartLoadMore)]) {
            [_delegate NAStartLoadMore];
        }
        [self setState:NAPullStateLoading];
        [self startAnimatingWithScrollView:scrollView];
    }else{
        [self setState:NAPullStateNomal];
    }
}

#pragma mark - Util
- (CGFloat)scrollViewOffsetFromBottom:(UIScrollView *) scrollView{
    CGFloat scrollAreaContenHeight = scrollView.contentSize.height;
    CGFloat visibleTableHeight = MIN(scrollView.bounds.size.height, scrollAreaContenHeight);
    CGFloat scrolledDistance = scrollView.contentOffset.y + visibleTableHeight; // If scrolled all the way down this should add upp to the content heigh.
    CGFloat normalizedOffset = scrollAreaContenHeight -scrolledDistance;
    return normalizedOffset;
}
- (CGFloat)visibleTableHeightDiffWithBoundsHeight:(UIScrollView *) scrollView
{
    return (scrollView.bounds.size.height - MIN(scrollView.bounds.size.height, scrollView.contentSize.height));
}
- (void)startAnimatingWithScrollView:(UIScrollView *) scrollView {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    UIEdgeInsets currentInsets = scrollView.contentInset;
    currentInsets.bottom = PULL_AREA_HEIGTH + [self visibleTableHeightDiffWithBoundsHeight:scrollView];
    scrollView.contentInset = currentInsets;
    [UIView commitAnimations];
    if([self scrollViewOffsetFromBottom:scrollView] == 0){
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y + PULL_TRIGGER_HEIGHT) animated:YES];
    }
}

@end
