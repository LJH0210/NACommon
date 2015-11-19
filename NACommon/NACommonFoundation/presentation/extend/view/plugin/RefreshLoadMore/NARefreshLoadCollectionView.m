//
//  RefreshLoadCollectionView.m
//  SudokuCollection
//
//  Created by ND on 15/1/27.
//  Copyright (c) 2015年 ND. All rights reserved.
//

#import "NARefreshLoadCollectionView.h"

@interface NARefreshLoadCollectionView()<NARefreshLoadScrollDelegate,NARefreshLoadMoreScrollDelegate>
@end

@implementation NARefreshLoadCollectionView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
        
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self config];
    }
    return self;
}

-(void)config{
    _delegateInterceptor = [[NAMessageInterceptor alloc] init];
    _delegateInterceptor.middleMan = self;
    _delegateInterceptor.receiver = self.delegate;
    super.delegate = (id)_delegateInterceptor;
    self.alwaysBounceHorizontal = NO;
    self.alwaysBounceVertical = NO;
//    [self addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
}

#pragma mark - Preserving the original behaviour

- (void)setDelegate:(id<UICollectionViewDelegate>)delegate
{
    if(_delegateInterceptor) {
        super.delegate = nil;
        _delegateInterceptor.receiver = delegate;
        super.delegate = (id)_delegateInterceptor;
    } else {
        super.delegate = delegate;
    }
}

-(void)setUseRefresh:(BOOL)useRefresh{
    if (_useRefresh != useRefresh) {
        _useRefresh = useRefresh;
        if (_useRefresh && _refreshView == nil) {
            _refreshView = [[NARefreshLoadHeaderView alloc] initWithFrame:CGRectMake(0, -self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)];
            _refreshView.delegate = self;
            [self addSubview:_refreshView];
        }
        if (!_useRefresh && _refreshView != nil) {
            [_refreshView removeFromSuperview];
            _refreshView = nil;
        }
    }
}

-(void)setUseLoadMore:(BOOL)useLoadMore{
    if (_useLoadMore != useLoadMore) {
        _useLoadMore = useLoadMore;
        if (_useLoadMore && _loadmoreView == nil) {
            _loadmoreView = [[NARefreshLoadFooterView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height)];
            _loadmoreView.delegate = self;
            [self addSubview:_loadmoreView];
        }
        if (!_useLoadMore && _loadmoreView != nil) {
            [_loadmoreView removeFromSuperview];
            _loadmoreView = nil;
        }
    }
}

-(void)reloadData{
    if (self) {
        [super reloadData];
    }
    if (_refreshView) {
        [_refreshView endRefreshLoad:self];
    }
    if (_loadmoreView) {
        [_loadmoreView endRefreshLoad:self];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat visibleTableDiffBoundsHeight = (self.bounds.size.height - MIN(self.bounds.size.height, self.contentSize.height));
    CGRect loadMoreFrame = _loadmoreView.frame;
    loadMoreFrame.origin.y = self.contentSize.height + visibleTableDiffBoundsHeight;
    _loadmoreView.frame = loadMoreFrame;
}

#pragma mark refresh delegate

-(void)NAStartRefreshLoad{
    if (_NADelegate && [_NADelegate respondsToSelector:@selector(NAStartRefreshLoad:)]) {
        [_NADelegate NAStartRefreshLoad:self];
    }
}

-(void)NAStartLoadMore{
    if (_NADelegate && [_NADelegate respondsToSelector:@selector(NAStartLoadMore:)]) {
        [_NADelegate NAStartLoadMore:self];
    }
}

#pragma mark scrollview delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_refreshView != nil ) [_refreshView NAScrollViewDidScroll:scrollView];
    if (_loadmoreView != nil) [_loadmoreView NAScrollViewDidScroll:scrollView];
    if ([_delegateInterceptor.receiver respondsToSelector:@selector(scrollViewDidScroll:)]){
        [_delegateInterceptor.receiver scrollViewDidScroll:scrollView];
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_refreshView != nil)[_refreshView NAScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    if (_loadmoreView != nil) [_loadmoreView NAScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    if ([_delegateInterceptor.receiver
         respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [_delegateInterceptor.receiver scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}



@end
