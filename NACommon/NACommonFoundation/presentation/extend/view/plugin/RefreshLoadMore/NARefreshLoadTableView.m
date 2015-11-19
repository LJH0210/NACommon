//
//  NARefreshLoadTableView.m
//  Guide
//
//  Created by ND on 15/3/23.
//  Copyright (c) 2015年 nd. All rights reserved.
//

#import "NARefreshLoadTableView.h"

@implementation NARefreshLoadTableView

-(void)dealloc{
//    [self removeObserver:self forKeyPath:@"contentOffset" context:nil];
    NSLog(@"%@ dealloc",self);
}

- (id)initWithFrame:(CGRect)frame headerClassName:(NSString *)headerClassName footerClassName:(NSString *)footerClassName{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
        headerClassName.length > 0 ? (_childRefreshLoadHeaderViewName = [[NSString alloc] initWithString:headerClassName]) : (_childRefreshLoadHeaderViewName = @"NARefreshLoadHeaderView");
        footerClassName.length > 0 ? (_childRefreshLoadFooterViewName = [[NSString alloc] initWithString:footerClassName]) : (_childRefreshLoadFooterViewName = @"NARefreshLoadFooterView");
    }
    return self;
}

- (id)init{
    self = [super init];
    if (self) {
        [self config];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
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
    self.alwaysBounceVertical = YES;
    _childRefreshLoadHeaderViewName = @"NARefreshLoadHeaderView";
    _childRefreshLoadFooterViewName = @"NARefreshLoadFooterView";
}

#pragma mark - Preserving the original behaviour
- (void)setDelegate:(id<UITableViewDelegate>)delegate{
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
            _refreshView = [[NSClassFromString(_childRefreshLoadHeaderViewName) alloc] initWithFrame:CGRectMake(0, -self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)];
            //_refreshView.backgroundColor = [UIColor redColor];
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
            _loadmoreView = [[NSClassFromString(_childRefreshLoadFooterViewName) alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height)];
            //_loadmoreView.backgroundColor = [UIColor redColor];
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
    [super reloadData];
    if (_refreshView) {
        [_refreshView endRefreshLoad:self];
    }
    if (_loadmoreView) {
        [_loadmoreView endRefreshLoad:self];
    }
    [self showBackgroundView];
}

- (void)reloadDataWithoutRefreshHeaderAndFooter {
    if (self) {
        [super reloadData];
    }
    [self showBackgroundView];
}

-(void)showBackgroundView{
    if (self.backgroundView && [self numberOfSections]>0) {
        NSInteger sectionTotal = [self numberOfSections];
        self.backgroundView.hidden = NO;
        for (int i =0 ; i<sectionTotal; i++) {
            if ([self numberOfRowsInSection:i] > 0) {
                self.backgroundView.hidden = YES;
                return;
            }
        }
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

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (_refreshView != nil)[_refreshView NAScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    if (_loadmoreView != nil) [_loadmoreView NAScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    if ([_delegateInterceptor.receiver
         respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [_delegateInterceptor.receiver scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    if (_loading) {
//        return;
//    }
//    if (_refreshView != nil)[_refreshView egoRefreshScrollViewWillBeginDragging:scrollView];
//    
    // Also forward the message to the real delegate
    if ([_delegateInterceptor.receiver
         respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [_delegateInterceptor.receiver scrollViewWillBeginDragging:scrollView];
    }
}


@end
