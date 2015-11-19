//
//  RequiredTitleLabel.m
//  91Beauty
//
//  Created by chisj on 14-6-17.
//  Copyright (c) 2014年 NA. All rights reserved.
//

#import "NARequiredTitleLabel.h"
#import <CoreText/CoreText.h>

@implementation NARequiredTitleLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    if (!self.text || self.text.length == 0) {
        [super drawRect:rect];
        return;
    }
    NSMutableAttributedString *strTitle = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    [strTitle addAttributes:[NSDictionary dictionaryWithObject:self.font forKey:NSFontAttributeName] range:NSMakeRange(0, strTitle.length )];
    [strTitle addAttributes:[NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName] range:NSMakeRange(0, strTitle.length)];
    [strTitle drawInRect:CGRectMake(0, (CGRectGetMidY(rect) - (self.font.lineHeight/2.0f)), rect.size.width, rect.size.height)];
    
    //计算已有标题的宽度
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(strTitle));     CGFloat widthConstraint = rect.size.width;
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter,
                                                                        CFRangeMake(0, strTitle.length),
                                                                        NULL,
                                                                        CGSizeMake(widthConstraint, CGFLOAT_MAX),
                                                                        NULL);
    CGFloat suggestedWidth = suggestedSize.width;
    
    NSMutableAttributedString *strStar = [[NSMutableAttributedString alloc] initWithString:@"*"];
    [strStar addAttributes:[NSDictionary dictionaryWithObject:self.font forKey:NSFontAttributeName] range:NSMakeRange(0, strStar.length )];
    [strStar addAttributes:[NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName] range:NSMakeRange(0, strStar.length)];
    //在系统字体中因为*字体偏上一点 为了和strTitle对齐，将Y轴往下移2px
    [strStar drawInRect:CGRectMake(suggestedWidth, CGRectGetMidY(rect) - (self.font.lineHeight/2.0f) + 2.0, rect.size.width, rect.size.height)];
}

@end
