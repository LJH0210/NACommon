//
//  ISImgPickerCell.m
//  Guide
//
//  Created by LJH on 15/3/14.
//  Copyright (c) 2015年 nd. All rights reserved.
//

#import "NAImgPickerCell.h"

@implementation NAImgPickerCell

- (void)awakeFromNib {
    // Initialization code
    _imgBack.image = [UIImage imageNamed:@"icx_appraise_upload"];
    [_btDelete setBackgroundImage:[UIImage imageNamed:@"icx_appraise_delete"] forState:UIControlStateNormal];
    _labelWarm.text = @"上传凭证\n(最多三张)";
}

- (IBAction)actionDeleteSelectImg:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(imgPickerCellDeleteAtIndexPath:)]) {
        [_delegate imgPickerCellDeleteAtIndexPath:_indexPath];
    }
}
@end
