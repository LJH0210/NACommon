//
//  LetterView.m
//  NAiac
//
//  Created by Bird Fu on 14-8-2.
//  Copyright (c) 2014年 Enways. All rights reserved.
//

#import "LetterView.h"

@implementation LetterView

@synthesize letters=_letters;
@synthesize delegate;

- (void)setLetters:(NSArray *)letters {
    self.backgroundColor = [UIColor clearColor];
    _letters = letters;
    for (UIView *v  in self.subviews) {
        [v removeFromSuperview];
    }
    CGFloat y = 0;
    for (NSString *letter in _letters) {
        UILabel *label = [[UILabel alloc] init];
        
        CGRect frame = label.frame;
        frame.origin.x = 0;
        frame.origin.y = y;
        frame.size.width = self.frame.size.width;
        frame.size.height = 21;
        label.frame = frame;
        
        label.text = letter;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor colorWithRed:80.0/255 green:80.0/255 blue:80.0/255 alpha:1];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        
        [self addSubview:label];
        
        y+=21;
    }
    
    CGRect frame = self.frame;
    frame.size.height = letters.count*10;
    self.frame = frame;
}



- (void)didClickEvent:(NSSet *)touches {
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self];
    
    NSInteger index = location.y / 21;
    if (delegate) {
        [delegate clickLetter:index];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self didClickEvent:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    [self didClickEvent:touches];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
}

@end
