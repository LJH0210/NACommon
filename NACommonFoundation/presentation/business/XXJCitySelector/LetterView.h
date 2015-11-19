//
//  LetterView.h
//  NAiac
//
//  Created by Bird Fu on 14-8-2.
//  Copyright (c) 2014年 Enways. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LetterViewDelegate <NSObject>

- (void)clickLetter:(NSInteger)index;

@end

@interface LetterView : UIView

@property (strong, nonatomic) NSArray *letters;

@property (assign, nonatomic) id<LetterViewDelegate> delegate;

@end
