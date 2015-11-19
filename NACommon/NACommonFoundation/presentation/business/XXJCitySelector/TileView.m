//
//  TileView.m
//  EnwaysFoundation
//
//  Created by Jackson Fu on 3/12/12.
//  Copyright (c) 2012 厦门英睿信息科技有限公司. All rights reserved.
//

#import "TileView.h"

@interface TileView () {
    
@private
    int lastX;
    int lastY;
    
    CGRect originFrame;
}

@end

@implementation TileView

@synthesize delegate, horizontalSpacing, verticalSpacing;
@synthesize paddingTop = _paddingTop, paddingLeft = _paddingLeft, paddingRight, paddingBottom;

- (id)init {
    [self initComponents];
    return [super init];
}

- (id)initWithFrame:(CGRect)frame {
    [self initComponents];  
    originFrame = frame;
    return [super initWithFrame:frame];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    [self initComponents];
    id identify = [super initWithCoder:aDecoder];
    
    originFrame = self.frame;
    
    return identify;
}

- (void)initComponents {
    horizontalSpacing = 10;
    verticalSpacing = 10;
}

- (void)setPaddingLeft:(int)paddingLeft {
    _paddingLeft = paddingLeft;
    lastX = paddingLeft;
}

- (void)setPaddingTop:(int)paddingTop {
    _paddingTop = paddingTop;
    lastY = paddingTop;
}

- (void)addSubview:(UIView *)view {
    CGRect frame = self.frame;
    CGRect subViewFrame = view.frame;
    
    if (lastX + subViewFrame.size.width + horizontalSpacing + paddingRight > frame.size.width) {
        lastX = _paddingLeft;
        lastY += subViewFrame.size.height + verticalSpacing;
    }
    
    subViewFrame.origin.x = lastX;
    subViewFrame.origin.y = lastY;
    view.frame = subViewFrame;
    
    [super addSubview:view];
    
    lastX += subViewFrame.size.width + horizontalSpacing;
    int totalHeight = lastY + subViewFrame.size.height + paddingBottom;
        
    if (frame.size.height < totalHeight) {
        frame.size.height = totalHeight;
        self.frame = frame;
        
        if (delegate != nil) {
            [delegate tileViewSizeChanged:frame.size];
        }
    }
    
}

- (void)reset {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    lastX = _paddingLeft;
    lastY = _paddingTop;
    
    self.frame = originFrame;
}

@end
