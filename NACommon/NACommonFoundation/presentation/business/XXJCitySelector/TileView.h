//
//  TileView.h
//  EnwaysFoundation
//
//  Created by Jackson Fu on 3/12/12.
//  Copyright (c) 2012 厦门英睿信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TileViewDelegate <NSObject>

- (void)tileViewSizeChanged:(CGSize)size;

@end

@interface TileView : UIView

@property (strong, nonatomic) NSObject<TileViewDelegate> *delegate;

@property (nonatomic) int paddingLeft;
@property (nonatomic) int paddingTop;
@property (nonatomic) int paddingRight;
@property (nonatomic) int paddingBottom;
@property (nonatomic) int horizontalSpacing;
@property (nonatomic) int verticalSpacing;

- (void)reset;

@end
