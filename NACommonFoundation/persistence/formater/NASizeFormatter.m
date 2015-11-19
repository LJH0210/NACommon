//
//  NASizeFormatter.m
//  NACommon
//
//  Created by  on 4/2/15.
//  Copyright (c) 2015 NAia. All rights reserved.
//

#import "NASizeFormatter.h"

@implementation NASizeFormatter

+ (CGSize)sizeForText:(NSString *)text font:(UIFont *)font tosize:(CGSize)tosize {
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary *attribute = @{NSFontAttributeName:font};
        CGSize size = [text boundingRectWithSize:tosize options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        return size;
    }
    
    CGSize size = [text sizeWithFont:font constrainedToSize:tosize lineBreakMode:NSLineBreakByWordWrapping];
    return size;
}

@end
