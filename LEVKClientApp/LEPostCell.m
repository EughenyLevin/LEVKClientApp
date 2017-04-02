//
//  LEPostCell.m
//  LEVKClientApp
//
//  Created by Evgheny on 29.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import "LEPostCell.h"

@implementation LEPostCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    NSString *likeImage =  [[NSBundle mainBundle]pathForResource:@"images" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:likeImage];
    [self.likeButton setImage:image forState:UIControlStateNormal];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)onLiekeButtonClick:(id)sender {
    
    CGAffineTransform transformScale = CGAffineTransformMakeScale(1.1, 1.1);
    _likeButton.alpha     = 0.5;
    _likeButton.transform = transformScale;
    
}

@end
