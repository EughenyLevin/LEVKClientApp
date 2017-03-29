//
//  LEPostCell.h
//  LEVKClientApp
//
//  Created by Evgheny on 29.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LEPostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *postView;
@property (weak, nonatomic) IBOutlet UILabel *postText;
@property (weak, nonatomic) IBOutlet UILabel *posDate;
@property (weak, nonatomic) IBOutlet UILabel *postLikes;

@end
